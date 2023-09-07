---@class wezterm
local wezterm = require "wezterm"
local PATH = require "common.path"
local STR = require "common.string"
local COM = require "common"
local PL = require "common.powerline"
local PALETTE = require "common.palette"

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
  local domain = pane:get_domain_name()
  local left_status = ""
  if domain == "local" then
    local icon = COM.system_map[system_name]
    if icon then
      left_status = left_status .. icon
    else
      left_status = left_status .. system_name
    end

    if sub_system then
      icon = COM.subsystem_map[sub_system]
      if icon then
        left_status = left_status .. icon
      else
        left_status = left_status .. sub_system
      end
    end
  else
    if STR.starts_with(domain, "WSL") then
      PALETTE.TABBAR_BG = "#dd6644"
      left_status = COM.system_map["wsl"]
    else
      left_status = system_name
    end
  end

  window:set_left_status(wezterm.format(PL.PowerLine():push({
    Fg = PALETTE.TABBAR_FG,
    Bg = PALETTE.TABBAR_BG,
    Text = left_status,
  }).list))

  -- right
  local day = wezterm.strftime "%-d"
  local weekday = COM.day_map[wezterm.strftime "%w"]
  local time = wezterm.strftime "%H:%M"
  window:set_right_status(wezterm.format(PL.PowerLine():push({
    Fg = PALETTE.TABBAR_FG,
    Bg = PALETTE.TABBAR_BG,
    Text = string.format("%s(%s)%s", day, weekday, time),
  }).list))
end

local function pane_title(pane)
  if pane.title and #pane.title > 0 then
    return pane.title
  end

  -- process name
  local title = PATH.basename(pane.foreground_process_name)
  if #title > 0 then
    return title
  end

  -- path
  local uri = PATH.convert_home_dir(tab.active_pane.current_working_dir)
  local name = PATH.basename(uri)
  if name == "" then
    name = uri
  end
  return name
end

---
--- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
---
local function tab_title(tab)
  local title = tab.tab_title
  if title and #title > 0 then
    return title
  end

  return pane_title(tab.active_pane)
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

  local fg = tab.is_active and PALETTE.TAB_FG_ACTIVE or PALETTE.TAB_FG
  local bg = tab.is_active and PALETTE.TAB_BG_ACTIVE or PALETTE.TAB_BG

  return PL.PowerLine()
    :push({
      Fg = bg,
      Bg = PALETTE.TABBAR_BG,
      Text = PALETTE.TAB_LEFT,
    })
    :push({
      Fg = fg,
      Bg = bg,
      Text = title,
    })
    :push({
      Fg = bg,
      Bg = PALETTE.TABBAR_BG,
      Text = PALETTE.TAB_RIGHT,
    }).list
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
      background = PALETTE.TABBAR_BG,
    },
  }
  config.status_update_interval = 1000

  wezterm.on("format-window-title", on_format_window_title)
  wezterm.on("format-tab-title", on_format_tab_title)
  wezterm.on("update-status", on_update_status)
end

return M
