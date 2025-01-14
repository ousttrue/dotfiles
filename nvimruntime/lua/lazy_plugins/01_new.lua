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
        unihan = vim.fn.expand "~/unihan/Unihan_DictionaryLikeData.txt",
        xszd = vim.fn.expand "~/.skk/xszd.txt",
        emoji = vim.fn.expand "~/.skk/emoji-data.txt",
      }
      local opts = {
        remap = false,
        expr = true,
      }
      vim.keymap.set("i", "<C-j>", function()
        local neoskk = require "neoskk"
        return neoskk.toggle()
      end, opts)
      vim.keymap.set("i", "<C-b>", function()
        local neoskk = require "neoskk"
        return neoskk.toggle "zhuyin"
      end, opts)
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
