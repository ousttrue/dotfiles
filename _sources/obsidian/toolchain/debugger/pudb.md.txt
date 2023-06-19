[[python_debugger]]
[[tui]]
[[urwid]]

- [pudb 2022.1.3 documentation](https://documen.tician.de/pudb/)
- [GitHub - inducer/pudb: Full-screen console debugger for Python](https://github.com/inducer/pudb)

- [Meet Pudb, a debugger for Python code - YouTube](https://www.youtube.com/watch?v=bJYkCWPs_UU)

- @2020 [pudbをもっともっと活用する - The jonki](https://www.jonki.net/entry/2020/05/23/132152)
- @2019 [Python の CUI デバッガ「PuDB」の紹介と使い方 - Qiita](https://qiita.com/Kernel_OGSun/items/144c8502ce2eaa5e4410)
- @2018 [pudbで機械学習開発を加速させる - The jonki](https://www.jonki.net/entry/2018/08/16/220713)
- @2014 [TumblrのCUBE SUGAR STORAGE](https://www.tumblr.com/momijiame/79011616659/python-%E3%81%AE-cui-%E3%83%87%E3%83%90%E3%83%83%E3%82%AC-pudb-%E3%81%8C%E4%BE%BF%E5%88%A9%E3%81%99%E3%81%8E%E3%81%9F%E4%BB%B6)

# breakpoint
`b`
# run
`c`

# stepin / stepout
`n`
`s`

# Windows
[[urwid]] の Screen を差し替えれば動きそう。
```python
import urwid.raw_display
import win_screen
urwid.raw_display.Screen = win_screen.Screen

import pudb.run
pudb.run.main()
```
