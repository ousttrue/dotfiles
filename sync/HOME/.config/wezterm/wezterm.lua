local wezterm = require("wezterm")

return {
    default_prog = {"C:/Python310/Scripts/xonsh.exe"},
    font = wezterm.font("Cica"),
    font_size = 14.0,
    color_scheme = "OneHalfDark",
    hide_tab_bar_if_only_one_tab = true,
    leader = { key="t", mods="CTRL", timeout_milliseconds=1000 },
    keys = {
    },
}
