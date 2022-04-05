from typing import List, Tuple, Iterable, Optional, Callable, cast
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
STYLE = prompt_toolkit.styles.Style.from_dict({
    'dir': '#00FF00',
    'file': '#00FFFF',
    'hover': 'reverse',
})


class FileList:
    def __init__(self, width: int) -> None:
        self.dir = None
        self.invalidated = prompt_toolkit.utils.Event(self)
        self.items = []
        self._text_cache = None
        self.width = width

    def __len__(self) -> int:
        return len(self.items)

    def __getitem__(self, i: int) -> Optional[pathlib.Path]:
        if i < 0 or i >= len(self.items):
            return None
        return self.items[i][0]

    def set_width(self, w):
        if w == self.width:
            return
        self.width = w
        self._text_cache = None

        def fire():
            self.invalidated.fire()
        asyncio.get_event_loop().call_soon_threadsafe(fire)

    def go_parent(self) -> int:
        assert(self.dir)
        current = self.dir
        self.chdir(self.dir.parent)
        for i, (f, l) in enumerate(self.items):
            if f == current:
                return i
        raise Exception()

    def chdir(self, dir: pathlib.Path):
        dir = dir.absolute()
        if self.dir == dir:
            return
        assert(dir.is_dir())
        self.dir = dir
        self.items = [(f, wcswidth(f.name)) for f in self.dir.iterdir()]
        self.max_wc = max(l for f, l in self.items) if self.items else 0
        self._text_cache = None
        self.invalidated.fire()

    def get_text(self) -> List[Tuple[str, str]]:
        if not self.dir:
            return []

        if self.width == 0:
            return []

        if not isinstance(self._text_cache, list):
            def wc_padding(text, l):
                return text + ' ' * max(0, (max(self.max_wc, self.width-2) - l))

            def to_text(f: pathlib.Path, l: int) -> Tuple[str, str]:
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


class Selector(prompt_toolkit.layout.FormattedTextControl):
    def __init__(self, kb: prompt_toolkit.key_binding.KeyBindings, items: FileList) -> None:
        super().__init__(
            items.get_text,
            focusable=True,
            get_cursor_position=lambda: prompt_toolkit.data_structures.Point(0, self.selected))
        self.selected = 0
        self.items = items

        self.selection_changed = prompt_toolkit.utils.Event(self)
        self.kb = kb

        def go_parent(e):
            self.selected = self.items.go_parent()
        self._keybind(go_parent, 'left')
        self._keybind(go_parent, 'h')

        def go_selected(e):
            item = self.items[self.selected]
            if item and item.is_dir():
                self.items.chdir(item)
                self.selected = 0
        self._keybind(go_selected, 'l')
        self._keybind(self.up, 'up')
        self._keybind(self.up, 'k')
        self._keybind(self.down, 'down')
        self._keybind(self.down, 'j')

    def _keybind(self, callback, *args, **kw):
        self.kb.add(*args, **kw)(callback)

    def get_invalidate_events(self) -> Iterable[prompt_toolkit.utils.Event[object]]:
        return [self.items.invalidated, self.selection_changed]

    def select(self, selected: int) -> bool:
        if self.selected == selected:
            return False
        if selected < 0 or selected >= len(self.items):
            return False
        self.selected = selected
        self.selection_changed.fire()
        return True

    def create_content(self, *args):
        content = super().create_content(*args)
        get_line = content.get_line

        def highlight_selected(line_index: int) -> List[Tuple[str, str]]:
            try:
                line = cast(List[Tuple[str, str]], get_line(line_index))
                if line_index == self.selected:
                    line = [(style + ' class:selected', text)
                            for style, text in line]
                return line
            except IndexError:
                return []

        content.get_line = highlight_selected  # type: ignore
        return content

    def up(self, e):
        self.select(self.selected-1)

    def down(self, e):
        self.select(self.selected+1)


async def main():
    kb = prompt_toolkit.key_binding.KeyBindings()

    fl = FileList(25)
    fl.chdir(pathlib.Path('.'))

    @ kb.add('Q')
    def quit(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.exit()

    selector = prompt_toolkit.layout.Window(Selector(kb, fl), width=25)
    root = prompt_toolkit.layout.VSplit([
        selector,
        prompt_toolkit.layout.Window(char='|', width=1),
        prompt_toolkit.layout.Window()
    ])

    app = prompt_toolkit.Application(
        full_screen=True,
        layout=prompt_toolkit.layout.Layout(root, selector),
        key_bindings=kb,
        style=STYLE,
        editing_mode=prompt_toolkit.enums.EditingMode.VI,
        cursor=prompt_toolkit.cursor_shapes.CursorShape.BLOCK,
    )

    def pre_run():
        app.vi_state.input_mode = prompt_toolkit.key_binding.vi_state.InputMode.NAVIGATION

        # def on_rendered(_):
        #     assert(selector.render_info)
        #     fl.set_width(selector.render_info.window_width)
        # app.after_render += on_rendered

    await app.run_async(pre_run=pre_run)

if __name__ == '__main__':
    asyncio.run(main())
