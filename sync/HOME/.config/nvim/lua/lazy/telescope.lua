return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "danielfalk/smart-open.nvim",
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    config = function()
      require("config.telescope").setup()
    end,
  },
  -- {
  --   "danielfalk/smart-open.nvim",
  --   branch = "0.2.x",
  --   dependencies = {
  --     "kkharji/sqlite.lua",
  --     -- Only required if using match_algorithm fzf
  --     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  --     -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
  --     { "nvim-telescope/telescope-fzy-native.nvim" },
  --   },
  -- },

  -- {
  --   "danielfalk/smart-open.nvim",
  --   branch = "0.2.x",
  --   config = function()
  --     require("telescope").load_extension "smart_open"
  --   end,
  --   dependencies = {
  --     "kkharji/sqlite.lua",
  --     -- -- Only required if using match_algorithm fzf
  --     -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  --     -- -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
  --     -- { "nvim-telescope/telescope-fzy-native.nvim" },
  --   },
  -- },
  -- {
  --   "renerocksai/telekasten.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   config = function()
  --     require("telekasten").setup {
  --       home = vim.fn.expand "~/dotfiles/docs/obsidian", -- Put the name of your notes directory here
  --     }
  --   end,
  -- },
  --[[   {
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
  }, ]]
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "Allianaab2m/telescope-kensaku.nvim",
        config = function()
          require("telescope").load_extension "kensaku" -- :Telescope kensaku
        end,
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser<CR>", { noremap = true })
    end,
  },
}
