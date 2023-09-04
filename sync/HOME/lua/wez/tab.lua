---@class wezterm
local wezterm = require "wezterm"
local PATH = require "common.path"
local UTIL = require "wez.util"
local COM = require "common"

-- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local TAB_LEFT = utf8.char(0xe0ba)
-- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
local TAB_RIGHT = utf8.char(0xe0b8)
local NORMAL_TAB_BG = "#222222"
local NORMAL_TAB_FG = { Color = "#dddddd" }
local ACTIVE_TAB_BG = { Color = "#52307c" }
local TAB_BAR_BG = "#aaaaaa"
local TAB_FG_ACTIVE = "#aaf"
local TAB_FG_INACTIVE = "#666"
-- Color palette for the backgrounds of each cell
local colors = {
  "#3c1361",
  "#52307c",
  "#663a82",
  "#7c5295",
  "#b491c8",
}

local system_map = {
  windows = " ",
  wsl = " 🐧",
  linux = " ",
  osx = " ",
}

local subsystem_map = {
  msys = "Ⓜ ",
  ubuntu = " ",
}

local day_map = {
  ["0"] = "日",
  ["1"] = "月",
  ["2"] = "火",
  ["3"] = "水",
  ["4"] = "木",
  ["5"] = "金",
  ["6"] = "土",
}

---
--- https://wezfurlong.org/wezterm/config/lua/window-events/format-window-title.html
---
--- TitleBar のフォントは白黒の絵文字のみ？
---
---@param tab table
---@param pane table
---@param tabs table
---@param panes table
---@param config table
---@return string
local function on_format_window_title(tab, pane, tabs, panes, config)
  if tab.active_pane.is_zoomed then
    return "🔎" .. tab.active_pane.title
  end

  -- carbonfox
  return string.format("domain=%s, color_scheme=%s", pane.domain_name, config.color_scheme)
end

---
--- https://wezfurlong.org/wezterm/config/lua/window-events/update-status.html
---
--- [TabBar left]
--- OS/CPU/MEM
---
--- [TabBar right]
--- 天気/時間/日付
---
---@param window table
---@param pane table
local function on_update_status(window, pane)
  -- left
  local system_name, sub_system = COM.get_system()
  local icon = system_map[system_name]
  if icon then
    left_status = icon
  end
  if sub_system then
    icon = subsystem_map[sub_system]
    if icon then
      left_status = icon
    end
  end
  window:set_left_status(wezterm.format {
    {
      Foreground = { Color = "#222222" },
    },
    {
      Text = left_status,
    },
  })

  -- right
  local cells = {
    wezterm.strftime "%-d",
    day_map[wezterm.strftime "%w"],
    wezterm.strftime "%H:%M",
  }
  local right = UTIL.format_cells(cells, colors, TAB_LEFT)
  window:set_right_status(right)
end

---
--- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
---
local function tab_title(tab)
  local title = tab.tab_title
  if title and #title > 0 then
    -- if the tab title is explicitly set, take that
    return title
  end

  title = PATH.basename(tab.active_pane.foreground_process_name)
  if #title > 0 then
    return title
  end

  local uri = PATH.convert_home_dir(tab.active_pane.current_working_dir)
  local name = PATH.basename(uri)
  if name == "" then
    name = uri
  end
  return name
end

---@class Section
---@field Fg string
---@field Bg string
---@field Text string

---@class PowerLine
---@field list Section[]
local PowerLineClass = {
  ---@param self PowerLine
  ---@param section Section
  ---@return PowerLine
  push = function(self, section)
    if section.Fg then
      table.insert(self.list, { Foreground = { Color = section.Fg } })
    end
    if section.Bg then
      table.insert(self.list, { Background = { Color = section.Bg } })
    end
    if section.Text then
      table.insert(self.list, { Text = { Text = section.Text } })
    end
    return self
  end,
}

---@return PowerLine Section[]
local function PowerLine()
  local instance = {
    list = {},
  }
  setmetatable(instance, { __index = PowerLineClass })
  return instance
end

---@param tab
---@param tabs
---@param panes
---@param config
---@param hover
---@param max_width
---@return table
local function on_format_tab_title(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  title = wezterm.truncate_right(title, max_width - 2)

  -- return PowerLine()
  --   :push({
  --     Bg = NORMAL_TAB_BG,
  --     Fg = TAB_BAR_BG,
  --     Text = TAB_LEFT,
  --   })
  --   :push({
  --     Fg = tab.is_active and TAB_FG_ACTIVE or TAB_FG_INACTIVE,
  --     Bg = NORMAL_TAB_BG,
  --     Text = title,
  --   })
  --   :push({
  --     Fg = NORMAL_TAB_BG,
  --     Bg = TAB_BAR_BG,
  --     Text = TAB_RIGHT,
  --   }).list

  return {
    { Foreground = { Color = NORMAL_TAB_BG } },
    { Background = { Color = TAB_BAR_BG } },
    { Text = TAB_LEFT },
    { Foreground = { Color = tab.is_active and TAB_FG_ACTIVE or TAB_FG_INACTIVE } },
    { Background = { Color = NORMAL_TAB_BG } },
    { Text = title },
    { Foreground = { Color = NORMAL_TAB_BG } },
    { Background = { Color = TAB_BAR_BG } },
    { Text = TAB_RIGHT },
  }
end

--
-- module
--
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
  -- config.hide_tab_bar_if_only_one_tab = true
  -- config.tab_bar_at_bottom = true
  config.colors = {
    tab_bar = {
      background = TAB_BAR_BG,
    },
  }
  config.status_update_interval = 1000

  wezterm.on("format-window-title", on_format_window_title)
  wezterm.on("format-tab-title", on_format_tab_title)
  wezterm.on("update-status", on_update_status)
end

return M
