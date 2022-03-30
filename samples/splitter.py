'''
vim like nested splitter
'''
from typing import Callable, Optional, NamedTuple, List, Iterable, Tuple
import asyncio
from enum import Enum, auto
from prompt_toolkit.application.current import get_app
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
import prompt_toolkit.utils


class Direction(Enum):
    Horizontal = auto()
    Vertical = auto()


STYLE = {
    'focus': 'reverse',
}


class Rect(NamedTuple):
    left: int
    top: int
    width: int
    height: int

    def __str__(self) -> str:
        return f'{self.left}x{self.top}+{self.width}+{self.height}'

    @property
    def right(self) -> int:
        return self.left + self.width

    @property
    def bottom(self) -> int:
        return self.top + self.height

    @staticmethod
    def from_window(w: prompt_toolkit.layout.Window) -> 'Rect':
        info = w.render_info
        if info:
            return Rect(info._x_offset, info._y_offset, info.window_width, info.window_height)
        else:
            return Rect(0, 0, 0, 0)

    @staticmethod
    def from_container(c: prompt_toolkit.layout.AnyContainer) -> 'Rect':
        w = prompt_toolkit.layout.to_container(c)
        assert isinstance(w, prompt_toolkit.layout.Window)
        return Rect.from_window(w)


def is_overlap_vertically(lhs: Rect, rhs: Rect) -> bool:
    if lhs.top > rhs.bottom or rhs.top > lhs.bottom:
        return False
    return True


def is_left(lhs: Rect, rhs: Rect) -> bool:
    return is_overlap_vertically(lhs, rhs) and lhs.right < rhs.left


def is_right(lhs: Rect, rhs: Rect) -> bool:
    return is_overlap_vertically(lhs, rhs) and rhs.right < lhs.left


def is_overlap_horizontally(lhs: Rect, rhs: Rect) -> bool:
    if lhs.left > rhs.right or rhs.left > lhs.right:
        return False
    return True


def is_up(lhs: Rect, rhs: Rect) -> bool:
    return is_overlap_horizontally(lhs, rhs) and lhs.bottom < rhs.top


def is_down(lhs: Rect, rhs: Rect) -> bool:
    return is_overlap_horizontally(lhs, rhs) and rhs.bottom < lhs.top


def _find_all(layout: prompt_toolkit.layout.Layout, target: prompt_toolkit.layout.AnyContainer, pred) -> Iterable[Tuple[prompt_toolkit.layout.AnyContainer, Rect]]:
    r = Rect.from_container(target)
    for c in layout.find_all_windows():
        if c == target:
            continue
        cr = Rect.from_container(c)
        if pred(cr, r):
            yield c, cr


def left_from(layout: prompt_toolkit.layout.Layout, target: prompt_toolkit.layout.AnyContainer) -> Optional[prompt_toolkit.layout.AnyContainer]:
    found = None
    r = Rect(0, 0, 0, 0)
    for c, cr in _find_all(layout, target, is_left):
        if not found or cr.right > r.right:
            found, r = c, cr
    return found


def right_from(layout: prompt_toolkit.layout.Layout, target: prompt_toolkit.layout.AnyContainer) -> Optional[prompt_toolkit.layout.AnyContainer]:
    found = None
    r = Rect(0, 0, 0, 0)
    for c, cr in _find_all(layout, target, is_right):
        if not found or cr.left < r.left:
            found, r = c, cr
    return found


def up_from(layout: prompt_toolkit.layout.Layout, target: prompt_toolkit.layout.AnyContainer) -> Optional[prompt_toolkit.layout.AnyContainer]:
    found = None
    r = Rect(0, 0, 0, 0)
    for c, cr in _find_all(layout, target, is_up):
        if not found or cr.bottom > r.bottom:
            found, r = c, cr
    return found


def down_from(layout: prompt_toolkit.layout.Layout, target: prompt_toolkit.layout.AnyContainer) -> Optional[prompt_toolkit.layout.AnyContainer]:
    found = None
    r = Rect(0, 0, 0, 0)
    for c, cr in _find_all(layout, target, is_down):
        if not found or cr.top < r.top:
            found, r = c, cr
    return found


