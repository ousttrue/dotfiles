
- @2019 [Terminal curses––Terminalの基礎とRuby、そしてcursesについて - Part1 - ログミーTech](https://logmi.jp/tech/articles/321318)
# Implementation
## PDCurses
[[pdcurses]]
### windows pty
[[conpty]]
[[windows_terminal]]

## NCurses
[[ncurses]]
## python
[[python_curses]]

Windows版の標準ライブラリには含まれない。
[Curses Programming with Python — Python 3.10.2 documentation](https://docs.python.org/3/howto/curses.html)
- [UniCurses · PyPI](https://pypi.org/project/UniCurses/)
- [windows-curses · PyPI](https://pypi.org/project/windows-curses/)

# man

```
sudo apt-get install ncurses-doc
```

# color
２系統のAPIがある？
## alloc_pair
```c
int alloc_pair(int fg, int bg);
int find_pair(int fg, int bg);
int free_pair(int pair);
```

## init_pair

# init
- [Programming Essentials - curses library](https://www.koeki-prj.org/roy/~yuuji/2016/pe/11/curses.html)
- initscr
	- noecho
	- cbreak
- endwin

# stdscr
- [ncursesの使い方](http://hp.vector.co.jp/authors/VA022047/linux/ncurses.html)
- [もう一度基礎からC言語 第48回 特殊な画面制御～GCCの画面制御ライブラリ ncursesライブラリの関数](https://dev.grapecity.co.jp/support/powernews/column/clang/048/page02.htm)
- getch
- move
- addch
- insch


# Window & Pad
[window/padには謎のクセがある。 - やってみる](https://ytyaru.hatenablog.com/entry/2023/01/23/000000)
## Window

## Pad
- [newpad(3): create/display curses pads - Linux man page](https://linux.die.net/man/3/newpad)
- newpad
- delpad
