python binding

- @2024 [PyQt6の基本の使い方からのまとめとPyQt5との違い #Python - Qiita](https://qiita.com/phyblas/items/d56003904c83938823f2)
- @2017 https://thors-novels.seesaa.net/search?keyword=pyqt

# stub

## pyside6 には最初から同梱されているのでは？

👍

## pyside-genpyi

https://doc.qt.io/qtforpython-6/tools/pyside-genpyi.html

```sh
> pyside6-genpyi.exe --outpath typings all
```

## PySide6-stubs

https://pypi.org/project/PySide6-stubs/

```py
pip install PySide6-stubs
```

# input

- [YMT Lab | PySide6でキーボードとマウスの入力内容を表示するアプリを作ってみました](https://ymt-lab.com/post/2023/keyboard_mouse_monitor/)[keyboard_mouse_monitor

# native window

## HWND

```py
from PySide6 import QtWidgets, QtGui

app = QtWidgets.QApplication()


class MyWindow(QtGui.QWindow):
    def exposeEvent(self, *args):
        draw_frame()


w = MyWindow()
w.resize(500, 500)
w.show()
hwnd = w.winId()
```

