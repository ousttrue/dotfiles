#!/usr/bin/env python
"""
A simple example of a Notepad-like text editor.
"""
from typing import List
import datetime
import asyncio
import pathlib
from prompt_toolkit.layout.dimension import D
import prompt_toolkit.widgets


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


class MessageDialog:
    def __init__(self, title, text):
        self.future = asyncio.Future()

        def set_done():
            self.future.set_result(None)

        import prompt_toolkit.widgets
        ok_button = prompt_toolkit.widgets.Button(
            text="OK", handler=(lambda: set_done()))

        import prompt_toolkit.layout.containers
        self.dialog = prompt_toolkit.widgets.Dialog(
            title=title,
            body=prompt_toolkit.layout.containers.HSplit(
                [prompt_toolkit.widgets.Label(text=text)]),
            buttons=[ok_button],
            width=D(preferred=80),
            modal=True,
        )

    def __pt_container__(self):
        return self.dialog


class App:
    def __init__(self) -> None:
        """
        Application state.

        For the simplicity, we store this as a global, but better would be to
        instantiate this as an object and pass at around.
        """
        self.show_status_bar = True
        self.current_path = None

        from prompt_toolkit.styles import Style
        style = Style.from_dict(
            {
                "status": "reverse",
                "shadow": "bg:#440044",
            }
        )

        def get_statusbar_text():
            return " Press Ctrl-C to open menu. "

        def get_statusbar_right_text():
            return " {}:{}  ".format(
                self.text_field.document.cursor_position_row + 1,
                self.text_field.document.cursor_position_col + 1,
            )

        import prompt_toolkit.widgets
        from prompt_toolkit.lexers import DynamicLexer, PygmentsLexer
        search_toolbar = prompt_toolkit.widgets.SearchToolbar()
        self.text_field = prompt_toolkit.widgets.TextArea(
            lexer=DynamicLexer(
                lambda: PygmentsLexer.from_filename(
                    self.current_path or ".txt", sync_from_start=False
                )
            ),
            scrollbar=True,
            line_numbers=True,
            search_field=search_toolbar,
        )

        import prompt_toolkit.layout.controls
        import prompt_toolkit.layout.containers
        import prompt_toolkit.filters
        body = prompt_toolkit.layout.containers.HSplit(
            [
                self.text_field,
                search_toolbar,
                prompt_toolkit.layout.containers.ConditionalContainer(
                    content=prompt_toolkit.layout.containers.VSplit(
                        [
                            prompt_toolkit.layout.containers.Window(
                                prompt_toolkit.layout.controls.FormattedTextControl(get_statusbar_text), style="class:status"
                            ),
                            prompt_toolkit.layout.containers.Window(
                                prompt_toolkit.layout.controls.FormattedTextControl(
                                    get_statusbar_right_text),
                                style="class:status.right",
                                width=9,
                                align=prompt_toolkit.layout.containers.WindowAlign.RIGHT,
                            ),
                        ],
                        height=1,
                    ),
                    filter=prompt_toolkit.filters.Condition(
                        lambda: self.show_status_bar),
                ),
            ]
        )

        # Global key bindings.
        import prompt_toolkit.key_binding
        bindings = prompt_toolkit.key_binding.KeyBindings()

        import prompt_toolkit.layout.menus
        self.root_container = prompt_toolkit.widgets.MenuContainer(
            body=body,
            menu_items=self._create_menu_items(),
            floats=[
                prompt_toolkit.layout.containers.Float(
                    xcursor=True,
                    ycursor=True,
                    content=prompt_toolkit.layout.menus.CompletionsMenu(
                        max_height=16, scroll_offset=1),
                ),
            ],
            key_bindings=bindings,
        )

        @bindings.add("c-c")
        def _(event):
            "Focus menu."
            event.app.layout.focus(self.root_container.window)

        import prompt_toolkit.layout.layout
        layout = prompt_toolkit.layout.layout.Layout(
            self.root_container, focused_element=self.text_field)

        import prompt_toolkit.application
        self.application = prompt_toolkit.application.Application(
            layout=layout,
            enable_page_navigation_bindings=True,
            style=style,
            mouse_support=True,
            full_screen=True,
        )

    def _create_menu_items(self) -> List[prompt_toolkit.widgets.MenuItem]:
        return [
            prompt_toolkit.widgets.MenuItem(
                "File",
                children=[
                    prompt_toolkit.widgets.MenuItem(
                        "New...", handler=self.do_new_file),
                    prompt_toolkit.widgets.MenuItem(
                        "Open...", handler=self.do_open_file),
                    prompt_toolkit.widgets.MenuItem("Save"),
                    prompt_toolkit.widgets.MenuItem("Save as..."),
                    prompt_toolkit.widgets.MenuItem("-", disabled=True),
                    prompt_toolkit.widgets.MenuItem(
                        "Exit", handler=self.do_exit),
                ],
            ),
            prompt_toolkit.widgets.MenuItem(
                "Edit",
                children=[
                    prompt_toolkit.widgets.MenuItem(
                        "Undo", handler=self.do_undo),
                    prompt_toolkit.widgets.MenuItem(
                        "Cut", handler=self.do_cut),
                    prompt_toolkit.widgets.MenuItem(
                        "Copy", handler=self.do_copy),
                    prompt_toolkit.widgets.MenuItem(
                        "Paste", handler=self.do_paste),
                    prompt_toolkit.widgets.MenuItem(
                        "Delete", handler=self.do_delete),
                    prompt_toolkit.widgets.MenuItem("-", disabled=True),
                    prompt_toolkit.widgets.MenuItem(
                        "Find", handler=self.do_find),
                    prompt_toolkit.widgets.MenuItem(
                        "Find next", handler=self.do_find_next),
                    prompt_toolkit.widgets.MenuItem("Replace"),
                    prompt_toolkit.widgets.MenuItem(
                        "Go To", handler=self.do_go_to),
                    prompt_toolkit.widgets.MenuItem(
                        "Select All", handler=self.do_select_all),
                    prompt_toolkit.widgets.MenuItem(
                        "Time/Date", handler=self.do_time_date),
                ],
            ),
            prompt_toolkit.widgets.MenuItem(
                "View",
                children=[
                    prompt_toolkit.widgets.MenuItem("Status Bar", handler=self.do_status_bar)],
            ),
            prompt_toolkit.widgets.MenuItem(
                "Info",
                children=[prompt_toolkit.widgets.MenuItem(
                    "About", handler=self.do_about)],
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

            path = await self.show_dialog_as_float(open_dialog)
            self.current_path = path

            self.open(path)

        asyncio.ensure_future(coroutine())

    def open(self, path: str | pathlib.Path):
        match path:
            case str():
                try:
                    with open(path, "rb") as f:
                        self.text_field.text = f.read().decode("utf-8", errors="ignore")
                except OSError as e:
                    self.show_message("Error", f"{e}")
            case pathlib.Path():
                self.text_field.text = path.read_text()

    def do_about(self):
        self.show_message(
            "About", "Text editor demo.\nCreated by Jonathan Slenders.")

    def show_message(self, title, text):
        async def coroutine():
            dialog = MessageDialog(title, text)
            await self.show_dialog_as_float(dialog)

        asyncio.ensure_future(coroutine())

    async def show_dialog_as_float(self, dialog):
        "Coroutine."
        assert(isinstance(self.root_container.floats, list))
        import prompt_toolkit.layout.containers
        float_ = prompt_toolkit.layout.containers.Float(content=dialog)
        self.root_container.floats.insert(0, float_)

        app = self.application

        focused_before = app.layout.current_window
        app.layout.focus(dialog)
        result = await dialog.future
        app.layout.focus(focused_before)

        if float_ in self.root_container.floats:
            self.root_container.floats.remove(float_)

        return result

    def do_new_file(self):
        self.text_field.text = ""

    def do_exit(self):
        self.application.exit()

    def do_time_date(self):
        text = datetime.datetime.now().isoformat()
        self.text_field.buffer.insert_text(text)

    def do_go_to(self):
        async def coroutine():
            dialog = TextInputDialog(
                title="Go to line", label_text="Line number:")

            line_number = await self.show_dialog_as_float(dialog)

            try:
                line_number = int(line_number)
            except ValueError:
                self.show_message("Invalid line number", "Invalid line number")
            else:
                self.text_field.buffer.cursor_position = (
                    self.text_field.buffer.document.translate_row_col_to_index(
                        line_number - 1, 0
                    )
                )

        asyncio.ensure_future(coroutine())

    def do_undo(self):
        self.text_field.buffer.undo()

    def do_cut(self):
        data = self.text_field.buffer.cut_selection()
        self.application.clipboard.set_data(data)

    def do_copy(self):
        data = self.text_field.buffer.copy_selection()
        self.application.clipboard.set_data(data)

    def do_delete(self):
        self.text_field.buffer.cut_selection()

    def do_find(self):
        from prompt_toolkit.search import start_search
        start_search(self.text_field.control)

    def do_find_next(self):
        search_state = self.application.current_search_state

        cursor_position = self.text_field.buffer.get_search_position(
            search_state, include_current_position=False
        )
        self.text_field.buffer.cursor_position = cursor_position

    def do_paste(self):
        self.text_field.buffer.paste_clipboard_data(
            self.application.clipboard.get_data())

    def do_select_all(self):
        self.text_field.buffer.cursor_position = 0
        self.text_field.buffer.start_selection()
        self.text_field.buffer.cursor_position = len(
            self.text_field.buffer.text)

    def do_status_bar(self):
        self.show_status_bar = not self.show_status_bar


def run():
    app = App()
    app.open(FILE)
    app.application.run()


if __name__ == "__main__":
    run()
