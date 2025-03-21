return {
  {
    name = "ousttrue/neomarkdown.nvim",
    -- enabled = false,
    dir = vim.env["GHQ_ROOT"] .. "/github.com/ousttrue/neomarkdown.nvim",
    dev = true,
    -- "ousttrue/neoskk",
    opts = {},
  },
  {
    name = "ousttrue/neoskk",
    -- enabled = false,
    dir = vim.env["GHQ_ROOT"] .. "/github.com/ousttrue/neoskk",
    dev = true,
    -- "ousttrue/neoskk",
    config = function()
      require("neoskk").setup {
        -- xszd = vim.fn.expand "~/.skk/xszd.txt",
        emoji = vim.fn.expand "~/.skk/emoji-data.txt",
        kangxi = vim.fn.expand "~/cjkvi-dict/kx2ucs.txt",
        -- chinadat = vim.fn.expand "~/.skk/chinadat.csv",
        -- ghq get https://github.com/syimyuzya/guangyun0704
        guangyun = vim.fs.joinpath(
          os.getenv "GHQ_ROOT",
          "/github.com/syimyuzya/guangyun0704/Kuankhiunn0704-semicolon.txt"
        ),
        user = vim.fn.expand "~/dotfiles/user_dict.json",
      }
      local opts = {
        remap = false,
        expr = true,
      }
      vim.keymap.set("i", "<C-j>", function()
        local neoskk = require "neoskk"
        return neoskk.toggle()
      end, opts)
      vim.keymap.set("i", "<C-b>", function()
        local neoskk = require "neoskk"
        return neoskk.toggle "zhuyin"
      end, opts)

      vim.keymap.set("v", "~", require("neoskk").kana_toggle, { noremap = true })

      vim.api.nvim_create_user_command("NeoSkkReload", function()
        require("neoskk").reload_dict()
      end, {})
    end,
  },
  -- {
  --   "oysandvik94/curl.nvim",
  --   -- cmd = { "CurlOpen" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {},
  --   -- config = true,
  -- },
  {
    "mvllow/modes.nvim",
    tag = "v0.2.1",
    opts = {},
  },
  {
    "fei6409/log-highlight.nvim",
    opts = {},
  },
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
