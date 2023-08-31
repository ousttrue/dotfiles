[[wezterm]]

[object: Window - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/window/index.html)

[Colors & Appearance - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/appearance.html#defining-your-own-colors)

# padding
[window_padding - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/config/window_padding.html)

```lua
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
```

# tabbar
[tab_bar_style - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/config/tab_bar_style.html)
[format-tab-title - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html)
[show_new_tab_button_in_tab_bar - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/config/show_new_tab_button_in_tab_bar.html)

```lua
wezterm.on('update-right-status', function(window, pane)
  window:set_left_status 'left'
  window:set_right_status 'right'
end)

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
```
# status

- [Status Bar - Commentary of Dotfiles](https://coralpink.github.io/commentary/wezterm/status.html)
- [Tmux Like Status Bar · Issue #500 · wez/wezterm · GitHub](https://github.com/wez/wezterm/issues/500)

## event
[update-status - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/window-events/update-status.html)

## setter
[set_left_status - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/window/set_left_status.html)
[set_right_status - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html)
