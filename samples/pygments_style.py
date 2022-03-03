import pygments.styles
import sys
import pygments
from pygments.style import Style
from pygments.token import Token
import pygments.lexers
import pygments.formatters

import prompt_toolkit
import prompt_toolkit.completion

CODE = 'print("Hello World")'


class MyStyle(Style):
    styles = {
        Token.String:     'ansibrightblue bg:ansibrightred',
    }


class MyCustomCompleter(prompt_toolkit.completion.Completer):
    def get_completions(self, document, complete_event):
        for style in pygments.styles.get_all_styles():
            yield prompt_toolkit.completion.Completion(style, start_position=0)


def main():
    completer = MyCustomCompleter()
    text = prompt_toolkit.prompt('pygments style: ', completer=completer)
    print('You said: %s' % text)

    style = text
    result = pygments.highlight(CODE,
                                pygments.lexers.Python3Lexer(),
                                pygments.formatters.TerminalTrueColorFormatter(style=style))

    sys.stdout.buffer.write(result.encode())


if __name__ == '__main__':
    main()
