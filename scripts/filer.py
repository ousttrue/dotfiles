from typing import List, NamedTuple, Tuple, Iterable, Optional, Callable, cast
import asyncio
import pathlib
from wcwidth import wcswidth
from prompt_toolkit.application.current import get_app
import prompt_toolkit
import prompt_toolkit.layout
import prompt_toolkit.key_binding
import prompt_toolkit.key_binding.vi_state
import prompt_toolkit.styles
import prompt_toolkit.enums
import prompt_toolkit.cursor_shapes
import prompt_toolkit.buffer
import prompt_toolkit.filters
import prompt_toolkit.data_structures
import prompt_toolkit.utils
import prompt_toolkit.widgets
STYLE = prompt_toolkit.styles.Style.from_dict({
    'dir': '#00FF00',
    'linkdir': '#007700',
    'file': '#00FFFF',
    'linkfile': '#007777',
    'hover': 'reverse',
    'addressbar': 'reverse',
})


class FileItem(NamedTuple):
    path: pathlib.Path
    name_wc: int


class FileList:
    def __init__(self, width: int) -> None:
        self.dir = None
        self.invalidated = prompt_toolkit.utils.Event(self)
        self.items: List[FileItem] = []
        self._text_cache = None
        self.width = width
        self.selected_index = 0

    def __len__(self) -> int:
        return len(self.items)

    def __getitem__(self, i: int) -> Optional[pathlib.Path]:
        if i < 0 or i >= len(self.items):
            return None
        return self.items[i][0]

    @property
    def selected(self) -> Optional[pathlib.Path]:
        if self.selected_index < 0 or self.selected_index >= len(self.items):
            return
        return self.items[self.selected_index].path

    def get_text(self) -> List[Tuple[str, str]]:
        if not self.dir:
            return []

        if self.width == 0:
            return []

        if not isinstance(self._text_cache, list):
            def wc_padding(text, l):
                return text + ' ' * max(0, (max(self.max_wc, self.width-2) - l))

            def to_text(f: pathlib.Path, l: int) -> Tuple[str, str]:
                if f.is_symlink():
                    if f.is_dir():
                        return ('class:linkdir', ' ' + wc_padding(f.name, l) + '\n')
                    else:
                        return ('class:linkfile', ' ' + wc_padding(f.name, l) + '\n')
                else:
                    if f.is_dir():
                        return ('class:dir', ' ' + wc_padding(f.name, l) + '\n')
                    else:
                        return ('class:file', ' ' + wc_padding(f.name, l) + '\n')

            self._text_cache = []
            for f, l in self.items:
                fragment = to_text(f, l)
                new_len = len(fragment[1])
                # assert(new_len == self.width)
                self._text_cache.append(fragment)

        return self._text_cache

    def set_width(self, w):
        if w == self.width:
            return
        self.width = w
        self._text_cache = None

        def fire():
            self.invalidated.fire()
        asyncio.get_event_loop().call_soon_threadsafe(fire)

    def chdir(self, dir: pathlib.Path, select_target: Optional[pathlib.Path]):
        dir = dir.absolute()
        if dir.is_symlink():
            dir = dir.resolve()
        if self.dir == dir:
            return
        assert(dir.is_dir())
        self.dir = dir
        self.items = []
        self.selected_index = 0
        for i, f in enumerate(self.dir.iterdir()):
            self.items.append(FileItem(f, wcswidth(f.name)))
            if f == select_target:
                self.selected_index = i
        self.max_wc = max(l for f, l in self.items) if self.items else 0
        self._text_cache = None
        self.invalidated.fire()

    def go_parent(self, e) -> Optional[int]:
        assert(self.dir)
        if self.dir.parent == self.dir:
            return
        self.chdir(self.dir.parent, self.dir)

    def go_selected(self, e):
        item = self.items[self.selected_index][0]
        if item and item.is_dir():
            try:
                self.chdir(item, None)
                self.selected_index = 0
            except PermissionError:
                # TODO
                pass

    def select(self, selected: int):
        if self.selected_index == selected:
            return
        if selected < 0 or selected >= len(self.items):
            return
        self.selected_index = selected
        self.invalidated.fire()

    def up(self, e):
        self.select(self.selected_index-1)

    def down(self, e):
        self.select(self.selected_index+1)


