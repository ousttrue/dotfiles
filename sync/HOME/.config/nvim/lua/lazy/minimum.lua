local DOT = require "dot"

return {

  { "nvim-lua/plenary.nvim" },
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

      local ft = require "Comment.ft"
      ft.vala = { "//%s", "/*%s*/" }
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
      "creativenull/efmls-configs-nvim",
    },
  },
  {
    "sbdchd/neoformat",
    config = function()
      require("config.neoformat").setup()
    end,
  },
  { "tpope/vim-fugitive" },
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = {
    --   "nvim-tree/nvim-web-devicons",
    -- },
    config = function()
      require("config.lualine").setup()
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
}
