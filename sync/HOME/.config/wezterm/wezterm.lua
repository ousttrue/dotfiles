local wezterm = require "wezterm"

---@return string
local function get_home()
  return os.getenv "HOME" or os.getenv "USERPROFILE"
end

local config = {
  use_ime = true,
  enable_kitty_graphics = true,
  -- font
  font = wezterm.font "HackGenNerd Console",
  -- color_scheme = "OneHalfDark",
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  -- keybinds
  disable_default_key_bindings = true,
  -- leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    --     { key = "r", mods = "LEADER", action = "ReloadConfiguration" },
    --     { key = "q", mods = "LEADER", action = wezterm.action { CloseCurrentTab = { confirm = false } } },
    --     { key = "c", mods = "LEADER", action = "ShowLauncher" },
    --     { key = "s", mods = "LEADER", action = "QuickSelect" },
    --     { key = " ", mods = "LEADER", action = wezterm.action { PasteFrom = "PrimarySelection" } },
    --     { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action { CopyTo = "Clipboard" } },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action { PasteFrom = "Clipboard" } },
    { key = "Insert", mods = "SHIFT", action = wezterm.action { PasteFrom = "Clipboard" } },
    -- { key = "v", mods = "CTRL", action = wezterm.action { PasteFrom = "Clipboard" } },
    --     -- tab
    --     { key = "c", mods = "ALT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    --     { key = "h", mods = "ALT", action = wezterm.action { ActivateTabRelative = -1 } },
    --     { key = "l", mods = "ALT", action = wezterm.action { ActivateTabRelative = 1 } },
    --     { key = "LeftArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = -1 } },
    --     { key = "RightArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = 1 } },
  },
}

config.warn_about_missing_glyphs = false
config.initial_cols = 120
config.initial_rows = 56

config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }
table.insert(config.keys, { key = "r", mods = "LEADER", action = "ReloadConfiguration" })
table.insert(config.keys, { key = "c", mods = "ALT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } })
table.insert(config.keys, { key = ",", mods = "ALT", action = wezterm.action { ActivateTabRelative = -1 } })
table.insert(config.keys, { key = ".", mods = "ALT", action = wezterm.action { ActivateTabRelative = 1 } })
table.insert(config.keys, { key = "LeftArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = -1 } })
table.insert(config.keys, { key = "RightArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = 1 } })
table.insert(config.keys, { key = "[", mods = "LEADER", action = "ActivateCopyMode" })
table.insert(config.keys, { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) })
table.insert(config.keys, { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) })

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  --
  -- Windows
  --
  -- config.default_prog = { "C:/Python310/Scripts/xonsh.exe" }
  config.font_size = 14.0 -- 4k monitor with DPI scaling
  -- config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }
  config.default_prog = { "nyagos.exe" }
  config.set_environment_variables = {
    LUA_PATH = get_home() .. "\\.config\\nyagos\\?.lua",
  }
else
  --
  -- Linux
  --
  if wezterm.gui == nil or wezterm.gui.screens().main.width > 3500 then
    -- 14 x 1.5
    config.font_size = 21.0 -- raw font size
  else
    config.font_size = 12.0 -- raw font size
  end
  config.default_prog = { "bash" }
end

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function convert_home_dir(path)
  local cwd = path
  local home = get_home()
  cwd = cwd:gsub("^" .. home .. "/", "~/")
  return cwd
end

--
-- tab name
--
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local user_title = tab.active_pane.user_vars.panetitle
  if user_title ~= nil and #user_title > 0 then
    return {
      { Text = tab.tab_index + 1 .. ":" .. user_title },
    }
  end

  local title = wezterm.truncate_right(basename(tab.active_pane.foreground_process_name), max_width)
  if title == "" then
    local uri = convert_home_dir(tab.active_pane.current_working_dir)
    local name = basename(uri)
    if name == "" then
      name = uri
    end
    title = wezterm.truncate_right(name, max_width)
  end
  return {
    { Text = tab.tab_index + 1 .. ":" .. title },
  }
end)

return config
