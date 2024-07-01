local M = {
  setup = function()
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

    vim.cmd "colorschem habamax"
  end,
}
return M