class SplitNode(prompt_toolkit.layout.DynamicContainer):
    def __init__(self, kb: prompt_toolkit.key_binding.KeyBindings, factory, container: prompt_toolkit.layout.AnyContainer):
        self.kb = kb
        self.factory = factory
        self.container = container

        def has_focus() -> bool:
            if isinstance(self.container, prompt_toolkit.layout.HSplit):
                return False
            if isinstance(self.container, prompt_toolkit.layout.VSplit):
                return False
            return prompt_toolkit.filters.has_focus(self.container)()

        self.has_focus = prompt_toolkit.filters.Condition(has_focus)
        self.add_key_binding(self.split_vertical, 'c-w', 'v')
        self.add_key_binding(self.split_horizontal, 'c-w', 's')
        self.add_key_binding(self.focus_left, 'c-w', 'h', eager=True)
        self.add_key_binding(self.focus_down, 'c-w', 'j', eager=True)
        self.add_key_binding(self.focus_up, 'c-w', 'k', eager=True)
        self.add_key_binding(self.focus_right, 'c-w', 'l', eager=True)
        self.add_key_binding(self.close, 'q', eager=True)
        super().__init__(lambda: self.container)

    def add_key_binding(self, callback: Callable[[prompt_toolkit.key_binding.KeyPressEvent], None], *args, **kw):
        self.kb.add(*args, **kw, filter=self.has_focus)(callback)

    def split_vertical(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        new_node = self.factory()
        self.container = prompt_toolkit.layout.VSplit(
            [
                SplitNode(self.kb, self.factory, self.container),
                prompt_toolkit.layout.Window(char='|', width=1),
                SplitNode(self.kb, self.factory, new_node)
            ])
        e.app.layout.focus(new_node)

    def split_horizontal(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        new_node = self.factory()
        self.container = prompt_toolkit.layout.HSplit(
            [
                SplitNode(self.kb, self.factory, self.container),
                prompt_toolkit.layout.Window(char='-', height=1),
                SplitNode(self.kb, self.factory, new_node)
            ])
        e.app.layout.focus(new_node)

    def focus_left(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        c = prompt_toolkit.layout.to_container(self.get_container())
        target = left_from(e.app.layout, c)
        if target:
            e.app.layout.focus(target)

    def focus_up(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        c = prompt_toolkit.layout.to_container(self.get_container())
        target = up_from(e.app.layout, c)
        if target:
            e.app.layout.focus(target)

    def focus_down(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        c = prompt_toolkit.layout.to_container(self.get_container())
        target = down_from(e.app.layout, c)
        if target:
            e.app.layout.focus(target)

    def focus_right(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        c = prompt_toolkit.layout.to_container(self.get_container())
        target = right_from(e.app.layout, c)
        if target:
            e.app.layout.focus(target)

    def close(self, e: prompt_toolkit.key_binding.KeyPressEvent):
        parent = e.app.layout.get_parent(self)

        next_focus = []

        def traverse(x):
            if isinstance(x, (prompt_toolkit.layout.VSplit, prompt_toolkit.layout.HSplit)):
                for child in x.children:
                    if isinstance(child, SplitNode):
                        if child != self:
                            next_focus.append(child)
                            break
                    else:
                        traverse(child)

        if parent:
            if isinstance(parent, (prompt_toolkit.layout.VSplit, prompt_toolkit.layout.HSplit)):
                traverse(parent)

            if next_focus:

                parent_parent = e.app.layout.get_parent(parent)
                if isinstance(parent_parent, SplitNode):
                    parent_parent.container = next_focus[0]

                    e.app.layout.focus(next_focus[0])


class SampleWindow:
    def __init__(self, index: int) -> None:
        self.index = index
        self.buffer = prompt_toolkit.buffer.Buffer()
        self.control = prompt_toolkit.layout.BufferControl(self.buffer)
        self.container = prompt_toolkit.layout.Window(
            self.control,
            style=lambda: 'class:focus' if self.has_focus()else '',
            wrap_lines=True)
        self.has_focus = prompt_toolkit.filters.has_focus(self.container)

    def __pt_container__(self):
        return self.container


async def main():
    kb = prompt_toolkit.key_binding.KeyBindings()

    next_index = [0]

    def create():
        w = SampleWindow(next_index[0])
        next_index[0] += 1

        async def task():
            for c in get_app().layout.walk():
                if isinstance(c, SplitNode):
                    if isinstance(c.container, SampleWindow):
                        r = Rect.from_container(c.container)
                        c.container.buffer.text = f'{c.container.index}: {r}'
        # enqueue next frame for ensure render_info
        asyncio.get_running_loop().create_task(task())

        return w

    root = SplitNode(kb, create, create())
    app = prompt_toolkit.Application(
        layout=prompt_toolkit.layout.Layout(root),
        full_screen=True,
        key_bindings=kb,
        editing_mode=prompt_toolkit.enums.EditingMode.VI,
        cursor=prompt_toolkit.cursor_shapes.CursorShape.BLINKING_BLOCK,
        style=prompt_toolkit.styles.Style.from_dict(STYLE),
    )

    @ kb.add('Q', eager=True)
    def quit(e: prompt_toolkit.key_binding.KeyPressEvent):
        app.exit()

    def pre_run():
        # Start in navigation mode.
        app.vi_state.input_mode = prompt_toolkit.key_binding.vi_state.InputMode.NAVIGATION

    await app.run_async(pre_run=pre_run)


if __name__ == '__main__':
    asyncio.run(main())
