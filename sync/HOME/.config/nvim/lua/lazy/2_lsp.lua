-- * none-ls(null-ls)
--   * formatter(stylua)
--   * linter(muon)
--
-- * mason
--   * mason-lspconfig
--   * nvim-lspconfig
--
-- mason 設定時に mason-lspconfig が nvim-lspconfig を登録する？
-- filetype 確定時に、nvim-lspconfig の設定を起動する？
-- * 起動条件を変更？
--
-- おそらく MasinInstall 済みのものが列挙される。
--
return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("config.null-ls").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    config = require("config.mason").setup,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "folke/neodev.nvim",
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup {
        -- add any options here, or leave empty to use the default settings
      }
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("config.nvim-lspconfig").setup()
  --   end,
  --   dependencies = {
  --     -- "hrsh7th/cmp-nvim-lsp",
  --     "folke/neodev.nvim",
  --     -- "rcarriga/nvim-notify",
  --     "b0o/schemastore.nvim",
  --     "creativenull/efmls-configs-nvim",
  --     "SmiteshP/nvim-navbuddy",
  --     -- "williamboman/mason-lspconfig.nvim",
  --   },
  -- },
  -- {
  --   "nvimdev/lspsaga.nvim",
  --   config = function()
  --     require("lspsaga").setup {}
  --   end,
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter", -- optional
  --     "nvim-tree/nvim-web-devicons", -- optional
  --   },
  -- },
}
