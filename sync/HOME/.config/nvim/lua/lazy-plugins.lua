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
  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- vim.cmd "colorscheme everforest"
      vim.cmd "colorscheme nightfox"
    end,
  },
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
    config = require("config.gitsigns").setup,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        mappings = { basic = false, extra = false },
      }

      local api = require "Comment.api"
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

      -- Toggle current line (linewise) using C-/
      vim.keymap.set("n", "<C-_>", api.toggle.linewise.current)

      -- Toggle selection (linewise)
      vim.keymap.set("x", "<C-_>", function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end)
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
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "EdenEast/nightfox.nvim",
    },
    config = function()
      require("indent_blankline").setup {
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
      }
    end,
  },
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
    config = function()
      require("config.nvim-lspconfig").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
    end,
  },
  {
    "folke/trouble.nvim",
    config = require("config.trouble").setup,
  },
  {
    "onsails/lspkind.nvim",
    config = require("config.lspkind").setup,
  },
  {
    "L3MON4D3/LuaSnip",
    -- tag = "v1.*",
    config = require("config.LuaSnip").setup,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "rafamadriz/friendly-snippets",
    },
    config = require("config.nvim-cmp").setup,
    event = "InsertEnter",
  },
  -- { "hrsh7th/cmp-nvim-lsp",  },
}

require("lazy").setup(plugins)
