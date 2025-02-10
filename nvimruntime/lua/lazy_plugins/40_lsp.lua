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
-- おそらく MasonInstall 済みのものが列挙される。
--

return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require("config.null-ls").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "matsui54/denops-popup-preview.vim",
  },
  {
    "williamboman/mason.nvim",
    config = require("config.mason").setup,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },
}
