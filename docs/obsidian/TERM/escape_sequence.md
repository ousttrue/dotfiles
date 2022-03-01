escape sequence
#linux #term

https://www.askapache.com/linux/zen-terminal-escape-codes/
https://vorfee.hatenablog.jp/entry/2015/03/17/173635

`\e` => `ESC`

`\e__COMMAND__\a`

[*  tells xterm to set icon and title bar]
`\e]0;__TITLE__\a`

[* Windows向けのプログラムでANSIエスケープシーケンスを使うには https://qiita.com/mod_poppo/items/2ff384530c6f3215c635]

[* msys git]
`\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n`

[* termcap]
escape sequence のデータベース。

code:termcap 256-colors
	termcapinfo xterm-256color 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'

termcapinfo xterm 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'
Modify or create one if needed so that it looks like this:
Code:
termcapinfo xterm-color|xterm-16color|xterm-88color|xterm-256color|rxvt* 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'

https://en.wikipedia.org/wiki/ANSI_escape_code

code:py
  process.stdout.write("\x1b[6n");
