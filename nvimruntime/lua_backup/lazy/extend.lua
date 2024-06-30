return {
  "marekmaskarinec/vim-umka",
  "rapan931/lasterisk.nvim",
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
    "LhKipp/nvim-nu",
    opts = {
      use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
      -- lsp_feature: all_cmd_names is the source for the cmd name completion.
      -- It can be
      --  * a string, which is evaluated by nushell and the returned list is the source for completions (requires plenary.nvim)
      --  * a list, which is the direct source for completions (e.G. all_cmd_names = {"echo", "to csv", ...})
      --  * a function, returning a list of strings and the return value is used as the source for completions
      all_cmd_names,
    },
  },
  "folke/which-key.nvim",
  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   config = true,
  --   event = { "WinNew" },
  -- },
  {
    "linkinpark342/xonsh-vim",
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",         -- Optional
      "nvim-telescope/telescope.nvim", -- Optional
    },
    config = function()
      require("config.navbuddy").setup()
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = "kevinhwang91/nvim-hlslens",
    config = function()
      require("config.nvim-scrollbar").setup()
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
  --   {
  --     -- https://github.com/monaqa/dial.nvim
  --     "monaqa/dial.nvim",
  --     config = function()
  --       vim.cmd [[
  -- nmap  <C-a>  <Plug>(dial-increment)
  -- nmap  <C-x>  <Plug>(dial-decrement)
  -- nmap g<C-a> g<Plug>(dial-increment)
  -- nmap g<C-x> g<Plug>(dial-decrement)
  -- vmap  <C-a>  <Plug>(dial-increment)
  -- vmap  <C-x>  <Plug>(dial-decrement)
  -- vmap g<C-a> g<Plug>(dial-increment)
  -- vmap g<C-x> g<Plug>(dial-decrement)
  --       ]]
  --     end,
  --   },
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
          map("n", "mi", bm.bookmark_ann)    -- add or edit mark annotation at current line
          map("n", "mc", bm.bookmark_clean)  -- clean all marks in local buffer
          map("n", "]m", bm.bookmark_next)   -- jump to next mark in local buffer
          map("n", "[m", bm.bookmark_prev)   -- jump to previous mark in local buffer
          map("n", "ml", bm.bookmark_list)   -- show marked file list in quickfix window
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

  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          -- Require providers
          require "hover.providers.lsp"
          require "hover.providers.gh"
          require "hover.providers.gh_user"
          -- require('hover.providers.jira')
          -- require('hover.providers.dap')
          -- require('hover.providers.fold_preview')
          -- require('hover.providers.diagnostic')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = "single",
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          "LSP",
        },
        mouse_delay = 1000,
      }

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
      -- vim.keymap.set("n", "<C-p>", function()
      --   require("hover").hover_switch "previous"
      -- end, { desc = "hover.nvim (previous source)" })
      -- vim.keymap.set("n", "<C-n>", function()
      --   require("hover").hover_switch "next"
      -- end, { desc = "hover.nvim (next source)" })

      -- Mouse support
      vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
      vim.o.mousemoveevent = true
    end,
  },
}
