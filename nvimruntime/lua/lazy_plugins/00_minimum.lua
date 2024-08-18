--
-- https://lazy.folke.io/spec/examples
--
-- config > opts
return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      animate = {
        enabled = false,
      },
      bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf",            title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
      },
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.5 },
        },
        -- any other neo-tree windows
        "neo-tree",
      },
      right = {
        {
          title = "Aerial",
          ft = "aerial",
          pinned = true,
          -- open = "SymbolsOutlineOpen",
        },
      },
    },
  },
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
  {
    "liangxianzhe/floating-input.nvim",
    config = function()
      vim.ui.input = function(opts, on_confirm)
        require("floating-input").input(opts, on_confirm, { border = "double" })
      end
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
    "haya14busa/vim-edgemotion",
    keys = {
      { "<C-j>", "<Plug>(edgemotion-j)", mode = { "n", "v" } },
      { "<C-k>", "<Plug>(edgemotion-k)", mode = { "n", "v" } },
    },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    config = function()
      require("barbar").setup {}
      vim.keymap.set("n", ")", ":BufferNext<CR>", { noremap = true })
      vim.keymap.set("n", "(", ":BufferPrevious<CR>", { noremap = true })
    end,
    init = function()
      vim.g.barbar_auto_setup = false
    end,
  },
}
