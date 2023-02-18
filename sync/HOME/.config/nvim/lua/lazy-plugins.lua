local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

local plugins = {
  -- { -- colorscheme
  --   "blueshirts/darcula",
  --   config = function()
  --     vim.cmd [[colorscheme darcula]]
  --   end,
  -- },
  "editorconfig/editorconfig-vim",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      vim.api.nvim_set_keymap("n", "<C-_>", "gcc", {})
      vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = require("config.nvim-tree").setup,
  },
  { "ckipp01/stylua-nvim" },
  { "tpope/vim-fugitive" },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("config.telescope").setup,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = function()
    --   require("nvim-treesitter.install").update { with_sync = true }
    -- end,
    config = require("config.nvim-treesitter").setup,
  },
  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
      vim.api.nvim_set_keymap("n", "B", ":OverseerRun<CR>", {})
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = require("config.nvim-dap-ui").setup,
  },
  -- {
  --   "folke/neodev.nvim",
  --   config = function()
  --     -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
  --     require("neodev").setup {
  --       -- add any options here, or leave empty to use the default settings
  --     }
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    config = require("config.nvim-lspconfig").setup,
  },
}

require("lazy").setup(plugins)
