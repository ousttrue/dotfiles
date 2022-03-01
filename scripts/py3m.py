# py3m 🐌
import prompt_toolkit
import prompt_toolkit.layout
import prompt_toolkit.widgets
import prompt_toolkit.key_binding
import prompt_toolkit.enums
import prompt_toolkit.styles
from prompt_toolkit.layout.dimension import LayoutDimension as D


class Browser:
    # addressbar
    # body
    # status
    def __init__(self) -> None:
        self.url = ''

        bindings = prompt_toolkit.key_binding.KeyBindings()

        @bindings.add("q")
        def _(event: prompt_toolkit.key_binding.KeyPressEvent):
            "Quit."
            event.app.exit()

        self.address_bar = prompt_toolkit.widgets.TextArea(
            height=1,
        )

        self.text_area = prompt_toolkit.widgets.TextArea(
            read_only=True,
            line_numbers=True,
        )

        self.status_bar = prompt_toolkit.layout.Window(
            content=prompt_toolkit.layout.FormattedTextControl(
                self._get_statusbar_text),
            height=D.exact(1),
            style="class:status",
        )

        root_container = prompt_toolkit.layout.HSplit(
            [
                self.address_bar,
                self.text_area,
                self.status_bar,
            ]
        )

        layout = prompt_toolkit.layout.Layout(
            root_container, focused_element=self.address_bar)

        style = prompt_toolkit.styles.Style.from_dict(
            {
                "status": "reverse",
                "status.position": "#aaaa00",
                "status.key": "#ffaa00",
                "not-searching": "#888888",
            }
        )

        self.application = prompt_toolkit.Application(
            layout=layout,
            key_bindings=bindings,
            editing_mode=prompt_toolkit.enums.EditingMode.VI,
            enable_page_navigation_bindings=True,
            style=style,
            full_screen=True,
        )

    def _get_statusbar_text(self):
        row = self.text_area.document.cursor_position_row + 1
        col = self.text_area.document.cursor_position_col + 1
        return [
            (
                "class:status.position",
                f"{row}:{col}",
            ),
        ]


async def main():
    browser = Browser()
    await browser.application.run_async()


if __name__ == '__main__':
    import asyncio
    asyncio.get_event_loop().run_until_complete(main())
