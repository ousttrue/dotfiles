-- * none-ls(null-ls)
--   * formatter(stylua)
--   * linter(muon)
--
-- * mason
--   * mason-lspconfig
--   * nvim-lspconfig
--
-- mason 設定時に mason-lspconfig が nvim-lspconfig を登録する？
-- filetype 確定時に、nvim-lspconfig の設定を起動する？
-- * 起動条件を変更？
--
-- おそらく MasonInstall 済みのものが列挙される。
--
return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("config.null-ls").setup()
    end,
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   },
  -- },
  {
    "williamboman/mason.nvim",
    config = require("config.mason").setup,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },
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
    dependencies = {
      -- "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      -- "rcarriga/nvim-notify",
      "b0o/schemastore.nvim",
      "creativenull/efmls-configs-nvim",
      "SmiteshP/nvim-navbuddy",
      -- "williamboman/mason-lspconfig.nvim",
    },
  },
  -- {
  --   "nvimdev/lspsaga.nvim",
  --   config = function()
  --     require("lspsaga").setup {}
  --   end,
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter", -- optional
  --     "nvim-tree/nvim-web-devicons", -- optional
  --   },
  -- },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     vim.diagnostic.config {
  --       virtual_text = false,
  --     }
  --     require("lsp_lines").setup()
  --   end,
  -- },
  -- {
  --   "elixir-tools/elixir-tools.nvim",
  --   version = "*",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local elixir = require "elixir"
  --     local elixirls = require "elixir.elixirls"
  --
  --     elixir.setup {
  --       nextls = { enable = true },
  --       credo = {},
  --       elixirls = {
  --         enable = true,
  --         settings = elixirls.settings {
  --           dialyzerEnabled = false,
  --           enableTestLenses = false,
  --         },
  --         on_attach = function(client, bufnr)
  --           vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --         end,
  --       },
  --     }
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  -- {
  --   "folke/trouble.nvim",
  --   opts = {}, -- for default options, refer to the configuration section for custom setup.
  --   cmd = "Trouble",
  --   keys = {
  --     {
  --       "<leader>xx",
  --       "<cmd>Trouble diagnostics toggle<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>xX",
  --       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --       desc = "Buffer Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>cs",
  --       "<cmd>Trouble symbols toggle focus=false<cr>",
  --       desc = "Symbols (Trouble)",
  --     },
  --     {
  --       "<leader>cl",
  --       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --       desc = "LSP Definitions / references / ... (Trouble)",
  --     },
  --     {
  --       "<leader>xL",
  --       "<cmd>Trouble loclist toggle<cr>",
  --       desc = "Location List (Trouble)",
  --     },
  --     {
  --       "<leader>xQ",
  --       "<cmd>Trouble qflist toggle<cr>",
  --       desc = "Quickfix List (Trouble)",
  --     },
  --   },
  -- },
  -- {
  --   "rmagatti/goto-preview",
  --   event = "BufEnter",
  --   -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  --   opts = {},
  -- },
}
