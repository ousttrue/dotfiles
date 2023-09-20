return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        mappings = { basic = false, extra = false },
      }

      local api = require "Comment.api"
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

      -- Toggle current line (linewise) using C-/
      vim.keymap.set("n", "<C-_>", api.toggle.linewise.current)

      -- Toggle selection (linewise)
      vim.keymap.set("x", "<C-_>", function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end)
    end,
  },
  {
    "ckipp01/stylua-nvim",
    config = function()
      if vim.bo.filetype == 'lua' then
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "ff", require("stylua-nvim").format_file, opts)
      else
        vim.keymap.set("n", "ff", vim.lsp.buf.format, { noremap = true })
      end
    end
  },
  -- {
  --   "nvimdev/guard.nvim",
  --   -- Builtin configuration, optional
  --   dependencies = {
  --     "nvimdev/guard-collection",
  --   },
  --   config = function()
  --     local ft = require "guard.filetype"
  --     ft("lua"):fmt "stylua"
  --     ft("c"):fmt "lsp"
  --     ft("cpp"):fmt "lsp"
  --   end,
  -- },
  {
    "folke/neodev.nvim",
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup {
        -- add any options here, or leave empty to use the default settings
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.nvim-lspconfig").setup()
    end,
    dependencies = {
      -- "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      -- "rcarriga/nvim-notify",
      -- "b0o/schemastore.nvim",
    },
  },
  { "RRethy/vim-illuminate" },
}
