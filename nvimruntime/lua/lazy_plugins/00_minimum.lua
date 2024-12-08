--
-- https://lazy.folke.io/spec/examples
--
-- config > opts
return {
  -- {
  --   "lewis6991/satellite.nvim",
  --   opts = {
  --     current_only = false,
  --     winblend = 50,
  --     zindex = 40,
  --     excluded_filetypes = {},
  --     width = 2,
  --     handlers = {
  --       cursor = {
  --         enable = true,
  --         -- Supports any number of symbols
  --         symbols = { "⎺", "⎻", "⎼", "⎽" },
  --         -- symbols = { '⎻', '⎼' }
  --         -- Highlights:
  --         -- - SatelliteCursor (default links to NonText
  --       },
  --       search = {
  --         enable = true,
  --         -- Highlights:
  --         -- - SatelliteSearch (default links to Search)
  --         -- - SatelliteSearchCurrent (default links to SearchCurrent)
  --       },
  --       diagnostic = {
  --         enable = true,
  --         signs = { "-", "=", "≡" },
  --         min_severity = vim.diagnostic.severity.HINT,
  --         -- Highlights:
  --         -- - SatelliteDiagnosticError (default links to DiagnosticError)
  --         -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
  --         -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
  --         -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
  --       },
  --       gitsigns = {
  --         enable = true,
  --         signs = { -- can only be a single character (multibyte is okay)
  --           add = "│",
  --           change = "│",
  --           delete = "-",
  --         },
  --         -- Highlights:
  --         -- SatelliteGitSignsAdd (default links to GitSignsAdd)
  --         -- SatelliteGitSignsChange (default links to GitSignsChange)
  --         -- SatelliteGitSignsDelete (default links to GitSignsDelete)
  --       },
  --       marks = {
  --         enable = true,
  --         show_builtins = false, -- shows the builtin marks like [ ] < >
  --         key = "m",
  --         -- Highlights:
  --         -- SatelliteMark (default links to Normal)
  --       },
  --       quickfix = {
  --         signs = { "-", "=", "≡" },
  --         -- Highlights:
  --         -- SatelliteQuickfix (default links to WarningMsg)
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "folke/edgy.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     animate = {
  --       enabled = false,
  --     },
  --     bottom = {
  --       -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
  --       {
  --         ft = "toggleterm",
  --         size = { height = 0.4 },
  --         -- exclude floating windows
  --         filter = function(buf, win)
  --           return vim.api.nvim_win_get_config(win).relative == ""
  --         end,
  --       },
  --       {
  --         ft = "lazyterm",
  --         title = "LazyTerm",
  --         size = { height = 0.4 },
  --         filter = function(buf)
  --           return not vim.b[buf].lazyterm_cmd
  --         end,
  --       },
  --       "Trouble",
  --       {
  --         ft = "qf",
  --         title = "QuickFix",
  --         size = { height = 14 },
  --       },
  --       {
  --         ft = "help",
  --         size = { height = 20 },
  --         -- only show help buffers
  --         filter = function(buf)
  --           return vim.bo[buf].buftype == "help"
  --         end,
  --       },
  --       { ft = "spectre_panel", size = { height = 0.4 } },
  --     },
  --     left = {
  --       -- Neo-tree filesystem always takes half the screen height
  --       {
  --         title = "Neo-Tree",
  --         ft = "neo-tree",
  --         filter = function(buf)
  --           return vim.b[buf].neo_tree_source == "filesystem"
  --         end,
  --         size = { height = 0.5 },
  --       },
  --       -- any other neo-tree windows
  --       "neo-tree",
  --     },
  --     right = {
  --       {
  --         title = "Aerial",
  --         ft = "aerial",
  --         pinned = true,
  --         -- open = "SymbolsOutlineOpen",
  --       },
  --     },
  --   },
  -- },
  {
    "nil70n/floating-help",
    opts = {
      border = "single",
      ratio = 0.9,
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  { "prettier/vim-prettier" },
  { "nvim-lua/plenary.nvim" },
  { "mattn/emmet-vim" },
  { "simeji/winresizer" },
  -- {
  --   -- "vim-scripts/VimIM",
  --   "vimim/vimim",
  --   -- "yuweijun/vim-im",
  --   config = function()
  --     vim.g.vimim_cloud = -1 -- "google,sogou,baidu,qq"
  --     -- vim.g.vimim_map = "tab_as_gi"
  --     -- vim.g.vimim_mode = "dynamic"
  --     vim.g.vimim_mycloud = 0
  --     vim.g.vimim_plugin = vim.fn.fnamemodify("~", ":p") .. "/AppData/Local/nvim-data/lazy/vimim/plugin"
  --     vim.g.vimim_punctuation = 2
  --     vim.g.vimim_shuangpin = 0
  --     vim.g.vimim_toggle = "pinyin" --,google,sogou"
  --   end,
  -- },
  {
    "stevearc/profile.nvim",
    config = function()
      local should_profile = os.getenv "NVIM_PROFILE"
      if should_profile then
        require("profile").instrument_autocmds()
        if should_profile:lower():match "^start" then
          require("profile").start "*"
        else
          require("profile").instrument "*"
        end
      end

      local function toggle_profile()
        local prof = require "profile"
        if prof.is_recording() then
          prof.stop()
          vim.ui.input(
            { prompt = "Save profile to:", completion = "file", default = "profile.json" },
            function(filename)
              if filename then
                prof.export(filename)
                vim.notify(string.format("Wrote %s", filename))
              end
            end
          )
        else
          prof.start "*"
        end
      end
      vim.keymap.set("", "<f1>", toggle_profile)
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        mappings = { basic = false, extra = false },
      }

      -- Toggle current line (linewise) using C-/
      vim.keymap.set("n", "<C-_>", require("Comment.api").toggle.linewise.current)
      vim.keymap.set("n", "<C-/>", require("Comment.api").toggle.linewise.current)

      -- Toggle selection (linewise)
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      local function vcomment()
        vim.api.nvim_feedkeys(esc, "nx", false)
        require("Comment.api").toggle.linewise(vim.fn.visualmode())
      end

      vim.keymap.set("x", "<C-_>", vcomment)
      vim.keymap.set("x", "<C-/>", vcomment)

      -- vala lang
      local ft = require "Comment.ft"
      ft.vala = { "//%s", "/*%s*/" }
    end,
  },
}
