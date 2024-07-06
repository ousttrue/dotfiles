local M = {
  setup = function()
    vim.opt.belloff = "all"
    vim.opt.hidden = true

    -- visual
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.list = true
    vim.opt.listchars = {
      eol = "$",
      tab = ">-",
      trail = "~",
      extends = ">",
      precedes = "<",
      conceal = "_",
    }

    vim.opt.signcolumn = "yes" -- Always show sign column
    vim.opt.showtabline = 3
    vim.opt.laststatus = 3
    vim.opt.number = false

    -- for tmux
    vim.opt.termguicolors = true -- Enable colors in terminal

    -- buffer
    vim.opt.fileformats = "unix"
  end,
}

return M
