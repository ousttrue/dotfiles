local wezterm = require "wezterm"

local config = {
    default_prog = { "xonsh" },
    initial_cols = 90,
    initial_rows = 50,
    launch_menu = {},
    enable_kitty_graphics = true,
    -- font
    font = wezterm.font "HackGenNerd Console",
    -- color_scheme = "OneHalfDark",
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    -- keybinds
    disable_default_key_bindings = true,
    leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        { key = "r", mods = "LEADER", action = "ReloadConfiguration" },
        { key = "q", mods = "LEADER", action = wezterm.action { CloseCurrentTab = { confirm = false } } },
        { key = "c", mods = "LEADER", action = "ShowLauncher" },
        { key = "s", mods = "LEADER", action = "QuickSelect" },
        { key = " ", mods = "LEADER", action = wezterm.action { PasteFrom = "PrimarySelection" } },
        { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
        { key = "c", mods = "CTRL|SHIFT", action = wezterm.action { CopyTo = "Clipboard" } },
        -- { key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
        { key = "]", mods = "LEADER", action = wezterm.action { PasteFrom = "Clipboard" } },
        -- tab
        { key = "c", mods = "ALT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
        { key = "h", mods = "ALT", action = wezterm.action { ActivateTabRelative = -1 } },
        { key = "l", mods = "ALT", action = wezterm.action { ActivateTabRelative = 1 } },
    },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.font_size = 13.0
    config.default_prog = { "C:/Python310/Scripts/xonsh.exe" }
    table.insert(config.launch_menu, { label = "wsl", args = { "wsl.exe", "~", "/usr/bin/bash", "--login", "-c", "xonsh" } })

    table.insert(config.launch_menu, { label = "PowerShell 5", args = { "powershell.exe", "-NoLogo" } })
    --table.insert(config.launch_menu, { label = "PowerShell", args = {"pwsh.exe", "-NoLogo"} })
    table.insert(
        config.launch_menu,
        { label = "VS PowerShell 2022", args = { "powershell.exe", "-NoLogo", "-NoExit", "-Command", "devps 17.0" } }
    )
    table.insert(
        config.launch_menu,
        { label = "VS PowerShell 2019", args = { "powershell.exe", "-NoLogo", "-NoExit", "-Command", "devps 16.0" } }
    )
    table.insert(config.launch_menu, { label = "Command Prompt", args = { "cmd.exe" } })
    table.insert(config.launch_menu, {
        label = "VS Command Prompt 2022",
        args = { "powershell.exe", "-NoLogo", "-NoExit", "-Command", "devcmd 17.0" },
    })
    table.insert(config.launch_menu, {
        label = "VS Command Prompt 2019",
        args = { "powershell.exe", "-NoLogo", "-NoExit", "-Command", "devcmd 16.0" },
    })
else
    config.font_size = 12.0
    config.default_prog = { "xonsh" }
    table.insert(config.launch_menu, { label = "zsh", args = { "zsh", "-l" } })
end

return config
