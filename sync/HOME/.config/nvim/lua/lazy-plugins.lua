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
    -- "svrana/neosolarized.nvim",
    -- 'rmehri01/onenord.nvim',
    config = function()
      -- vim.cmd "colorscheme everforest"
      vim.cmd "colorscheme nightfox"
      -- require('neosolarized').setup({
      --   comment_italics = true,
      --   background_set = false,
      -- })
      -- require('onenord').setup()
    end,
    dependencies = { 'tjdevries/colorbuddy.nvim' },
  },
  "editorconfig/editorconfig-vim",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/lsp-status.nvim",
    },
    config = function()
      require("config.lualine").setup()
    end,
  },
  -- {
  --   "osyo-manga/vim-precious",
  --   dependencies = { "Shougo/context_filetype.vim" },
  -- },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function() require("config.navic").setup() end,
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
  -- { "averms/black-nvim",
  --   -- run = "UpdateRemotePlugins"
  -- },
  { 'sbdchd/neoformat' },
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-frecency.nvim",
    },
    config = require("config.telescope").setup,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = require("config.telescope-frecency").setup,
    dependencies = { "kkharji/sqlite.lua" },
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
      require('config.overseer').setup()
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
    "folke/lsp-colors.nvim",
    config = require("config.lsp-colors").setup,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --     -- Disable virtual_text since it's redundant due to lsp_lines.
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    config = function() require("config.trouble").setup() end,
    dependencies = { "nvim-tree/nvim-web-devicons", },
  },
  {
    "onsails/lspkind.nvim",
    config = function() require("config.lspkind").setup() end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- tag = "v1.*",
    config = function() require("config.LuaSnip").setup() end,
    dependencies = { "rafamadriz/friendly-snippets", },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      -- "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
      -- "hrsh7th/vim-vsnip-integ",
    },
    config = function() require("config.nvim-cmp").setup() end,
    event = "InsertEnter",
  },
  {
    'simeji/winresizer'
  },
  { 'windwp/nvim-autopairs',
    config = function() require("nvim-autopairs").setup() end,
  },
  {
    "akinsho/bufferline.nvim",
    tag = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("config.bufferline").setup() end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function() require("config.nvim-hlslens").setup() end,
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = "kevinhwang91/nvim-hlslens",
    config = function() require("config.nvim-scrollbar").setup() end,
  },
  { "jghauser/mkdir.nvim", },
  -- { "hrsh7th/cmp-nvim-lsp",  },
}

require("lazy").setup(plugins)
