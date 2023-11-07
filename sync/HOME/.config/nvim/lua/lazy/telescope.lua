return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("config.telescope").setup()
    end,
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension "smart_open"
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      -- -- Only required if using match_algorithm fzf
      -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      -- { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },
  -- {
  --   "renerocksai/telekasten.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   config = function()
  --     require("telekasten").setup {
  --       home = vim.fn.expand "~/dotfiles/docs/obsidian", -- Put the name of your notes directory here
  --     }
  --   end,
  -- },
  {
    "epwalsh/obsidian.nvim",
    config = function()
      local obsidian = require "obsidian"
      obsidian.setup {
        workspaces = {
          {
            name = "personal",
            path = "~/dotfiles/docs/obsidian",
          },
        },
        -- log_level = vim.log.levels.DEBUG,
        mappings = {
          -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
          ["gf"] = {
            action = function()
              return obsidian.util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
        },
      }
    end,
  },
}
