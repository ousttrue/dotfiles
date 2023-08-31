---@class wezterm
local wezterm = require "wezterm"
local LUC = require "common"
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
local NORMAL_TAB_BG = { Color = "#0b0022" }
local NORMAL_TAB_FG = { Color = "#dddddd" }
local ACTIVE_TAB_BG = { Color = "#52307c" }
local TAB_BAR_BG = { Color = "#444444" }

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
  -- hide_tab_bar_if_only_one_tab = true,
  -- tab_bar_at_bottom = true,
  -- keybinds
  disable_default_key_bindings = true,
  -- leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 },
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
  keys = {},
}

config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 }
table.insert(config.keys, { key = "r", mods = "LEADER", action = "ReloadConfiguration" })
table.insert(config.keys, { key = "[", mods = "LEADER", action = "ActivateCopyMode" })
table.insert(config.keys, { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) })
table.insert(config.keys, { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) })

config.warn_about_missing_glyphs = false

-- ???
-- https://github.com/wez/wezterm/discussions/556
table.insert(config.keys, { key = "/", mods = "CTRL", action = wezterm.action { SendString = "\x1f" } })
-- table.insert(config.keys, { key = "l", mods = "ALT", action = wezterm.action_callback(write_dump) })

--
-- Windows
--
config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.font = today_font()
config.initial_cols = 126
config.initial_rows = 52

table.insert(
  config.keys,
  { key = "q", mods = "LEADER", action = wezterm.action { CloseCurrentTab = { confirm = false } } }
)
table.insert(config.keys, { key = "c", mods = "LEADER", action = "ShowLauncher" })
table.insert(config.keys, { key = " ", mods = "CTRL|SHIFT", action = "QuickSelect" })
table.insert(config.keys, { key = " ", mods = "LEADER", action = wezterm.action { PasteFrom = "PrimarySelection" } })
table.insert(config.keys, { key = "[", mods = "LEADER", action = "ActivateCopyMode" })
-- table.insert(config.keys, { key = "v", mods = "CTRL", action = wezterm.action { PasteFrom = "Clipboard" } })
table.insert(config.keys, { key = "c", mods = "CTRL|SHIFT", action = wezterm.action { CopyTo = "Clipboard" } })
table.insert(config.keys, { key = "v", mods = "CTRL|SHIFT", action = wezterm.action { PasteFrom = "Clipboard" } })
table.insert(config.keys, { key = "Insert", mods = "SHIFT", action = wezterm.action { PasteFrom = "Clipboard" } })

