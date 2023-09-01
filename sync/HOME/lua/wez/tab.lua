---@class wezterm
local wezterm = require "wezterm"

-- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
-- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b8)
local NORMAL_TAB_BG = { Color = "#222222" }
local NORMAL_TAB_FG = { Color = "#dddddd" }
local ACTIVE_TAB_BG = { Color = "#52307c" }
local TAB_BAR_BG = { Color = "#aaaaaa" }

-- hide_tab_bar_if_only_one_tab = true,
-- tab_bar_at_bottom = true,

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

local function on_format_window_title(tab, pane, tabs, panes, config)
  local zoomed = ""
  if tab.active_pane.is_zoomed then
    zoomed = "[Z] "
  end

  local index = ""
  if #tabs > 1 then
    index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
  end

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
end

local function on_right_status(window, pane)
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
end

local function on_format_tab_title(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  title = wezterm.truncate_right(title, max_width - 1)
  return {
    -- { Foreground = NORMAL_TAB_BG },
    -- { Background = TAB_BAR_BG },
    -- { Text = SOLID_LEFT_ARROW },
    { Foreground = { Color = tab.is_active and "#aaf" or "#666" } },
    { Background = NORMAL_TAB_BG },
    { Text = title },
    { Foreground = NORMAL_TAB_BG },
    { Background = TAB_BAR_BG },
    { Text = SOLID_RIGHT_ARROW },
  }
end

local M = {}

---@param config table
function M.setup(config)
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
  config.use_fancy_tab_bar = false
  config.show_tabs_in_tab_bar = true
  config.show_new_tab_button_in_tab_bar = false
  config.tab_and_split_indices_are_zero_based = true
  config.window_decorations = "TITLE | RESIZE"
  config.tab_max_width = 16
  config.colors = { tab_bar = { background = "#aaaaaa" } }

  wezterm.on("format-window-title", on_format_window_title)

  wezterm.on("update-status", on_right_status)

  wezterm.on("format-tab-title", on_format_tab_title)
end

return M
