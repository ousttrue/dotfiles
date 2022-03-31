# pager.py

<https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/examples/full-screen/pager.py>

layout

* HSplit
    * Window
    * TextArea
    * SearchToolbar

vim の キーバインド？

```py
from prompt_toolkit.enums import EditingMode
application = Application(
    editing_mode=EditingMode.VI
    # default は EditingMode.EMACS
)
```

TODO: menu からファイルを選択する

TOTO: textarea の背景色

## status bar

```py
row self.text_area.document.cursor_position_row + 1,
col self.text_area.document.cursor_position_col + 1,
```

## search
