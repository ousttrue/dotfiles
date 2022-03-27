local wezterm = require("wezterm")

return {
    default_prog = {"xonsh"},
    font = wezterm.font("HackGenNerd Console"),
    font_size = 14.0,
    color_scheme = "OneHalfDark",
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    -- keybinds
    disable_default_key_bindings = true,
    leader = { key="t", mods="CTRL", timeout_milliseconds=1000 },
    keys={
        { key = "r", mods = "LEADER", action = "ReloadConfiguration" },
        { key = "s", mods = "LEADER", action = "QuickSelect" },
        { key = " ", mods = "LEADER", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
        { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
        { key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
        { key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
        -- tab
        { key = "c", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
        { key = "h", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
        { key = "l", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
    }
}
