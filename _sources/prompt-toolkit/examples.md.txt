# examples

<https://github.com/prompt-toolkit/python-prompt-toolkit/tree/master/examples>

## full-screen

### buttons.py

<https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/examples/full-screen/buttons.py>

layout

* Box
    * HSplit
        * Label
        * VSplit
            * Box
                * HSplit
                    * Button, Button, Button, Button
            * Box
                * Frame
                    * TextArea

### pager.py

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

### text-editor.py

<https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/examples/full-screen/text-editor.py>

layout

* MenuContainer
  * HSplit
