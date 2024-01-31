return {
  "folke/which-key.nvim",
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
  {
    "tyru/columnskip.vim",
    config = function()
      vim.cmd [[
nmap sj <Plug>(columnskip:nonblank:next)
omap sj <Plug>(columnskip:nonblank:next)
xmap sj <Plug>(columnskip:nonblank:next)
nmap sk <Plug>(columnskip:nonblank:prev)
omap sk <Plug>(columnskip:nonblank:prev)
xmap sk <Plug>(columnskip:nonblank:prev)
      ]]
    end,
  },
  {
    "tomasky/bookmarks.nvim",
    -- after = "telescope.nvim",
    event = "VimEnter",
    config = function()
      require("bookmarks").setup {
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
        keywords = {
          ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
          ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
          ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
        },
        on_attach = function(bufnr)
          local bm = require "bookmarks"
          local map = vim.keymap.set
          map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
          map("n", "]m", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", "[m", bm.bookmark_prev) -- jump to previous mark in local buffer
          map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
        end,
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = true,
    },
  },
}
