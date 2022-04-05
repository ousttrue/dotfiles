from typing import List, Tuple, Iterable
import asyncio
import pathlib
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
            lambda: self.text,
            focusable=True,
            get_cursor_position=lambda: prompt_toolkit.data_structures.Point(0, self.selected))
        self.text: List[Tuple[str, str]] = []
        self.selected = 0

        self.dir = None
        self.chdir(current)

        self.kb = kb
        self._keybind(self.go_parent, 'left')
        self._keybind(self.up, 'up')
        self._keybind(self.up, 'k')
        self._keybind(self.down, 'down')
        self._keybind(self.down, 'j')

        self.on_selected = prompt_toolkit.utils.Event(self)

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

    def select(self, selected: int):
        if self.selected == selected:
            return
        if selected < 0 or selected >= len(self.text):
            return

        self.selected = selected
        self.on_selected.fire()

    def up(self, e):
        self.select(self.selected-1)

    def down(self, e):
        self.select(self.selected+1)

    def go_parent(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        assert(self.dir)
        self.chdir(self.dir.parent)

    def chdir(self, dir: pathlib.Path):
        dir = dir.absolute()
        if self.dir == dir:
            return
        assert(dir.is_dir())
        self.dir = dir

        def to_text(f: pathlib.Path) -> Tuple[str, str]:
            if f.is_dir():
                return ('class:dir', f' {f.name}\n')
            else:
                return ('class:file', f' {f.name}\n')

        self.text = [to_text(f) for f in self.dir.iterdir()]


async def main():
    kb = prompt_toolkit.key_binding.KeyBindings()

    @ kb.add('Q')
    def quit(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.exit()

    root = prompt_toolkit.layout.Window(
        FileSelector(kb, pathlib.Path('.')))

    app = prompt_toolkit.Application(
        full_screen=True,
        layout=prompt_toolkit.layout.Layout(root, root),
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
