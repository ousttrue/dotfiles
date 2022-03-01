#!/usr/bin/env python
"""
A simple application that shows a Pager application.
"""
import pathlib

import prompt_toolkit.enums
import prompt_toolkit.key_binding
from pygments.lexers.python import PythonLexer
from prompt_toolkit.application import Application
from prompt_toolkit.layout.containers import HSplit, Window
from prompt_toolkit.layout.controls import FormattedTextControl
from prompt_toolkit.layout.dimension import LayoutDimension as D
from prompt_toolkit.layout.layout import Layout
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.styles import Style
from prompt_toolkit.widgets import SearchToolbar, TextArea

# Create one text buffer for the main content.
FILE = pathlib.Path(__file__).absolute()


class App:
    def __init__(self) -> None:
        # Key bindings.
        bindings = prompt_toolkit.key_binding.KeyBindings()

        @bindings.add("c-c")
        @bindings.add("q")
        def _(event):
            "Quit."
            event.app.exit()

        style = Style.from_dict(
            {
                "status": "reverse",
                "status.position": "#aaaa00",
                "status.key": "#ffaa00",
                "not-searching": "#888888",
            }
        )

        self.application = Application(
            layout=self._layout(),
            key_bindings=bindings,
            editing_mode=prompt_toolkit.enums.EditingMode.VI,
            enable_page_navigation_bindings=True,
            mouse_support=True,
            style=style,
            full_screen=True,
        )

    def _layout(self) -> Layout:
        search_field = SearchToolbar(
            text_if_not_searching=[
                ("class:not-searching", "Press '/' to start searching.")]
        )

        text_area = TextArea(
            text=FILE.read_text(),
            read_only=True,
            scrollbar=True,
            line_numbers=True,
            search_field=search_field,
            lexer=PygmentsLexer(PythonLexer),
        )

        def get_statusbar_text():
            return [
                ("class:status", str(FILE.name) + " - "),
                (
                    "class:status.position",
                    "{}:{}".format(
                        text_area.document.cursor_position_row + 1,
                        text_area.document.cursor_position_col + 1,
                    ),
                ),
                ("class:status", " - Press "),
                ("class:status.key", "Ctrl-C"),
                ("class:status", " to exit, "),
                ("class:status.key", "/"),
                ("class:status", " for searching."),
            ]

        root_container = HSplit(
            [
                # The main content.
                text_area,
                Window(
                    content=FormattedTextControl(get_statusbar_text),
                    height=D.exact(1),
                    style="class:status",
                ),
                search_field,
            ]
        )
        return Layout(root_container, focused_element=text_area)


def run():
    app = App()
    app.application.run()


if __name__ == "__main__":
    run()
