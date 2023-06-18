[[python]] [[tui]]

- @2021 [PythonでTUIアプリを作ろう ( その２　TUIライブラリの選択 ) - TORIO's blog](https://rsn604.github.io/it/python%E3%81%A7tui%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8D%E3%81%86%E3%81%9D%E3%81%AE%EF%BC%92-tui%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AE%E9%81%B8%E6%8A%9E/)

```python
import urwid  
class MyEdit(urwid.Edit):  
    def keypress(self, size, key):  
        if key != 'enter':  
            return super(MyEdit, self).keypress(size, key)  
        else:  
            raise urwid.ExitMainLoop()  
  
edit = MyEdit(u"お名前は? ")  
loop = urwid.MainLoop(urwid.Filler(edit))  
loop.run()
```
