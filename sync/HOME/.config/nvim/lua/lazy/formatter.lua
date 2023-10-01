local DOT = require "dot"

return {
  {
    "sbdchd/neoformat",
    config = function()
      vim.g.neoformat_enabled_html = { "prettier" }
      vim.g.neoformat_enabled_glsl = { "clang-format" }
      vim.g.neoformat_enabled_python = { "black" }
      local function formatter()
        vim.cmd [[:Neoformat]]
      end
      DOT.formatters.lua = formatter
      DOT.formatters.html = formatter
      DOT.formatters.json = formatter
      DOT.formatters.python = formatter
    end,
  },
  {
    "rhysd/vim-clang-format",
    config = function()
      vim.cmd [[let g:clang_format#command = "C:/Program Files/LLVM/bin/clang-format.exe"]]

      local function formatter()
        vim.cmd [[:ClangFormat]]
      end
      DOT.formatters.glsl = formatter
    end,
  },
  -- {
  --   "google/vim-codefmt",
  --   dependencies = {
  --     "google/vim-maktaba",
  --     "google/vim-glaive",
  --   },
  -- },
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
  -- {
  --   "mhartington/formatter.nvim",
  --   config = function()
  --     -- Utilities for creating configurations
  --     local util = require "formatter.util"
  --
  --     -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
  --     require("formatter").setup {
  --       -- Enable or disable logging
  --       logging = true,
  --       -- Set the log level
  --       log_level = vim.log.levels.WARN,
  --       -- All formatter configurations are opt-in
  --       filetype = {
  --         -- Formatter configurations for filetype "lua" go here
  --         -- and will be executed in order
  --         lua = {
  --           -- "formatter.filetypes.lua" defines default configurations for the
  --           -- "lua" filetype
  --           require("formatter.filetypes.lua").stylua,
  --
  --           -- You can also define your own configuration
  --           function()
  --             -- Supports conditional formatting
  --             if util.get_current_buffer_file_name() == "special.lua" then
  --               return nil
  --             end
  --
  --             -- Full specification of configurations is down below and in Vim help
  --             -- files
  --             return {
  --               exe = "stylua",
  --               args = {
  --                 -- "--search-parent-directories",
  --                 "--stdin-filepath",
  --                 util.escape_path(util.get_current_buffer_file_path()),
  --                 "--",
  --                 "-",
  --               },
  --               stdin = true,
  --             }
  --           end,
  --         },
  --
  --         -- Use the special "*" filetype for defining formatter configurations on
  --         -- any filetype
  --         ["*"] = {
  --           -- "formatter.filetypes.any" defines default configurations for any
  --           -- filetype
  --           require("formatter.filetypes.any").remove_trailing_whitespace,
  --         },
  --       },
  --     }
  --   end,
  -- },
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
}
