return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        override = {
          fs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
          vs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
          gs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
        },
      }
    end,
  },
  {
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.cmd [[
nnoremap <Leader>ta :lua require("telescope").extensions.vstask.tasks()<CR>
nnoremap <Leader>ti :lua require("telescope").extensions.vstask.inputs()<CR>
nnoremap <Leader>ti :lua require("telescope").extensions.vstask.clear_inputs()<CR>
nnoremap <Leader>th :lua require("telescope").extensions.vstask.history()<CR>
nnoremap <Leader>tl :lua require('telescope').extensions.vstask.launch()<cr>
nnoremap <Leader>tj :lua require("telescope").extensions.vstask.jobs()<CR>
nnoremap <Leader>t; :lua require("telescope").extensions.vstask.jobhistory()<CR>
      ]]
    end,
  },
  { "uga-rosa/utf8.nvim" },
  {
    "simeji/winresizer",
    init = function()
      vim.cmd [[
let g:winresizer_start_key = '<Space>e'
      ]]
    end,
  },
  -- { "mistweaverco/kulala.nvim", opts = {} },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- {
  --   "lewis6991/hover.nvim",
  --   config = function()
  --     require("hover").setup {
  --       init = function()
  --         -- Require providers
  --         require "hover.providers.lsp"
  --         require "hover.providers.gh"
  --         -- require('hover.providers.gh_user')
  --         -- require('hover.providers.jira')
  --         -- require('hover.providers.dap')
  --         -- require('hover.providers.fold_preview')
  --         require "hover.providers.diagnostic"
  --         require "hover.providers.man"
  --         require "hover.providers.dictionary"
  --       end,
  --       preview_opts = {
  --         border = "single",
  --       },
  --       -- Whether the contents of a currently open hover window should be moved
  --       -- to a :h preview-window when pressing the hover keymap.
  --       preview_window = false,
  --       title = true,
  --       mouse_providers = {
  --         "LSP",
  --       },
  --       mouse_delay = 1000,
  --     }
  --
  --     -- Setup keymaps
  --     vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  --     vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
  --     vim.keymap.set("n", "[k", function()
  --       require("hover").hover_switch("previous", {})
  --     end, { desc = "hover.nvim (previous source)" })
  --     vim.keymap.set("n", "]k", function()
  --       require("hover").hover_switch("next", {})
  --     end, { desc = "hover.nvim (next source)" })
  --
  --     -- Mouse support
  --     vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
  --     vim.o.mousemoveevent = true
  --
  --     -- Simple
  --     require("hover").register {
  --       name = "neoskk",
  --       priority = 1,
  --
  --       --- @param bufnr integer
  --       enabled = function(bufnr)
  --         return true
  --       end,
  --
  --       --- @param opts Hover.Options
  --       --- @param done fun(result: any)
  --       execute = function(opts, done)
  --         local neoskk = require "neoskk"
  --         if neoskk then
  --           local lines = neoskk.hover()
  --           if lines then
  --             done { lines = lines, filetype = "markdown" }
  --           end
  --         else
  --           done { lines = { "no neoskk" }, filetype = "markdown" }
  --         end
  --       end,
  --     }
  --   end,
  -- },
  -- {
  --   name = "ousttrue/neoskk",
  --   dir = vim.env["GHQ_ROOT"] .. "/github.com/ousttrue/neoskk",
  --   dev = true,
  --   -- "ousttrue/neoskk",
  --   config = function()
  --     require("neoskk").setup {
  --       -- xszd = vim.fn.expand "~/.skk/xszd.txt",
  --       emoji = vim.fn.expand "~/.skk/emoji-data.txt",
  --       kangxi = vim.fn.expand "~/cjkvi-dict/kx2ucs.txt",
  --       -- chinadat = vim.fn.expand "~/.skk/chinadat.csv",
  --       -- ghq get https://github.com/syimyuzya/guangyun0704
  --       guangyun = vim.fs.joinpath(
  --         os.getenv "GHQ_ROOT",
  --         "/github.com/syimyuzya/guangyun0704/Kuankhiunn0704-semicolon.txt"
  --       ),
  --       user = vim.fn.expand "~/dotfiles/user_dict.json",
  --     }
  --     local opts = {
  --       remap = false,
  --       expr = true,
  --     }
  --     vim.keymap.set("i", "<C-j>", function()
  --       local neoskk = require "neoskk"
  --       return neoskk.toggle()
  --     end, opts)
  --     vim.keymap.set("i", "<C-b>", function()
  --       local neoskk = require "neoskk"
  --       return neoskk.toggle "zhuyin"
  --     end, opts)
  --
  --     vim.api.nvim_create_user_command("NeoSkkReload", function()
  --       require("neoskk").reload_dict()
  --     end, {})
  --   end,
  -- },
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   },
  --   keys = {
  --     {
  --       "<leader>?",
  --       function()
  --         require("which-key").show {
  --           -- global = false,
  --         }
  --       end,
  --       desc = "Buffer Local Keymaps (which-key)",
  --     },
  --   },
  -- },
}
