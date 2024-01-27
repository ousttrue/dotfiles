return {
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- tag = "v1.*",
  --   config = function()
  --     require("config.LuaSnip").setup()
  --   end,
  --   -- dependencies = { "rafamadriz/friendly-snippets", },
  -- },
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/vim-vsnip-integ" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "petertriho/cmp-git",
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
}
