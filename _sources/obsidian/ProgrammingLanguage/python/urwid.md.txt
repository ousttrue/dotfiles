[[python]] [[tui]]

- [Overview — Urwid 2.1.2](http://urwid.org/)
	- [Urwid Tutorial — Urwid 2.1.2](http://urwid.org/tutorial/index.html)

# Hello
## minimum
```python
import urwid
loop = urwid.MainLoop(
    urwid.Filler(urwid.Text("Hello World"), "top"),
)
loop.run()
```

## screen
Screen をカスタム。何も起きない
```python
class MyScreen:
    def __init__(self) -> None:
        self.screen_size = None

    def start(self):
        pass

    def stop(self):
        pass

    def set_mouse_tracking(self):
        pass

    def get_cols_rows(self):
        return (80, 24)

    def draw_screen(self, size, canvas):
        pass

    def set_input_timeouts(self, timeout):
        pass

    def get_input(self, enable):
        # keys, raw
        return (None, None)

```

## urwid.raw_display を参考に
[urwid/urwid/raw_display.py at master · urwid/urwid · GitHub](https://github.com/urwid/urwid/blob/master/urwid/raw_display.py#L60)

```python
class Screen(BaseScreen, RealTerminal):
    def __init__(self, input=sys.stdin, output=sys.stdout):
        super().__init__()
```

- BaseScreen [urwid/urwid/display_common.py at master · urwid/urwid · GitHub](https://github.com/urwid/urwid/blob/master/urwid/display_common.py#L906)
	`palette` 管理？
- RealTerminal [urwid/urwid/display_common.py at master · urwid/urwid · GitHub](https://github.com/urwid/urwid/blob/master/urwid/display_common.py#L840)
	`/dev/tty` ?

### start
`raw` モードの開始
```python
# raw
        if fd is not None and os.isatty(fd):
            self._old_termios_settings = termios.tcgetattr(fd)
            tty.setcbreak(fd)

# curses
        self.s = curses.initscr()
        curses.noecho()
        curses.meta(1)
        curses.halfdelay(10) # use set_input_timeouts to adjust
        self.s.keypad(0)
```

### get_input

### draw_screen

# articles
- @2021 [PythonでTUIアプリを作ろう ( その２　TUIライブラリの選択 ) - TORIO's blog](https://rsn604.github.io/it/python%E3%81%A7tui%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8D%E3%81%86%E3%81%9D%E3%81%AE%EF%BC%92-tui%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AE%E9%81%B8%E6%8A%9E/)
- [Urwid Examples](https://seriot.ch/urwid/)

# Screen
`class Screen(BaseScreen, RealTerminal)`

# Windows
素では動かないようだが、動かす手段はありそう。

- [partial native Windows support via windows-curses · Issue #447 · urwid/urwid · GitHub](https://github.com/urwid/urwid/issues/447)

## Screen を改造する
### urwid.raw_display.Screen
WSL
`fcntl` などで動かない

### urwid.curses_display.Screen
[windows-curses · PyPI](https://pypi.org/project/windows-curses/)
に依存する様子。
import urwid.curses_display

```python
#
# https://github.com/urwid/urwid/issues/447
#
class CustomCurses(urwid.curses_display.Screen):
    def __init__(self, *args, **kvargs):
        super().__init__(*args, **kvargs)

    def tty_signal_keys(
        self, intr=None, quit=None, start=None, stop=None, susp=None, fileno=None
    ):
        pass  # no signals on Windows; not needed for resize

    def _start(self):
        super()._start()
        import curses

        # halfdelay() seems unnecessary and causes everything to slow down a lot.
        curses.nocbreak()  # exits halfdelay mode
        # keypad(1) is needed, or we get no special keys (cursor keys, etc.)
        self.s.keypad(1)

    def _getch(self, wait_tenths):
        if wait_tenths == 0:
            return self._getch_nodelay()

        self.s.nodelay(False)
        return self.s.getch()

    def _getch_nodelay(self):
        self.s.nodelay(True)
        return self.s.getch()
```

### raw
- [GitHub - mhils/urwid at win32-rawdisplay](https://github.com/mhils/urwid/tree/win32-rawdisplay)

### conpty バージョン作れないか？
- out は VT100 互換なので raw
- in は Win32API

# urwid.MainLoop
こっちも改造必要
## event_loop
### SelectEventLoop
socket 専用なので動かない
```python
        if not hasattr(screen, 'hook_event_loop') and event_loop is not None:
            raise NotImplementedError(f"screen object passed {screen!r} does not support external event loops")
        if event_loop is None:
            event_loop = SelectEventLoop() # これ動かない
        self.event_loop = event_loop
```

### AsyncioEventLoop
[プラットフォームでのサポート — Python 3.11.4 ドキュメント](https://docs.python.org/ja/3/library/asyncio-platforms.html)
- add_reader, add_writer

### gevent?
[GitHub - what-studio/urwid-geventloop: Event loop based on gevent for urwid.](https://github.com/what-studio/urwid-geventloop)

## watch_pipe
