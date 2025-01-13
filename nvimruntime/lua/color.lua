--
-- " Call method on window enter
-- augroup WindowManagement
--   autocmd!
--   autocmd WinEnter * call Handle_Win_Enter()
-- augroup END
--
-- " Change highlight group of active/inactive windows
-- function! Handle_Win_Enter()
--   setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
-- endfunction

local M = {}

function M.setup()
  vim.o.bg = "dark"

  local SYNTAX_UTIL = require "syntax_util"

  vim.api.nvim_create_autocmd("colorscheme", {
    callback = function(ev)
      SYNTAX_UTIL.clear_syntax_link(ev)
    end,
  })

  vim.cmd [[
autocmd FileType markdown hi link markdownError NONE
]]

  -- vim.cmd "colorschem habamax"
  vim.cmd "colorschem retrobox"


-- Background colors for active vs inactive windows

-- hi ActiveWindow guibg=#17252c
-- hi InactiveWindow guibg=#0D1B22

end

return M
