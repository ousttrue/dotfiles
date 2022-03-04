from typing import List, TypeVar, Generic
import pathlib
import prompt_toolkit
import prompt_toolkit.output.color_depth
import prompt_toolkit.layout
import prompt_toolkit.layout.controls
import prompt_toolkit.layout.containers
import prompt_toolkit.key_binding
import prompt_toolkit.formatted_text
import prompt_toolkit.styles
import pygments
import pygments.lexers
import pygments.formatters
import pygments.styles
import pygments.style

FILE = pathlib.Path(__file__).absolute()

T = TypeVar('T')


class Selector(Generic[T]):
    def __init__(self, selection: List[T]) -> None:
        assert(selection)
        self.selection = list(selection)
        self.selected_index = 0

        # Key bindings.
        kb = prompt_toolkit.key_binding.KeyBindings()

        @kb.add("up")
        def up(e):
            if self.selected_index > 0:
                self.selected_index -= 1

        @kb.add("down")
        def down(e):
            if self.selected_index+1 < len(self.selection):
                self.selected_index += 1

        @kb.add("q")
        def _(event):
            "Quit application."
            event.app.exit()

        # Control and window.
        self.control = prompt_toolkit.layout.controls.FormattedTextControl(
            self._get_text_fragments, key_bindings=kb, focusable=True
        )

        self.window = prompt_toolkit.layout.containers.Window(
            content=self.control,
            dont_extend_height=True,
        )

    def _get_text_fragments(self) -> prompt_toolkit.formatted_text.StyleAndTextTuples:
        result: prompt_toolkit.formatted_text.StyleAndTextTuples = []
        for i, value in enumerate(self.selection):
            if i == self.selected_index:
                style = '#ff0066'
            else:
                style = ''
            result.append((style, f'{value}\n'))
        return result

    def selected(self) -> T:
        return self.selection[self.selected_index]

    def get_style(self) -> prompt_toolkit.styles.BaseStyle:
        pygment_style = pygments.styles.get_style_by_name(self.selected())
        style = prompt_toolkit.styles.pygments.style_from_pygments_cls(
            pygment_style)  # type: ignore
        fg = next(iter(s[1] for s in style.style_rules if s[0] == 'pygments'))
        bg_style = {
            '': f'bg:{pygment_style.background_color}',
        }

        return prompt_toolkit.styles.merge_styles([
            style,
            prompt_toolkit.styles.Style.from_dict(bg_style)
        ])


class HighlightText:
    def __init__(self, text: str) -> None:
        lexer = pygments.lexers.Python3Lexer()

        tokens = list(lexer.get_tokens(text))

        self.control = prompt_toolkit.layout.controls.FormattedTextControl(
            prompt_toolkit.formatted_text.PygmentsTokens(tokens)
        )

        self.container = prompt_toolkit.layout.containers.Window(
            content=self.control,
            dont_extend_height=True,
        )


def run():
    selector = Selector[str](
        list(pygments.styles.get_all_styles()))

    text = HighlightText(FILE.read_text())

    root = prompt_toolkit.layout.containers.FloatContainer(
        content=prompt_toolkit.layout.containers.Window(
            char=' ',
            ignore_content_width=True,
            ignore_content_height=True,
        ),
        floats=[
            prompt_toolkit.layout.containers.Float(
                prompt_toolkit.layout.containers.VSplit(
                    [
                        prompt_toolkit.layout.containers.Window(
                            selector.control),
                        prompt_toolkit.layout.containers.Window(
                            width=1, char="|"),
                        text.container,
                    ]
                ),
                transparent=True,
                left=0,
                right=0,
                top=0,
                bottom=0
            ),
        ],
    )

    layout = prompt_toolkit.layout.Layout(
        root, focused_element=selector.control)

    application = prompt_toolkit.Application(
        layout=layout, full_screen=True,
        color_depth=prompt_toolkit.output.color_depth.ColorDepth.DEPTH_8_BIT,
        style=prompt_toolkit.styles.DynamicStyle(selector.get_style),
    )
    application.run()


if __name__ == "__main__":
    run()
