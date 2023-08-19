[[emacs]]

[Emacsのキーバインド覚書](https://www.aise.ics.saitama-u.ac.jp/~gotoh/EmacsKeybind.html)

# c-h
- [EmacsのC-hをbackspaceとして使用する - 勉強日記](https://akisute3.hatenablog.com/entry/20120318/1332059326)
```lisp
(keyboard-translate ?\C-h ?\C-?)
```

# c-s
`search`
```lisp
(global-set-key "\C-s" 'save-buffer)
```
