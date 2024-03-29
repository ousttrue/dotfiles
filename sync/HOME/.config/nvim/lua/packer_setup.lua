local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  -- My plugins here
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = require("config.nvim-tree").setup,
  }
  use {
    "petertriho/nvim-scrollbar",
    requires = "kevinhwang91/nvim-hlslens",
    config = function()
      require("config.nvim-scrollbar").setup()
    end,
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
      "tpope/vim-fugitive",
    },
    config = function()
      require("config.lualine").setup()
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    -- tag = "v3.*",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("config.bufferline").setup()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- local M = {}
--
-- function M.setup()
--   -- Indicate first time installation
--   local packer_bootstrap = false
--
--   -- packer.nvim configuration
--   local conf = {
--     display = {
--       open_fn = function()
--         return require("packer.util").float { border = "rounded" }
--       end,
--     },
--   }
--
--   -- Check if packer.nvim is installed
--   -- Run PackerCompile if there are changes in this file
--   local function packer_init()
--     local fn = vim.fn
--     local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
--     if fn.empty(fn.glob(install_path)) > 0 then
--       packer_bootstrap = fn.system {
--         "git",
--         "clone",
--         "--depth",
--         "1",
--         "https://github.com/wbthomason/packer.nvim",
--         install_path,
--       }
--       vim.cmd [[packadd packer.nvim]]
--     end
--     vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
--   end
--
--   -- Plugins
--   local function plugins(use)
--     use { "wbthomason/packer.nvim" }
--
--     -- use {
--     --   -- "sainnhe/everforest",
--     --   -- "arcticicestudio/nord-vim",
--     --   "EdenEast/nightfox.nvim",
--     --   config = function()
--     --     -- vim.cmd "colorscheme everforest"
--     --     vim.cmd "colorscheme nightfox"
--     --   end,
--     -- }
--     --
--     -- --    use {
--     -- --      "norcalli/nvim-colorizer.lua",
--     -- --      -- config = require("nvim-colorizer").setup,
--     -- --    }
--     -- --    use "yutkat/confirm-quit.nvim"
--     -- use "jghauser/mkdir.nvim"
--     -- --    -- use { "thinca/vim-quickrun", config = require("config.vim-quickrun").setup }
--     --
--     -- --    use {
--     -- --      "stevearc/overseer.nvim",
--     -- --      config = require("config.overseer").setup,
--     -- --    }
--     --
--     -- use {
--     --   "L3MON4D3/LuaSnip",
--     --   -- tag = "v1.*",
--     --   config = require("config.LuaSnip").setup,
--     -- }
--     --
--     -- --    use { "rcarriga/nvim-notify" }
--     -- use {
--     --   "nvim-lualine/lualine.nvim",
--     --   requires = "nvim-tree/nvim-web-devicons", -- optional, for file icons
--     --   config = require("config.lualine").setup,
--     -- }
--     -- use {
--     --   "akinsho/bufferline.nvim",
--     --   tag = "v2.*",
--     --   requires = "nvim-tree/nvim-web-devicons",
--     --   config = require("config.bufferline").setup,
--     -- }
--     -- use {
--     --   "kevinhwang91/nvim-hlslens",
--     --   config = require("config.nvim-hlslens").setup,
--     -- }
--     -- use {
--     --   "petertriho/nvim-scrollbar",
--     --   requires = "kevinhwang91/nvim-hlslens",
--     --   config = require("config.nvim-scrollbar").setup,
--     -- }
--     -- --    use { "kevinhwang91/nvim-bqf" }
--     --
--     -- use {
--     --   "famiu/bufdelete.nvim",
--     --   config = require("config.bufdelete").setup,
--     -- }
--     --
--     -- --    use {
--     -- --      "goolord/alpha-nvim",
--     -- --      config = require("config.alpha").setup,
--     -- --    }
--     --
--     -- --    use "linkinpark342/xonsh-vim"
--     --
--     -- --    use "andreshazard/vim-logreview"
--     --
--     -- -- git
--     -- use "tpope/vim-fugitive"
--     -- --    use {
--     -- --      "TimUntersberger/neogit",
--     -- --      requires = "nvim-lua/plenary.nvim",
--     -- --      config = require("config.neogit").setup,
--     -- --    }
--     -- use {
--     --   "lewis6991/gitsigns.nvim",
--     --   -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
--     --   config = require("config.gitsigns").setup,
--     -- }
--     -- --    -- use {
--     -- --    --     "sindrets/diffview.nvim",
--     -- --    --     requires = "nvim-lua/plenary.nvim",
--     -- --    -- }
--     -- --    -- use {
--     -- --    --   "rhysd/git-messenger.vim",
--     -- --    --   config = require("config.git-messenger").setup,
--     -- --    -- }
--     -- --
--     -- --    use {
--     -- --      "klen/nvim-config-local",
--     -- --      config = require("config.config-local").setup,
--     -- --    }
--     --
--     -- use {
--     --   "ahmedkhalf/project.nvim",
--     --   config = require("config.project").setup,
--     -- }
--     --
--     -- use {
--     --   "nvim-tree/nvim-tree.lua",
--     --   requires = {
--     --     "nvim-tree/nvim-web-devicons",
--     --   },
--     --   config = require("config.nvim-tree").setup,
--     -- }
--     --
--     -- --    use {
--     -- --      "folke/todo-comments.nvim",
--     -- --      requires = "nvim-lua/plenary.nvim",
--     -- --      config = require("config.todo-comments").setup,
--     -- --    }
--     --
--     -- --    use {
--     -- --      "sidebar-nvim/sidebar.nvim",
--     -- --      config = require("config.sidebar").setup,
--     -- --    }
--     -- --
--     -- use {
--     --   "tpope/vim-commentary",
--     --   config = require("config.vim-commentary").setup,
--     -- }
--     --
--     -- -- telescope
--     -- use "nvim-telescope/telescope-packer.nvim"
--     -- use {
--     --   "nvim-telescope/telescope.nvim",
--     --   tag = "0.1.0",
--     --   -- or                            , branch = '0.1.x',
--     --   requires = {
--     --     "nvim-lua/plenary.nvim",
--     --   },
--     --   config = require("config.telescope").setup,
--     -- }
--     -- --    -- use {
--     -- --    --   "nvim-telescope/telescope-frecency.nvim",
--     -- --    --   config = require("config.telescope-frecency").setup,
--     -- --    --   requires = { "kkharji/sqlite.lua" },
--     -- --    -- }
--     --
--     -- -- treesitter
--     -- use {
--     --   "nvim-treesitter/nvim-treesitter",
--     --   run = function()
--     --     require("nvim-treesitter.install").update { with_sync = true }
--     --   end,
--     --   config = require("config.nvim-treesitter").setup,
--     -- }
--     -- --    use {
--     -- --      "yioneko/nvim-yati",
--     -- --      requires = "nvim-treesitter/nvim-treesitter",
--     -- --      config = require("config.nvim-yati").setup,
--     -- --    }
--     -- --    -- use {
--     -- --    --   "nvim-treesitter/nvim-treesitter-context",
--     -- --    --   config = require("config.nvim-treesitter-context").setup,
--     -- --    -- }
--     -- use {
--     --   "stevearc/aerial.nvim",
--     --   config = require("config.aerial").setup,
--     -- }
--     -- use {
--     --   "m-demare/hlargs.nvim",
--     --   requires = { "nvim-treesitter/nvim-treesitter" },
--     --   config = require("config.hlargs").setup,
--     -- }
--     --
--     -- -- task
--     -- --    use {
--     -- --      "akinsho/toggleterm.nvim",
--     -- --      config = require("config.toggleterm").setup,
--     -- --    }
--     -- --    use {
--     -- --      "yutkat/taskrun.nvim",
--     -- --      config = require("config.taskrun").setup,
--     -- --    }
--     -- --    use {
--     -- --      "Shatur/neovim-tasks",
--     -- --      config = require("config.neovim-tasks").setup,
--     -- --    }
--     --
--     -- -- cmp
--     -- use {
--     --   "onsails/lspkind.nvim",
--     --   config = require("config.lspkind").setup,
--     -- }
--     -- use {
--     --   "hrsh7th/nvim-cmp",
--     --   requires = {
--     --     "hrsh7th/cmp-buffer",
--     --     "hrsh7th/cmp-nvim-lsp",
--     --     "hrsh7th/cmp-nvim-lsp-signature-help",
--     --     "onsails/lspkind.nvim",
--     --   },
--     --   config = require("config.nvim-cmp").setup,
--     -- }
--     --
--     -- -- lua
--     -- use "tjdevries/nlua.nvim"
--     -- --    -- c++
--     -- --    -- use "vim-scripts/a.vim"
--     --
--     -- -- lsp
--     -- use {
--     --   "folke/lsp-colors.nvim",
--     --   config = require("config.lsp-colors").setup,
--     -- }
--     -- use {
--     --   "williamboman/mason.nvim",
--     --   config = require("config.mason").setup,
--     -- }
--     -- use {
--     --   "williamboman/mason-lspconfig.nvim",
--     --   config = require("config.mason-lspconfig").setup,
--     -- }
--     -- use {
--     --   "neovim/nvim-lspconfig",
--     --   requires = {
--     --     "williamboman/mason.nvim",
--     --     "williamboman/mason-lspconfig.nvim",
--     --     "hrsh7th/nvim-cmp",
--     --   },
--     --   config = require("config.nvim-lspconfig").setup,
--     -- }
--     -- --    use {
--     -- --      "glepnir/lspsaga.nvim",
--     -- --      branch = "main",
--     -- --      config = require("config.lspsaga").setup,
--     -- --    }
--     -- --    use {
--     -- --      "folke/trouble.nvim",
--     -- --      requires = "nvim-tree/nvim-web-devicons",
--     -- --      config = require("config.trouble").setup,
--     -- --    }
--     -- use {
--     --   "jose-elias-alvarez/null-ls.nvim",
--     --   config = require("config.null-ls").setup,
--     -- }
--     -- --    use "RRethy/vim-illuminate"
--     -- --    -- use "weilbith/nvim-lsp-smag"
--     -- --    use {
--     -- --      "j-hui/fidget.nvim",
--     -- --      config = require("config.fidget").setup,
--     -- --    }
--     -- --    use {
--     -- --      "simrat39/symbols-outline.nvim",
--     -- --      config = require("config.symbols-outline").setup,
--     -- --    }
--     -- use {
--     --   "SmiteshP/nvim-navic",
--     --   requires = "neovim/nvim-lspconfig",
--     --   -- config = require("config.navic").setup,
--     -- }
--     -- --    use {
--     -- --      "utilyre/barbecue.nvim",
--     -- --      requires = {
--     -- --        "neovim/nvim-lspconfig",
--     -- --        "smiteshp/nvim-navic",
--     -- --        "kyazdani42/nvim-web-devicons", -- optional
--     -- --      },
--     -- --      config = function()
--     -- --        require("barbecue").setup()
--     -- --      end,
--     -- --    }
--
--     if packer_bootstrap then
--       print "Restart Neovim required after installation!"
--       require("packer").sync()
--     end
--   end
--
--   packer_init()
--
--   local packer = require "packer"
--   packer.init(conf)
--   packer.startup(plugins)
-- end
--
-- return M
