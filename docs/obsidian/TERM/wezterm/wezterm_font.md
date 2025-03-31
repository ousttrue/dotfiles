# system 列挙

```sh
> wezterm ls-fonts --list-system
```

# ~/.config/wezterm.lua

```lua
  config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    {family="Noto Serif CJK TC", --"Noto Sans Mono CJK TC",
     scale=1.0},
  })
```
