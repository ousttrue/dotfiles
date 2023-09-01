---@class wezterm
local wezterm = require "wezterm"

local M = {}

function M.write_dump()
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

---@param cells table
---@return string
function M.format_cells(cells, colors, SOLID_LEFT_ARROW)
  -- Foreground color for the text across the fade
  local text_fg = "#c0c0c0"

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  local function push(text, is_last)
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

  return wezterm.format(elements)
end

return M
