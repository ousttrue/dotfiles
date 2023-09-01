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

return M
