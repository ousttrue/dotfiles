[wezterm - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/)

- [wez/wezterm Show And Tell · Discussions · GitHub](https://github.com/wez/wezterm/discussions/categories/show-and-tell)
  - @2021 [Show your wezterms · wez/wezterm · Discussion #628 · GitHub](https://github.com/wez/wezterm/discussions/628)

| platform  |           |
| --------- | --------- |
| win32     | native ok |
| x11       | native ok |
| wayland   | native ?  |
| linux-tui |           |

# Version

## 20240203-110809

## 20230712-072601

# articles

- @2024 [WezTermでターミナルを自分なりのデザインにしよう![Mac向け] #初心者 - Qiita](https://qiita.com/maooz4426/items/cd1b15a38f4bf166b8f8)
- @2022 [alacritty+tmuxもいいけど、weztermがすごい件](https://zenn.dev/yutakatay/articles/wezterm-intro)
  `emit-event`

- @2023 [WezTermをセットアップする - Qiita](https://qiita.com/sonarAIT/items/0571c869e5f9ab3be817)
- @2022 [WezTermで日替わりフォントを設定する](https://zenn.dev/htlsne/articles/wezterm-rotate-font)
  `font`
- @2022 [weztermを使ってみる](https://zenn.dev/eetann/scraps/fe0a32896b6de8)
- [Introduction - Commentary of Dotfiles](https://coralpink.github.io/commentary/index.html)
  `mdbook`

# settings

[[wezterm_appearance]]

# font

[[font]]

- nerdfont は内蔵されている

- [Fonts - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/fonts.html)
- [WezTermで日替わりフォントを設定する](https://zenn.dev/htlsne/articles/wezterm-rotate-font)

- @2023 [weztermのEmojiがなんか思ってたのと違うな...というときの設定の仕方](https://zenn.dev/paiza/articles/9ca689a0365b05)

# domain

[default_gui_startup_args - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/config/default_gui_startup_args.html)

## startup

### local

```
> wezterm-gui start --domain local
```

### wsl

```
> wezterm-gui start --domain WSL:Ubuntu-22.04
```

## tab

```lua
{ key = "c", mods = "ALT", action = wezterm.action
	{
		SpawnTab = "CurrentPaneDomain"
	}
}
```

# Multiplexer

- [Multiplexing - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/multiplexing.html)

```
Win32GUi => local (cmd)
         => WSL(unix domain ?) <= SSH

XGUI => local <= SSH
WayLandGUI => local

OSXGUI => local <= SSH
```

## domain

[default_domain - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/config/default_domain.html)

- [object: MuxDomain - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/MuxDomain/index.html)
- start
- connect

### local

### ssh

### wsl

```lua
config.default_domain = 'WSL:Ubuntu-18.04'
```

[object: WslDomain - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/WslDomain.html)

# launch_menu

[Launching Programs - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/launch.html#the-launcher-menu)

```lua
config.launch_menu = {
  {
    args = { 'top' },
  },
  {
    -- Optional label to show in the launcher. If omitted, a label
    -- is derived from the `args`
    label = 'Bash',
    -- The argument array to spawn.  If omitted the default program
    -- will be used as described in the documentation above
    args = { 'bash', '-l' },

    -- You can specify an alternative current working directory;
    -- if you don't specify one then a default based on the OSC 7
    -- escape sequence will be used (see the Shell Integration
    -- docs), falling back to the home directory.
    -- cwd = "/some/path"

    -- You can override environment variables just for this command
    -- by setting this here.  It has the same semantics as the main
    -- set_environment_variables configuration option described above
    -- set_environment_variables = { FOO = "bar" },
  },
}
```

# CopyMode

- [Copy Mode - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/copymode.html)
- q
- y: yank.
- v: visual

# QuickSelectMode

- [quick select mode](https://wezfurlong.org/wezterm/quickselect.html)

# msys + winpty

- [Document how to configure using winpty · Issue #35 · wez/wezterm · GitHub](https://github.com/wez/wezterm/issues/35)
  `removed`
- [Change Log - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/changelog.html)

# window

## events: Window

```lua
wezterm.on('format-window-title',...)
```

## window_decorations

[window_decorations - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html#window_decorations--title--resize)

## titlebar

- @2023 [weztermでitermみたいにタイトルバーを無くす - 9kv8xiyi](https://sugiurahiromichi.hatenablog.com/entry/2023/03/13/205626)

# open uri
