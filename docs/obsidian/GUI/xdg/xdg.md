[[OS/X11/X11]]

# config
- `XDG_CONFIG_HOME` => `~/.config`
- `XDG_CACHE_HOME` => `~/.cache`
- `XDG_DATA_HOME` => `~/.local/share`
[[nvim]]

[Windows: Windowsに'XDG Base Directory'を導入する](https://zenn.dev/atsushifx/articles/winhack-environ-xdg-base)

## share
Note that 'D:/msys64/mingw64/share' is not in the search path
set by the XDG_DATA_HOME and XDG_DATA_DIRS
environment variables, so applications may not
be able to find it until you set them. The
directories currently searched are:

- C:$HOME/.local/share
- D:/msys64/mingw64/share/
- D:/msys64/usr/local/share/
- D:/msys64/usr/share/

# desktop
- [デスクトップエントリ - ArchWiki](https://wiki.archlinux.jp/index.php/%E3%83%87%E3%82%B9%E3%82%AF%E3%83%88%E3%83%83%E3%83%97%E3%82%A8%E3%83%B3%E3%83%88%E3%83%AA)
`~/.local/share/applications`
- [xdg-open で開くアプリを変更する - Qiita](https://qiita.com/apu4se/items/ff7efd8d351e09bb9b54)
- @2018 [デフォルトブラウザを変更する – あららぼ](https://ararabo.jp/2018-07-27/?p=7401)

```ini
[Desktop Entry]
Name=WezTerm
Comment=Wez's Terminal Emulator
Keywords=shell;prompt;command;commandline;cmd;
Icon=org.wezfurlong.wezterm
StartupWMClass=org.wezfurlong.wezterm
TryExec=wezterm
Exec=wezterm start --cwd .
Type=Application
Categories=System;TerminalEmulator;Utility;
Terminal=false
```

## application icon
1.  `$HOME/.icons` (後方互換性のため)
2.  `$XDG_DATA_DIRS/icons`
3.  `/usr/share/pixmaps`

- [Changing openbox's alt+tab menu icon / Applications & Desktop Environments / Arch Linux Forums](https://bbs.archlinux.org/viewtopic.php?pid=2014805#p2014805)
OpenBox ookisugiru icon
