from typing import Callable, TypeAlias, Dict
import asyncio
from enum import Enum, auto
import prompt_toolkit
import prompt_toolkit.key_binding
import prompt_toolkit.key_binding.vi_state
import prompt_toolkit.layout
import prompt_toolkit.buffer
import prompt_toolkit.enums
import prompt_toolkit.cursor_shapes
import prompt_toolkit.filters
import prompt_toolkit.widgets
import prompt_toolkit.styles


class Direction(Enum):
    Horizontal = auto()
    Vertical = auto()


Factory: TypeAlias = Callable[[], prompt_toolkit.layout.AnyContainer]


STYLE = {
    'focus': 'reverse',
}


class SplitNode(prompt_toolkit.layout.DynamicContainer):
    def __init__(self, kb: prompt_toolkit.key_binding.KeyBindings, factory: Factory, container: prompt_toolkit.layout.AnyContainer):
        self.kb = kb
        self.factory = factory
        self.container = container
        self.has_focus = prompt_toolkit.filters.has_focus(self.container)
        self.add_key_binding(self.split_vertical, 'c-w', 'v')
        self.add_key_binding(self.split_horizontal, 'c-w', 's')
        super().__init__(lambda: self.container)

    def add_key_binding(self, callback: Callable[[prompt_toolkit.key_binding.KeyPressEvent], None], *args, **kw):
        self.kb.add(*args, **kw, filter=self.has_focus)(callback)

    def split_vertical(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        new_node = SplitNode(self.kb, self.factory, self.factory())
        self.container = prompt_toolkit.layout.VSplit(
            [self.container,
             prompt_toolkit.layout.Window(char='|', width=1),
             new_node])
        e.app.invalidate()
        e.app.layout.focus(new_node)

    def split_horizontal(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        new_node = SplitNode(self.kb, self.factory, self.factory())
        self.container = prompt_toolkit.layout.HSplit(
            [self.container,
             prompt_toolkit.layout.Window(char='-', height=1),
             new_node])
        e.app.invalidate()
        e.app.layout.focus(new_node)


class SampleWindow:
    def __init__(self) -> None:
        self.buffer = prompt_toolkit.buffer.Buffer()
        self.control = prompt_toolkit.layout.BufferControl(self.buffer)
        self.container = prompt_toolkit.layout.Window(
            self.control, style=lambda: 'class:focus' if self.has_focus()else'')
        self.has_focus = prompt_toolkit.filters.has_focus(self.buffer)

    def __pt_container__(self):
        return self.container


def factory() -> prompt_toolkit.layout.AnyContainer:
    return SampleWindow()


async def main():
    kb = prompt_toolkit.key_binding.KeyBindings()

    root = SplitNode(kb, factory, factory())
    app = prompt_toolkit.Application(
        layout=prompt_toolkit.layout.Layout(root),
        full_screen=True,
        key_bindings=kb,
        editing_mode=prompt_toolkit.enums.EditingMode.VI,
        cursor=prompt_toolkit.cursor_shapes.CursorShape.BLINKING_BLOCK,
        style=prompt_toolkit.styles.Style.from_dict(STYLE),
    )

    @ kb.add('q', eager=True)
    def quit(e: prompt_toolkit.key_binding.KeyPressEvent):
        app.exit()

    def pre_run():
        # Start in navigation mode.
        app.vi_state.input_mode = prompt_toolkit.key_binding.vi_state.InputMode.NAVIGATION

    await app.run_async(pre_run=pre_run)


if __name__ == '__main__':
    asyncio.run(main())
