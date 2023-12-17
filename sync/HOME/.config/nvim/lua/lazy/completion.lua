return {
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- tag = "v1.*",
  --   config = function()
  --     require("config.LuaSnip").setup()
  --   end,
  --   -- dependencies = { "rafamadriz/friendly-snippets", },
  -- },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      --
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      --
      -- "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
      -- "hrsh7th/vim-vsnip-integ",
    },
    config = function()
      require("config.nvim-cmp").setup()
    end,
    event = "InsertEnter",
  },
  -- {
  --   "nvimdev/epo.nvim",
  --   config = function()
  --     -- suggested completeopt
  --     vim.opt.completeopt = "menu,menuone,noselect"
  --
  --     -- default settings
  --     require("epo").setup {
  --       -- fuzzy match
  --       fuzzy = false,
  --       -- increase this value can aviod trigger complete when delete character.
  --       debounce = 50,
  --       -- when completion confrim auto show a signature help floating window.
  --       signature = true,
  --       -- vscode style json snippet path
  --       snippet_path = nil,
  --       -- border for lsp signature popup, :h nvim_open_win
  --       signature_border = "rounded",
  --       -- lsp kind formatting, k is kind string "Field", "Struct", "Keyword" etc.
  --       kind_format = function(k)
  --         return k:lower():sub(1, 1)
  --       end,
  --     }
  --   end,
  -- },
}
