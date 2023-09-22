return {
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
    "sbdchd/neoformat",
  },
  {
    "google/vim-codefmt",
    dependencies = {
      "google/vim-maktaba",
      "google/vim-glaive",
    },
  },
  -- {
  --   "ckipp01/stylua-nvim",
  --   config = function()
  --     local function ff()
  --       if vim.bo.filetype == 'lua' then
  --         require("stylua-nvim").format_file()
  --       else
  --         vim.lsp.buf.format()
  --       end
  --     end
  --     vim.keymap.set("n", "ff", ff, { noremap = true })
  --   end
  -- },
  {
    "mhartington/formatter.nvim",
    config = function()
      -- Utilities for creating configurations
      local util = require "formatter.util"

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
              -- Supports conditional formatting
              if util.get_current_buffer_file_name() == "special.lua" then
                return nil
              end

              -- Full specification of configurations is down below and in Vim help
              -- files
              return {
                exe = "stylua",
                args = {
                  -- "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      }
    end,
  },
  -- {
  --   "nvimdev/guard.nvim",
  --   -- Builtin configuration, optional
  --   dependencies = {
  --     "nvimdev/guard-collection",
  --   },
  --   config = function()
  --     local ft = require "guard.filetype"
  --     ft("lua"):fmt "stylua"
  --     ft("c"):fmt "lsp"
  --     ft("cpp"):fmt "lsp"
  --   end,
  -- },
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
      -- "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      -- "rcarriga/nvim-notify",
      -- "b0o/schemastore.nvim",
    },
  },
  { "RRethy/vim-illuminate" },
}
