return {
  "folke/which-key.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.nvim-lspconfig").setup()
    end,
    dependencies = {
      -- "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      -- "rcarriga/nvim-notify",
      -- "b0o/schemastore.nvim",
      "creativenull/efmls-configs-nvim",
      "SmiteshP/nvim-navbuddy",
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim", -- Optional
      "nvim-telescope/telescope.nvim", -- Optional
    },
    config = function()
      require("config.navbuddy").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = {
    --   "nvim-tree/nvim-web-devicons",
    -- },
    config = function()
      require("config.lualine").setup()
    end,
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require("barbar").setup {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
      }
      vim.keymap.set("n", ")", ":BufferNext<CR>", { noremap = true })
      vim.keymap.set("n", "(", ":BufferPrevious<CR>", { noremap = true })
    end,
  },
  {
    "simeji/winresizer",
  },
  -- {
  --   "tyru/open-browser.vim",
  --   config = function()
  --     vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)")
  --   end,
  -- },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = true,
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    -- https://github.com/monaqa/dial.nvim
    "monaqa/dial.nvim",
    config = function()
      vim.cmd [[
nmap  <C-a>  <Plug>(dial-increment)
nmap  <C-x>  <Plug>(dial-decrement)
nmap g<C-a> g<Plug>(dial-increment)
nmap g<C-x> g<Plug>(dial-decrement)
vmap  <C-a>  <Plug>(dial-increment)
vmap  <C-x>  <Plug>(dial-decrement)
vmap g<C-a> g<Plug>(dial-increment)
vmap g<C-x> g<Plug>(dial-decrement)
      ]]
    end,
  },
  -- {
  --   "max397574/colortils.nvim",
  --   cmd = "Colortils",
  --   config = function()
  --     require("colortils").setup()
  --   end,
  -- },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      vim.opt.termguicolors = true

      local ccc = require "ccc"
      local mapping = ccc.mapping

      ccc.setup {
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        mappings = {
          ["<ESC>"] = mapping.quit,
          [","] = mapping.decrease10,
          ["."] = mapping.increase10,
        },
      }

      vim.keymap.set("n", "gc", ":CccPick<CR>")
    end,
  },
  {
    "mattn/emmet-vim",
  },
}

