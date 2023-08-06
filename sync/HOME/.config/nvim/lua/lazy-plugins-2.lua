local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local dot = require "dot"
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

local function get_color_scheme()
  local sys = dot.get_system()
  if sys == "wsl" then
    return {
      "paulfrische/reddish.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd [[colorscheme reddish]]
      end,
    }
  else
    return {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
        vim.cmd [[colorscheme tokyonight]]
      end,
    }
  end
end

local plugins = {
  get_color_scheme(),
  { "nvim-lua/plenary.nvim" },
  {
    "simeji/winresizer",
  },
  -- {
  --   "goolord/alpha-nvim",
  --   event = "VimEnter",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   -- opts = { require("alpha.themes.startify").config },
  -- },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("config.dashboard").setup()
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = require("config.nvim-tree").setup,
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = "kevinhwang91/nvim-hlslens",
    config = function()
      require("config.nvim-scrollbar").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.lualine").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    -- tag = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("config.bufferline").setup()
    end,
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = function()
    --   require("nvim-treesitter.install").update { with_sync = true }
    -- end,
    config = require("config.nvim-treesitter").setup,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "kevinhwang91/promise-async",
    },
    config = function()
      require("config.nvim-ufo").setup()
    end,
  },
  -- git
  { "tpope/vim-fugitive" },
  { "rbong/vim-flog" },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
    },
    config = function()
      require("config.telescope").setup()
    end,
  },
  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function()
  --     require("config.telescope-frecency").setup()
  --   end,
  --   dependencies = { "kkharji/sqlite.lua" },
  -- },
  {
    "tyru/open-browser.vim",
    config = function()
      vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)")
    end,
  },
  {
    "voldikss/vim-floaterm",
    config = function()
      require("config.floaterm").setup()
    end,
  },
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      --
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      --
      -- "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
      -- "hrsh7th/vim-vsnip-integ",
    },
    config = function()
      require("config.nvim-cmp").setup()
    end,
    event = "InsertEnter",
  },
  -- comment
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
  -- formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = require("config.null-ls").setup,
  },
  -- lsp
  {
    "folke/neodev.nvim",
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup {
        -- add any options here, or leave empty to use the default settings
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.nvim-lspconfig").setup()
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "rcarriga/nvim-notify",
      "b0o/schemastore.nvim",
    },
  },
  -- outline
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial").setup()
    end,
  },
  -- nu
  {
    "LhKipp/nvim-nu",
    config = function()
      require("nu").setup {
        -- use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
        -- lsp_feature: all_cmd_names is the source for the cmd name completion.
        -- It can be
        --  * a string, which is interpreted as a shell command and the returned list is the source for completions (requires plenary.nvim)
        --  * a list, which is the direct source for completions (e.G. all_cmd_names = {"echo", "to csv", ...})
        --  * a function, returning a list of strings and the return value is used as the source for completions
        -- all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']],
      }
    end,
  },
}

require("lazy").setup(plugins)
