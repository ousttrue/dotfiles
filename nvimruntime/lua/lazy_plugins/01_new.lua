return {
  {
    "notomo/lreload.nvim",
    config = function()
      for _, x in ipairs {
        "tools.myplugin",
        "tools.iim",
      } do
        require("lreload").enable(x)
      end
    end,
  },
  { "uga-rosa/utf8.nvim" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   },
  --   keys = {
  --     {
  --       "<leader>?",
  --       function()
  --         require("which-key").show {
  --           -- global = false,
  --         }
  --       end,
  --       desc = "Buffer Local Keymaps (which-key)",
  --     },
  --   },
  -- },
}
