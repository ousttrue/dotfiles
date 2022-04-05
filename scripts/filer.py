from typing import List, Tuple, Iterable, Optional
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


class FileSelector(prompt_toolkit.layout.FormattedTextControl):
    def __init__(self, kb: prompt_toolkit.key_binding.KeyBindings, current: pathlib.Path) -> None:
        super().__init__(
            self._get_text,
            focusable=True,
            get_cursor_position=lambda: prompt_toolkit.data_structures.Point(0, self.selected))
        self._text_cache: Optional[List[Tuple[str, str]]] = None
        self.selected = 0
        self.max_wc_width = 0

        self.invalidated = prompt_toolkit.utils.Event(self)
        self.dir = None
        self.chdir(current)

        self.kb = kb
        self._keybind(self.go_parent, 'left')
        self._keybind(self.up, 'up')
        self._keybind(self.up, 'k')
        self._keybind(self.down, 'down')
        self._keybind(self.down, 'j')

    def get_invalidate_events(self) -> Iterable[prompt_toolkit.utils.Event[object]]:
        return [self.invalidated]

    def create_content(self, *args):
        content = super().create_content(*args)
        get_line = content.get_line

        def highlight_selected(line_index: int):
            line: List[Tuple[str, str]] = get_line(line_index)
            if line_index == self.selected:
                line = [(style + ' class:selected', text)
                        for style, text in line]
            return line
        content.get_line = highlight_selected
        return content

    def _keybind(self, callback, *args, **kw):
        self.kb.add(*args, **kw)(callback)

    def _get_text(self) -> List[Tuple[str, str]]:
        assert(self.dir)
        if not isinstance(self._text_cache, list):
            items = [(f, wcswidth(f.name)) for f in self.dir.iterdir()]
            max_wc = max(l for f, l in items)

            def wc_padding(text, l):
                return text + ' ' * max(0, (max_wc - l))

            def to_text(f: pathlib.Path, l: int) -> Tuple[str, str]:
                if f.is_dir():
                    return ('class:dir', ' ' + wc_padding(f.name, l) + '\n')
                else:
                    return ('class:file', ' ' + wc_padding(f.name, l) + '\n')

            self._text_cache = []
            for f, l in items:
                fragment = to_text(f, l)
                w = wcswidth(fragment[1])
                if w > self.max_wc_width:
                    self.max_wc_width = w
                self._text_cache.append(fragment)

        return self._text_cache

    def select(self, selected: int):
        if self.selected == selected:
            return
        if not self._text_cache or selected < 0 or selected >= len(self._text_cache):
            return

        self.selected = selected
        self.invalidated.fire()

    def up(self, e):
        self.select(self.selected-1)

    def down(self, e):
        self.select(self.selected+1)

    def go_parent(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        assert(self.dir)
        self.chdir(self.dir.parent)
        self.select(0)

    def chdir(self, dir: pathlib.Path):
        dir = dir.absolute()
        if self.dir == dir:
            return
        assert(dir.is_dir())
        self.dir = dir
        self._text_cache = None


async def main():
    kb = prompt_toolkit.key_binding.KeyBindings()

    @ kb.add('Q')
    def quit(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.exit()

    selector = FileSelector(kb, pathlib.Path('.'))
    root = prompt_toolkit.layout.Window(selector)

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

    await app.run_async(pre_run=pre_run)

if __name__ == '__main__':
    asyncio.run(main())
