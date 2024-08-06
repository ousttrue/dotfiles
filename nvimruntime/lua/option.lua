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
    -- vim.cmd[[set iskeyword-=_]]

    vim.opt.signcolumn = "yes" -- Always show sign column
    vim.opt.showtabline = 3
    vim.opt.laststatus = 3
    vim.opt.number = false

    -- for tmux
    vim.opt.termguicolors = true -- Enable colors in terminal

    -- buffer
    vim.opt.fileformats = "unix"

    -- lsp
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = {
        -- severity_limit = "Hint",
        severity_limit = "Warning",
      },
      virtual_text = {
        severity_limit = "Warning",
      },
    })
  end,
}

return M
