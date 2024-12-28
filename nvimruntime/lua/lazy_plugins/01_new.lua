return {
  { "uga-rosa/utf8.nvim" },
  { "simeji/winresizer" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    name = "ousttrue/neoskk",
    dir = "E:/repos/github.com/ousttrue/neoskk",
    dev = true,
    -- "ousttrue/neoskk",
    config = function()
      require("neoskk").setup {
        jisyo = vim.fn.expand "~/.skk/SKK-JISYO.L",
      }
      vim.keymap.set("i", "<C-j>", function()
        return require("neoskk").toggle()
      end, {
        remap = false,
        expr = true,
      })
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