class Selector(prompt_toolkit.layout.FormattedTextControl):
    def __init__(self, kb: prompt_toolkit.key_binding.KeyBindings, items: FileList) -> None:
        super().__init__(
            items.get_text,
            focusable=True,
            get_cursor_position=lambda: prompt_toolkit.data_structures.Point(0, self.items.selected_index))
        self.has_focus = prompt_toolkit.filters.has_focus(self)
        self.items = items
        self.kb = kb

        self._keybind(self.items.go_parent, 'left')
        self._keybind(self.items.go_parent, 'h')
        self._keybind(self.items.go_selected, 'l')
        self._keybind(self.items.go_selected, 'enter')
        self._keybind(self.items.up, 'up')
        self._keybind(self.items.up, 'k')
        self._keybind(self.items.down, 'down')
        self._keybind(self.items.down, 'j')

    def _keybind(self, callback, *args, **kw):
        self.kb.add(*args, **kw, filter=self.has_focus)(callback)

    def get_invalidate_events(self) -> Iterable[prompt_toolkit.utils.Event[object]]:
        return [self.items.invalidated]

    def create_content(self, *args):
        content = super().create_content(*args)
        get_line = content.get_line

        def highlight_selected(line_index: int) -> List[Tuple[str, str]]:
            try:
                line = cast(List[Tuple[str, str]], get_line(line_index))
                if line_index == self.items.selected_index:
                    line = [(style + ' class:selected', text)
                            for style, text in line]
                return line
            except IndexError:
                return []

        content.get_line = highlight_selected  # type: ignore
        return content


class Preview:
    def __init__(self) -> None:
        self.text_area = prompt_toolkit.widgets.TextArea(
            read_only=True,
            scrollbar=True,
            line_numbers=True,
        )

    def __pt_container__(self):
        return self.text_area


async def main():
    kb = prompt_toolkit.key_binding.KeyBindings()

    fl = FileList(25)

    @ kb.add('Q')
    def quit(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.exit()

    selector = prompt_toolkit.layout.Window(Selector(kb, fl), width=25)

    preview = Preview()

    @kb.add('tab', filter=prompt_toolkit.filters.has_focus(selector))
    def focus_preview(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.layout.focus(preview)

    @kb.add('tab', filter=prompt_toolkit.filters.has_focus(preview))
    def focus_selector(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.layout.focus(selector)

    def on_invalidated(_):
        s = fl.selected
        if not s:
            return
        if s.is_dir():
            try:
                preview.text_area.text = '\n'.join(f.name for f in s.iterdir())
            except Exception as e:
                preview.text_area.text = str(e)
        else:
            try:
                preview.text_area.text = s.read_text()
            except Exception as e:
                preview.text_area.text = str(e)

    fl.invalidated += on_invalidated

    root = prompt_toolkit.layout.HSplit([
        prompt_toolkit.widgets.FormattedTextToolbar(
            lambda: f'{fl.dir}', 'class:addressbar'),
        prompt_toolkit.layout.VSplit([
            selector,
            prompt_toolkit.layout.Window(char='|', width=1),
            preview,
        ])])

    app = prompt_toolkit.Application(
        full_screen=True,
        layout=prompt_toolkit.layout.Layout(root, selector),
        key_bindings=kb,
        enable_page_navigation_bindings=True,
        style=STYLE,
        editing_mode=prompt_toolkit.enums.EditingMode.VI,
        cursor=prompt_toolkit.cursor_shapes.CursorShape.BLOCK,
    )

    def pre_run():
        app.vi_state.input_mode = prompt_toolkit.key_binding.vi_state.InputMode.NAVIGATION
        fl.chdir(pathlib.Path('.'),  None)
        # def on_rendered(_):
        #     assert(selector.render_info)
        #     fl.set_width(selector.render_info.window_width)
        # app.after_render += on_rendered

    await app.run_async(pre_run=pre_run)

if __name__ == '__main__':
    asyncio.run(main())
