[wezterm - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/)

- @2023 [WezTermをセットアップする - Qiita](https://qiita.com/sonarAIT/items/0571c869e5f9ab3be817)
- @2022 [WezTermで日替わりフォントを設定する](https://zenn.dev/htlsne/articles/wezterm-rotate-font)
- @2022 [alacritty+tmuxもいいけど、weztermがすごい件](https://zenn.dev/yutakatay/articles/wezterm-intro)
- @2022 [weztermを使ってみる](https://zenn.dev/eetann/scraps/fe0a32896b6de8)

# font
[[font]]
- nerdfont は内蔵されている

- [Fonts - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/fonts.html)
- [WezTermで日替わりフォントを設定する](https://zenn.dev/htlsne/articles/wezterm-rotate-font)

- @2023 [weztermのEmojiがなんか思ってたのと違うな...というときの設定の仕方](https://zenn.dev/paiza/articles/9ca689a0365b05)

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
