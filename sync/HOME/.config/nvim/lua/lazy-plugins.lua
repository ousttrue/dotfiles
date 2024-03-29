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
  { "nvim-lua/plenary.nvim" },
  -- {
  --   "blueshirts/darcula",
  --   config = function()
  --     vim.cmd [[colorscheme darcula]]
  --   end,
  -- },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup()
      vim.cmd [[colorscheme nightfox]]
    end,
  },
  -- require("config.colorscheme").plugin,
  "editorconfig/editorconfig-vim",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.lualine").setup()
    end,
  },
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup {
  --       "*",
  --     }
  --   end,
  -- },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      local ccc = require "ccc"
      -- local mapping = ccc.mapping

      ccc.setup {
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
      }
    end,
  },
  -- {
  --   "osyo-manga/vim-precious",
  --   dependencies = { "Shougo/context_filetype.vim" },
  -- },
  -- {
  --   "SmiteshP/nvim-navic",
  --   dependencies = "neovim/nvim-lspconfig",
  --   config = function()
  --     require("config.navic").setup()
  --   end,
  -- },
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
  -- { "ckipp01/stylua-nvim" },
  -- { "averms/black-nvim",
  --   -- run = "UpdateRemotePlugins"
  -- },
  -- { "sbdchd/neoformat" },
  { "tpope/vim-fugitive" },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indent-blankline").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
    },
    config = function()
      require("config.telescope").setup()
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("config.telescope-frecency").setup()
    end,
    dependencies = { "kkharji/sqlite.lua" },
  },
  -- {
  --   "renerocksai/telekasten.nvim",
  --   config = function()
  --     require("config.telekasten").setup()
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = function()
    --   require("nvim-treesitter.install").update { with_sync = true }
    -- end,
    config = require("config.nvim-treesitter").setup,
  },
  -- {
  --   "nvim-treesitter/playground",
  --   config = require("config.nvim-treesitter-playground").setup,
  -- },
  -- {
  --   "stevearc/overseer.nvim",
  --   config = function()
  --     require("config.overseer").setup()
  --   end,
  -- },
  {
    -- amongst your other plugins
    { "akinsho/toggleterm.nvim", version = "*", config = true },
  },
  -- {
  --   "EthanJWright/vs-tasks.nvim",
  --   dependencies = {
  --     "nvim-lua/popup.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "akinsho/toggleterm.nvim",
  --   },
  --   config = function()
  --     require("config.vs-tasks").setup()
  --   end,
  -- },
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
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "rcarriga/nvim-notify",
      "b0o/schemastore.nvim",
    },
  },
  {
    "folke/lsp-colors.nvim",
    config = require("config.lsp-colors").setup,
  },
  -- {
  --   "j-hui/fidget.nvim",
  --   config = function()
  --     require("fidget").setup()
  --   end,
  -- },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --     -- Disable virtual_text since it's redundant due to lsp_lines.
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    config = function()
      require("config.trouble").setup()
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- {
  --   "glepnir/lspsaga.nvim",
  --   event = "LspAttach",
  --   config = function()
  --     require("config.lspsaga").setup()
  --   end,
  --   dependencies = {
  --     { "nvim-tree/nvim-web-devicons" },
  --     --Please make sure you install markdown and markdown_inline parser
  --     { "nvim-treesitter/nvim-treesitter" },
  --   },
  -- },
  {
    "onsails/lspkind.nvim",
    config = function()
      require("config.lspkind").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- tag = "v1.*",
    config = function()
      require("config.LuaSnip").setup()
    end,
    -- dependencies = { "rafamadriz/friendly-snippets", },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
      -- "hrsh7th/vim-vsnip-integ",
    },
    config = function()
      require("config.nvim-cmp").setup()
    end,
    event = "InsertEnter",
  },
  {
    "simeji/winresizer",
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
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
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("config.nvim-hlslens").setup()
    end,
  },
  { "jghauser/mkdir.nvim" },
  -- { "hrsh7th/cmp-nvim-lsp",  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial").setup()
    end,
  },
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("config.hlargs").setup()
    end,
  },
  -- { "sheerun/vim-polyglot" },
  {
    "voldikss/vim-floaterm",
    config = function()
      require("config.floaterm").setup()
    end,
  },
  { "vim-denops/denops.vim" },
  { "vim-denops/denops-helloworld.vim" },
  {
    "vim-skk/skkeleton",
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      require("config.skkeleton").setup()
    end,
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    config = function()
      require("config.skkeleton_indicator").setup {}
    end,
  },
  -- {
  --   'mvllow/modes.nvim',
  --   tag = 'v0.2.0',
  --   config = function()
  --     require('modes').setup()
  --   end
  -- },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
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
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = require("config.null-ls").setup,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("config.nvim-notify").setup()
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   config = function()
  --     require("config.noice").setup()
  --   end,
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   },
  -- },
  -- {
  --   "delphinus/qfheight.nvim",
  --   config = function()
  --     require("qfheight").setup {}
  --   end,
  -- },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("config.dressing").setup()
    end,
  },
  {
    "hrsh7th/nvim-gtd",
    config = function()
      vim.keymap.set("n", "gf", function()
        require("gtd").exec { command = "edit" }
      end)
    end,
  },
  { "honza/vim-snippets" },
  { "hrsh7th/vim-vsnip" },
  { "cespare/vim-toml" },
  -- { "stevearc/stickybuf.nvim" },
  -- { "vim-scripts/a.vim" },
  -- { "kevinhwang91/nvim-bqf" },
  -- {
  --   "https://gitlab.com/yorickpeterse/nvim-pqf.git",
  --   config = function()
  --     require("pqf").setup {
  --       signs = {
  --         error = "E",
  --         warning = "W",
  --         info = "I",
  --         hint = "H",
  --       },
  --       show_multiple_lines = false,
  --     }
  --   end,
  -- },
  -- {
  --   "Bakudankun/BackAndForward.vim",
  --   config = function()
  --     -- vim.keymap.set("n", "<C-p>", "<cmd>Back<CR>", {})
  --     vim.keymap.set("n", "<C-k>", "<cmd>Forward<CR>", {})
  --   end,
  -- },
  {
    "tyru/open-browser.vim",
    config = function()
      vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)")
    end,
  },
  -- { "delphinus/vim-auto-cursorline" },
  -- {
  --   "theHamsta/nvim-semantic-tokens",
  --   config = function()
  --     require("nvim-semantic-tokens").setup {
  --       preset = "default",
  --       -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
  --       -- function with the signature: highlight_token(ctx, token, highlight) where
  --       --        ctx (as defined in :h lsp-handler)
  --       --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
  --       --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
  --       highlighters = { require "nvim-semantic-tokens.table-highlighter" },
  --     }
  --   end,
  -- },
  {
    "weilbith/nvim-lsp-smag",
    config = function()
      vim.api.nvim_set_var("lsp_smag_enabled_providers", { "definition" })
    end,
  },
  -- {
  --   "genkiroid/mdlink-vim",
  --   dependencies = {
  --     "mattn/webapi-vim",
  --     "kana/vim-textobj-user",
  --     "mattn/vim-textobj-url",
  --   },
  --   config = function()
  --     vim.keymap.set("n", "mo", "<cmd>MarkdownLinkOnlyOnCursor<CR>")
  --   end,
  -- },
  { "unblevable/quick-scope" },
  { "tikhomirov/vim-glsl" },
}

require("lazy").setup(plugins)
