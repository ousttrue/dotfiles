from typing import List, Tuple
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

STYLE = prompt_toolkit.styles.Style.from_dict({
    'dir': '#00FF00',
    'file': '#00FFFF',
})


class FileSelector:
    def __init__(self, kb: prompt_toolkit.key_binding.KeyBindings, current: pathlib.Path) -> None:
        self.kb = kb
        self._readonly = True
        self.buffer = prompt_toolkit.buffer.Buffer(
            read_only=prompt_toolkit.filters.Condition(lambda: self._readonly))
        self.control = prompt_toolkit.layout.BufferControl(self.buffer)
        self.container = prompt_toolkit.layout.Window(self.control)
        self.dir = None
        self.chdir(current)

        self._keybind(self.go_parent, 'left')

    def __pt_container__(self):
        return self.container

    def _keybind(self, callback, *args, **kw):
        self.kb.add(*args, **kw)(callback)

    def go_parent(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        assert(self.dir)
        self.chdir(self.dir.parent)

    def chdir(self, dir: pathlib.Path):
        dir = dir.absolute()
        if self.dir == dir:
            return
        assert(dir.is_dir())
        self.dir = dir
        self._readonly = False
        self.buffer.text = '\n'.join(f'{f.name}' for f in self.dir.iterdir())
        self._readonly = True


async def main():
    kb = prompt_toolkit.key_binding.KeyBindings()

    @ kb.add('Q')
    def quit(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.exit()

    root = FileSelector(kb, pathlib.Path('.'))

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
