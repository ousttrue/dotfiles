--
-- https://lazy.folke.io/spec/examples
--
-- config > opts
return {
  { "nvim-lua/plenary.nvim" },
  { "mattn/emmet-vim" },
  { "tpope/vim-fugitive" },
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
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
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
