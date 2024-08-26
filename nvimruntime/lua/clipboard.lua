local M = {
  setup = function()
    -- vim.opt.clipboard = "unnamedplus" -- Access system clipboard
    vim.opt.clipboard:append { "unnamedplus" }
    -- require xclip ? xsel ?
  end,
}
return M
