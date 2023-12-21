return {
  { "vim-denops/denops.vim" },
  {
    "tyru/open-browser.vim",
    config = function()
      vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)")
    end,
  },
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
  {
    -- https://github.com/monaqa/dial.nvim
    "monaqa/dial.nvim",
    config = function()
      vim.cmd [[
nmap  <C-a>  <Plug>(dial-increment)
nmap  <C-x>  <Plug>(dial-decrement)
nmap g<C-a> g<Plug>(dial-increment)
nmap g<C-x> g<Plug>(dial-decrement)
vmap  <C-a>  <Plug>(dial-increment)
vmap  <C-x>  <Plug>(dial-decrement)
vmap g<C-a> g<Plug>(dial-increment)
vmap g<C-x> g<Plug>(dial-decrement)
      ]]
    end,
  },
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
}