-- tab
table.insert(config.keys, { key = "c", mods = "ALT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } })
table.insert(config.keys, { key = "h", mods = "ALT", action = wezterm.action { ActivateTabRelative = -1 } })
table.insert(config.keys, { key = "l", mods = "ALT", action = wezterm.action { ActivateTabRelative = 1 } })
table.insert(config.keys, { key = "LeftArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = -1 } })
table.insert(config.keys, { key = "RightArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = 1 } })

table.insert(config.keys, { key = ",", mods = "ALT", action = wezterm.action { ActivateTabRelative = -1 } })
table.insert(config.keys, { key = ".", mods = "ALT", action = wezterm.action { ActivateTabRelative = 1 } })
table.insert(config.keys, { key = "LeftArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = -1 } })
table.insert(config.keys, { key = "RightArrow", mods = "ALT", action = wezterm.action { MoveTabRelative = 1 } })

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 13.0 -- 4k monitor with DPI scaling

  local PWSH = { "C:/Program Files/PowerShell/7/pwsh.exe", "-nologo" }
  -- local NUSHELL = { HOME .. "/.cargo/bin/nu.exe" }
  -- local NYAGOS = { HOME .. "/local/bin/nyagos.exe" }
  local NYAGOS = { HOME .. "/go/bin/nyagos.exe" }
  -- if file_exists(NUSHELL[1]) then
  --   config.default_prog = NUSHELL
  if file_exists(NYAGOS[1]) then
    config.default_prog = NYAGOS
  elseif file_exists(PWSH[1]) then
    config.default_prog = PWSH
  end
else
  --
  -- Linux
  --
  local NYAGOS = { HOME .. "/go/bin/nyagos" }
  if file_exists(NYAGOS[1]) then
    config.default_prog = NYAGOS
  else
    config.default_prog = { "bash" }
  end

  if wezterm.gui == nil or wezterm.gui.screens().main.width > 3500 then
    -- 14 x 1.5
    config.font_size = 21.0 -- raw font size
  else
    config.font_size = 11.0 -- raw font size
  end
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

  return string.format(
    "%s:%s: %d [%s] %s%s%s",
    LUC.get_lua_version(),
    pane.domain_name,
    yday,
    color_scheme,
    zoomed,
    index,
    tab.active_pane.title
  )
end)

--
-- tab name
--
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   -- local user_title = tab.active_pane.user_vars.panetitle
--   -- if user_title ~= nil and #user_title > 0 then
--   --   return {
--   --     { Text = tab.tab_index + 1 .. ":" .. user_title },
--   --   }
--   -- end
--
--   local title = wezterm.truncate_right(basename(tab.active_pane.foreground_process_name), max_width)
--   if title == "" then
--     local uri = convert_home_dir(tab.active_pane.current_working_dir)
--     local name = basename(uri)
--     if name == "" then
--       name = uri
--     end
--     title = wezterm.truncate_right(name, max_width)
--   end
--
--   -- if tab.is_active then
--   --   return {
--   --     { Text = tab.tab_index .. ":" .. title },
--   --   }
--   -- else
--   --   return {
--   --     -- { Background = { Color = "blue" } },
--   --     { Text = tab.tab_index .. ":" .. title },
--   --   }
--   -- end
--
--   return {
--     { Attribute = { Italic = false } },
--     { Attribute = { Intensity = hover and "Bold" or "Normal" } },
--     -- { Background = { Color = TAB_BAR_BG } },
--     -- { Foreground = { Color = NORMAL_TAB_FG } },
--     { Text = SOLID_LEFT_ARROW },
--     { Background = { Color = NORMAL_TAB_FG } },
--     { Foreground = { Color = NORMAL_TAB_BG } },
--     { Text = title },
--     -- { Background = { Color = TAB_BAR_BG } },
--     -- { Foreground = { Color = NORMAL_TAB_FG } },
--     { Text = SOLID_RIGHT_ARROW },
--   }
-- end)

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  title = wezterm.truncate_right(title, max_width - 2)
  return {
    { Foreground = { Color = "#FFF" } },
    { Background = { Color = "#000" } },
    { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = tab.is_active and "#D62" or "#AAA" } },
    { Background = { Color = "#FFF" } },
    { Text = title },
    { Foreground = { Color = "#FFF" } },
    { Background = { Color = "#000" } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

-- -- This function returns the suggested title for a tab.
-- -- It prefers the title that was set via `tab:set_title()`
-- -- or `wezterm cli set-tab-title`, but falls back to the
-- -- title of the active pane in that tab.
-- function tab_title(tab_info)
--   local title = tab_info.tab_title
--   -- if the tab title is explicitly set, take that
--   if title and #title > 0 then
--     return title
--   end
--   -- Otherwise, use the title from the active pane
--   -- in that tab
--   return tab_info.active_pane.title
-- end
--
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   local title = tab_title(tab)
--   if tab.is_active then
--     return {
--       { Background = { Color = "blue" } },
--       { Text = " " .. title .. " " },
--     }
--   end
--   return title
-- end)

-- wezterm.on("update-right-status", function(window, pane)
--   local date = wezterm.strftime "%Y-%m-%d %H:%M:%S"
--
--   -- Make it italic and underlined
--   window:set_right_status(wezterm.format {
--     { Attribute = { Underline = "Single" } },
--     { Attribute = { Italic = true } },
--     { Text = "Hello " .. date },
--   })
-- end)

wezterm.on("update-right-status", function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {}

  -- Figure out the cwd and host of the current pane.
  -- This will pick up the hostname for the remote host if your
  -- shell is using OSC 7 on the remote host.
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local cwd = ""
    local hostname = ""

    if type(cwd_uri) == "userdata" then
      -- Running on a newer version of wezterm and we have
      -- a URL object here, making this simple!

      cwd = cwd_uri.file_path
      hostname = cwd_uri.host or wezterm.hostname()
    else
      -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
      -- which doesn't have the Url object
      cwd_uri = cwd_uri:sub(8)
      local slash = cwd_uri:find "/"
      if slash then
        hostname = cwd_uri:sub(1, slash - 1)
        -- and extract the cwd from the uri, decoding %-encoding
        cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
          return string.char(tonumber(hex, 16))
        end)
      end
    end

    -- Remove the domain name portion of the hostname
    local dot = hostname:find "[.]"
    if dot then
      hostname = hostname:sub(1, dot - 1)
    end
    if hostname == "" then
      hostname = wezterm.hostname()
    end

    table.insert(cells, cwd)
    table.insert(cells, hostname)
  end

  -- I like my date/time in this style: "Wed Mar 3 08:14"
  local date = wezterm.strftime "%a %b %-d %H:%M"
  table.insert(cells, date)

  -- An entry for each battery (typically 0 or 1 battery)
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
  end

  -- Color palette for the backgrounds of each cell
  local colors = {
    "#3c1361",
    "#52307c",
    "#663a82",
    "#7c5295",
    "#b491c8",
  }

  -- Foreground color for the text across the fade
  local text_fg = "#c0c0c0"

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = " " .. text .. " " })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end)

-- wezterm.on("update-status", function(window, pane)
--
--
-- end)

-- config.default_domain = 'WSL:Ubuntu-22.04'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- wezterm.on("update-right-status", function(window, pane)
--   window:set_left_status "left"
--   window:set_right_status "right"
-- end)

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

config.window_decorations = "TITLE | RESIZE"
config.tab_max_width = 16

-- works together with update-right-status and colors -> tab_bar settings
--
-- config.colors = {
--   tab_bar = {
--     -- new_tab_hover = {
--     --   bg_color = "#ffffff",
--     --   fg_color = "#000000",
--     --   italic = false,
--     -- },
--     background = TAB_BAR_BG,
--   },
-- }

-- config.tab_bar_style = {
--   new_tab = wezterm.format {
--     { Background = { Color = TAB_BAR_BG } },
--     { Foreground = { Color = TAB_BAR_BG } },
--     { Text = SOLID_RIGHT_ARROW },
--     { Background = { Color = ACTIVE_TAB_BG } },
--     { Foreground = { Color = NORMAL_TAB_BG } },
--     { Text = " + " },
--     { Background = { Color = TAB_BAR_BG } },
--     { Foreground = { Color = ACTIVE_TAB_BG } },
--     { Text = SOLID_RIGHT_ARROW },
--   },
--   new_tab_hover = wezterm.format {
--     { Attribute = { Italic = false } },
--     { Attribute = { Intensity = "Bold" } },
--     { Background = { Color = NORMAL_TAB_BG } },
--     { Foreground = { Color = TAB_BAR_BG } },
--     { Text = SOLID_RIGHT_ARROW },
--     { Background = { Color = NORMAL_TAB_BG } },
--     { Foreground = { Color = NORMAL_TAB_FG } },
--     { Text = " + " },
--     { Background = { Color = TAB_BAR_BG } },
--     { Foreground = { Color = NORMAL_TAB_BG } },
--     { Text = SOLID_RIGHT_ARROW },
--   },
-- }

return config
