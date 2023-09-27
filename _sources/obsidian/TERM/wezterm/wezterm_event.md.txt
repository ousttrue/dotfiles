# CustomEvent
## EmitEvent
[EmitEvent - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/keyassignment/EmitEvent.html)
- [wezterm.on - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#custom-events)
- @2022 [Hello, Wezterm | katsyoshi のめもみたいなの](https://blog.katsyoshi.org/blog/2022/03/19/hello-wezterm/)
- @2022 [alacritty+tmuxもいいけど、weztermがすごい件](https://zenn.dev/yutakatay/articles/wezterm-intro)

`key` => `Event`
```lua
local EVENT = "trigger-nvim-with-scrollback"
local wezterm = require("wezterm")
wezterm.on(EVENT, function(window, pane)
	local scrollback = pane:get_lines_as_text()
	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(scrollback)
	f:flush()
	f:close()
	window:perform_action(
		wezterm.action({ SpawnCommandInNewTab = {
			args = { "nvim", name },
		} }),
		pane
	)
	wezterm.sleep_ms(1000)
	os.remove(name)
end)

return {
  keys = {
    {key="E", mods="ALT", action=wezterm.action{EmitEvent=EVENT}},
  }
}
```

# WindowEvent
- bell
- new-tab-button-click
- open-uri
- window-config-reloaded
- window-focus-changed
- window-resized

## appearance
[[wezterm_appearance]]
- update-right-status
- update-status
- format-tab-title
- format-window-title

## user-var
- user-var-changed

# CommandPallete
- [ActivateCommandPalette - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/keyassignment/ActivateCommandPalette.html)

追加エントリー
- augment-command-palette
- [augment-command-palette - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/window-events/augment-command-palette.html)
