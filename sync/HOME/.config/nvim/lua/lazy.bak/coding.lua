local DOT = require "dot"

return {
  { "neovim/nvim.net" },
  { "simeji/winresizer" },
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

      local ft = require "Comment.ft"
      ft.vala = { "//%s", "/*%s*/" }
    end,
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
    config = function()
      require("config.nvim-lspconfig").setup()
    end,
    dependencies = {
      -- "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      -- "rcarriga/nvim-notify",
      -- "b0o/schemastore.nvim",
      -- "creativenull/efmls-configs-nvim",
    },
  },
  -- { "RRethy/vim-illuminate" },
  -- { "tikhomirov/vim-glsl" },
  { "vala-lang/vala.vim" },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      local ccc = require "ccc"
      -- local mapping = ccc.mapping

      ccc.setup {
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
      }
    end,
  },
  { "tpope/vim-surround" },
  { "elel-dev/vim-astro-syntax" },
  -- fs
  -- { "autozimu/LanguageClient-neovim" },
  -- { "johngalambos/neovim-fsharp" },
  -- {
  --   "ionide/Ionide-vim",
  --   config = function()
  --     require("ionide").setup {}
  --   end,
  -- },
}
