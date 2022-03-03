#!/usr/bin/env python
"""
A simple application that shows a Pager application.
"""
from typing import List, Union, Callable, cast, TypeVar
import pathlib
import asyncio
import prompt_toolkit.enums
import prompt_toolkit.key_binding
import prompt_toolkit.keys
import prompt_toolkit.filters
from pygments.lexers.python import PythonLexer
from prompt_toolkit.application import Application
from prompt_toolkit.layout.containers import HSplit, Window
from prompt_toolkit.layout.controls import FormattedTextControl
from prompt_toolkit.layout.dimension import LayoutDimension as D
from prompt_toolkit.layout.layout import Layout
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.styles import Style
import prompt_toolkit.widgets

# Create one text buffer for the main content.
FILE = pathlib.Path(__file__).absolute()


class TextInputDialog:
    def __init__(self, title="", label_text="", completer=None):
        self.future = asyncio.Future()

        def accept_text(buf):
            import prompt_toolkit.application
            prompt_toolkit.application.current.get_app().layout.focus(ok_button)
            buf.complete_state = None
            return True

        def accept():
            self.future.set_result(self.text_area.text)

        def cancel():
            self.future.set_result(None)

        import prompt_toolkit.widgets
        self.text_area = prompt_toolkit.widgets.TextArea(
            completer=completer,
            multiline=False,
            width=D(preferred=40),
            accept_handler=accept_text,
        )

        ok_button = prompt_toolkit.widgets.Button(text="OK", handler=accept)
        cancel_button = prompt_toolkit.widgets.Button(
            text="Cancel", handler=cancel)

        import prompt_toolkit.layout.containers
        self.dialog = prompt_toolkit.widgets.Dialog(
            title=title,
            body=prompt_toolkit.layout.containers.HSplit(
                [prompt_toolkit.widgets.Label(text=label_text), self.text_area]),
            buttons=[ok_button, cancel_button],
            width=D(preferred=80),
            modal=True,
        )

    def __pt_container__(self):
        return self.dialog


def bind(binding: prompt_toolkit.key_binding.KeyBindings, func: prompt_toolkit.key_binding.key_bindings.KeyHandlerCallable, *keys: Union[prompt_toolkit.keys.Keys, str],
         filter: prompt_toolkit.filters.FilterOrBool = True,
         eager: prompt_toolkit.filters.FilterOrBool = False,
         is_global: prompt_toolkit.filters.FilterOrBool = False,
         save_before: Callable[[prompt_toolkit.key_binding.KeyPressEvent], bool] = (
             lambda e: True),
         record_in_macro: prompt_toolkit.filters.FilterOrBool = True):
    assert keys

    keys = tuple(prompt_toolkit.key_binding.key_bindings._parse_key(k)
                 for k in keys)
    binding.bindings.append(
        prompt_toolkit.key_binding.key_bindings.Binding(
            keys,
            func,
            filter=filter,
            eager=eager,
            is_global=is_global,
            save_before=save_before,
            record_in_macro=record_in_macro,
        )
    )
    binding._clear_cache()


class App:
    def __init__(self) -> None:
        # Key bindings.
        bindings = prompt_toolkit.key_binding.KeyBindings()

        bind(bindings, self.quit, "c-c")
        bind(bindings, self.quit, "q")

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

    def quit(self, event: prompt_toolkit.key_binding.KeyPressEvent):
        "Quit."
        event.app.exit()

    def _layout(self) -> Layout:
        search_field = prompt_toolkit.widgets.SearchToolbar(
            text_if_not_searching=[
                ("class:not-searching", "Press '/' to start searching.")]
        )

        self.text_area = prompt_toolkit.widgets.TextArea(
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
                        self.text_area.document.cursor_position_row + 1,
                        self.text_area.document.cursor_position_col + 1,
                    ),
                ),
                ("class:status", " - Press "),
                ("class:status.key", "Ctrl-C"),
                ("class:status", " to exit, "),
                ("class:status.key", "/"),
                ("class:status", " for searching."),
            ]

        mc = prompt_toolkit.widgets.MenuContainer(
            body=self.text_area,
            menu_items=self._create_menu_items(),
            # key_bindings=bindings,
        )

        status_bar = Window(
            content=FormattedTextControl(get_statusbar_text),
            height=D.exact(1),
            style="class:status",
        )

        root_container = HSplit(
            [
                # The main content.
                mc,
                status_bar,
                search_field,
            ]
        )
        return Layout(root_container, focused_element=self.text_area)

    def _create_menu_items(self) -> List[prompt_toolkit.widgets.MenuItem]:
        return [
            prompt_toolkit.widgets.MenuItem(
                "File",
                children=[
                    prompt_toolkit.widgets.MenuItem(
                        "Open...", handler=self.do_open_file),
                ],
            ),
        ]

    def do_open_file(self):
        import prompt_toolkit.completion

        async def coroutine():
            open_dialog = TextInputDialog(
                title="Open file",
                label_text="Enter the path of a file:",
                completer=prompt_toolkit.completion.PathCompleter(),
            )

            # path = await self.show_dialog_as_float(open_dialog)
            # self.current_path = path

            self.open('')

        asyncio.ensure_future(coroutine())

    # async def show_dialog_as_float(self, dialog):
    #     "Coroutine."
    #     assert(isinstance(self.root_container.floats, list))
    #     import prompt_toolkit.layout.containers
    #     float_ = prompt_toolkit.layout.containers.Float(content=dialog)
    #     self.root_container.floats.insert(0, float_)

    #     app = self.application

    #     focused_before = app.layout.current_window
    #     app.layout.focus(dialog)
    #     result = await dialog.future
    #     app.layout.focus(focused_before)

    #     if float_ in self.root_container.floats:
    #         self.root_container.floats.remove(float_)

    #     return result

    def open(self, path: str | pathlib.Path):
        match path:
            case str():
                try:
                    with open(path, "rb") as f:
                        self.text_area.text = f.read().decode("utf-8", errors="ignore")
                except OSError as e:
                    # self.show_message("Error", f"{e}")
                    pass
            case pathlib.Path():
                self.text_area.text = path.read_text()


def run():
    app = App()
    app.application.run()


if __name__ == "__main__":
    run()
