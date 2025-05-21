return {
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    config = require("config.mason").setup,
    dependencies = {
      "b0o/schemastore.nvim",
    },
  },
  -- {
  --   "folke/lazydev.nvim",
  --   ft = "lua", -- only load on lua files
  --   opts = {
  --     library = {
  --       -- See the configuration section for more details
  --       -- Load luvit types when the `vim.uv` word is found
  --       { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  --       "${3rd}/busted/library",
  --       "${3rd}/luassert/library",
  --     },
  --   },
  -- },
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
  { "matsui54/denops-popup-preview.vim" },
}
