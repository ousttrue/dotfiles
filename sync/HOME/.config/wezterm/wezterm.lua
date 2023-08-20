---@class wezterm
local wezterm = require "wezterm"

local function file_exists(path)
  return #wezterm.glob(path) > 0
end

---@return string|nil
local function get_home()
  local home = os.getenv "HOME"
  if home then
    return home
  end
  home = os.getenv "USERPROFILE"
  if home then
    return home
  end
end
local HOME = get_home()
if not HOME then
  return {
    launch_menu = {
      {
        args = { string.format("%q", os.getenv "HOME") },
      },
    },
    keys = { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
  }
end

local function write_dump()
  wezterm.log_info "write_dump!"
  local f = io.open(HOME .. "/dotfiles/sync/HOME/.config/wezterm/def.lua", "w")
  if f then
    f:write "---@meta\n"
    f:write "\n"
    f:write "---@class wezterm\n"
    f:write "wezterm = {\n"
    for k, v in pairs(wezterm) do
      f:write(string.format("  %s = {},\n", k))
    end
    f:write "}\n"
    f:close()
  end
end

-- local yday = os.date("*t")["yday"]
local yday = 0

local font_list = {
  function()
    -- ⭐
    return wezterm.font("Firge35 Console", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  function()
    -- ⭐
    return wezterm.font("Inconsolata", { weight = "Light", stretch = "Normal", style = "Normal" })
  end,
  function()
    -- ⭐
    return wezterm.font("Anonymous Pro", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  function()
    -- ⭐
    return wezterm.font("Terminus (TTF)", { weight = "Medium", stretch = "Normal", style = "Normal" })
  end,
  -- function()
  --   return wezterm.font("IBM Plex Mono", { weight = "Light", stretch = "Normal", style = "Normal" })
  -- end,
  -- function()
  --   return wezterm.font("Lab Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  function()
    -- ⭐
    return wezterm.font("Sometype Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  -- function()
  --   return wezterm.font("Libertinus Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  -- function()
  --   return wezterm.font("Leftist Mono Sans", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  function()
    -- ⭐
    return wezterm.font("Verily Serif Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  -- function()
  --   return wezterm.font("DejaVu Sans Mono", { weight = "Bold", stretch = "Normal", style = "Normal" })
  -- end,
  -- function()
  --   return wezterm.font("Consolas", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  function()
    -- ⭐
    return wezterm.font("Fira Code", { weight = "Light", stretch = "Normal", style = "Normal" })
  end,
}

local today_font = font_list[(yday % #font_list) + 1]

local themes = {
  "Afterglow",
  "Atelier Dune Light (base16)",
  "Azu (Gogh)",
  "Belafonte Day",
  "Black Metal (base16)",
  "carbonfox",
  "Chalk",
  "Ciapre",
  "DimmedMonokai",
  "Fahrenheit",
  "ForestBlue",
  "Green Screen (base16)",
  "Hacktober",
  "idleToes",
  "Man Page",
  "MonaLisa",
  "N0tch2k",
  "nightfox",
  "Operator Mono Dark",
  "Relaxed",
  "Royal",
  "Seafoam Pastel",
  "SeaShells",
  "vimbones",
}
local color_scheme = themes[(yday % #themes) + 1]

local data = "XXX"

local config = {
  use_ime = true,
  -- enable_kitty_graphics = true,
  -- font
  -- font = wezterm.font "HackGenNerd Console",
  -- font = wezterm.font_with_fallback {
  --   "Fira Code",
  --   "DengXian",
  -- },

  color_scheme = color_scheme,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  -- keybinds
  disable_default_key_bindings = true,
  -- leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    --     { key = "r", mods = "LEADER", action = "ReloadConfiguration" },
    --     { key = "q", mods = "LEADER", action = wezterm.action { CloseCurrentTab = { confirm = false } } },
    --     { key = "c", mods = "LEADER", action = "ShowLauncher" },
    { key = " ", mods = "CTRL|SHIFT", action = "QuickSelect" },
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
  launch_menu = {
    {
      args = { "top" },
    },
    {
      -- Optional label to show in the launcher. If omitted, a label
      -- is derived from the `args`
      label = "XXXBash",
      -- The argument array to spawn.  If omitted the default program
      -- will be used as described in the documentation above
      args = { "bash", "-l" },

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
  },
}

if wezterm.target_triple:find "windows" then
  -- config.font = today_font()
  config.initial_cols = 126
  config.initial_rows = 56
end

config.warn_about_missing_glyphs = false

config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 }
table.insert(config.keys, { key = "r", mods = "LEADER", action = "ReloadConfiguration" })
-- table.insert(config.keys, {
--   key = "c",
--   mods = "ALT",
--   action = wezterm.action.SpawnCommandInNewTab {
--     domain = "CurrentPaneDomain",
--     cwd = "/home/ousttrue",
--   },
-- })
-- table.insert(config.keys, { key = ",", mods = "ALT", action = wezterm.action { ActivateTabRelative = -1 } })
-- table.insert(config.keys, { key = ".", mods = "ALT", action = wezterm.action { ActivateTabRelative = 1 } })
table.insert(config.keys, { key = "LeftArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = -1 } })
table.insert(config.keys, { key = "RightArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = 1 } })
-- table.insert(config.keys, { key = "[", mods = "LEADER", action = "ActivateCopyMode" })
--table.insert(config.keys, { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) })
--table.insert(config.keys, { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) })

-- ???
-- https://github.com/wez/wezterm/discussions/556
table.insert(config.keys, { key = "/", mods = "CTRL", action = wezterm.action { SendString = "\x1f" } })
-- table.insert(config.keys, { key = "l", mods = "ALT", action = wezterm.action_callback(write_dump) })

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  --
  -- Windows
  --
  config.font_size = 13.0 -- 4k monitor with DPI scaling

  local PWSH = { "C:/Program Files/PowerShell/7/pwsh.exe", "-nologo" }
  -- local NUSHELL = { HOME .. "/.cargo/bin/nu.exe" }
  local NYAGOS = { HOME .. "/local/bin/nyagos.exe" }
  -- if file_exists(NUSHELL[1]) then
  --   config.default_prog = NUSHELL
  if file_exists(NYAGOS[1]) then
    config.default_prog = NYAGOS
    config.set_environment_variables = {
      LUA_PATH = HOME .. "\\.config\\nyagos\\?.lua",
    }
  elseif file_exists(PWSH[1]) then
    config.default_prog = PWSH
  end
else
  --
  -- Linux
  --
  if wezterm.gui == nil or wezterm.gui.screens().main.width > 3500 then
    -- 14 x 1.5
    config.font_size = 21.0 -- raw font size
  else
    config.font_size = 11.0 -- raw font size
  end
  config.default_prog = { "bash" }
end

local wsl_domains = wezterm.default_wsl_domains()

for idx, dom in ipairs(wsl_domains) do
  if dom.name == "WSL:kinetic" then
    dom.default_prog = { "/bin/bash", "--login", "-i" }
  end
end
config.wsl_domains = wsl_domains

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function convert_home_dir(path)
  local cwd = path
  cwd = cwd:gsub("^" .. HOME .. "/", "~/")
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

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  local zoomed = ""
  if tab.active_pane.is_zoomed then
    zoomed = "[Z] "
  end

  local index = ""
  if #tabs > 1 then
    index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
  end

  -- local keys = ""
  -- for k, v in pairs(today_font().font[1]) do
  --   keys = keys .. "," .. k
  -- end

  return string.format("%s: %d [%s] %s%s%s", pane.domain_name, yday, color_scheme, zoomed, index, tab.active_pane.title)
end)

-- config.default_domain = 'WSL:Ubuntu-22.04'

return config
