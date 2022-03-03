# examples
## tools

* ptterm
  * <https://github.com/selectel/pyte>
* pymux
* <https://github.com/lyz-code/prompt-toolkit-table>
* <https://github.com/TuuuNya/prompt_toolkit_demo>
* <https://github.com/DivineSoftware/Pygy>
* <https://github.com/vaaaaanquish-xx/select-command-using-ptk>
* <https://gitlab.com/lisael/ptfm>
* <https://github.com/prompt-toolkit/pypager>

## examples

<https://github.com/prompt-toolkit/python-prompt-toolkit/tree/master/examples>

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
