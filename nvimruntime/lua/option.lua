local M = {
  setup = function()
    vim.opt.belloff = "all"
    vim.opt.hidden = true

    -- qf
    vim.opt.shellpipe = "2>&1| tee"

    -- visual
    vim.opt.splitkeep = "screen"
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
    vim.opt.splitkeep = "screen"

    vim.opt.signcolumn = "yes" -- Always show sign column
    vim.opt.showtabline = 3
    vim.opt.laststatus = 3
    vim.opt.number = false

    -- for tmux
    vim.opt.termguicolors = true -- Enable colors in terminal

    -- buffer
    vim.opt.fileformats = "unix"

    -- diagnostics
    vim.diagnostic.config {
      severity_sort = true,
      underline = true,
      update_in_insert = false,
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
        },
      },
    }

    -- You will likely want to reduce updatetime which affects CursorHold
    -- note: this setting is global and should be set only once
    vim.o.updatetime = 250
    -- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --   group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
    --   callback = function()
    --     vim.diagnostic.open_float(nil, { focus = false })
    --   end,
    -- })
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   buffer = bufnr,
    --   callback = function()
    --     local opts = {
    --       focusable = false,
    --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --       border = "rounded",
    --       source = "always",
    --       prefix = " ",
    --       scope = "cursor",
    --     }
    --     vim.diagnostic.open_float(nil, opts)
    --   end,
    -- })
  end,
}

return M
