local DOT = require "dot"

return {
  { "nvim-lua/plenary.nvim" },
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
      vim.keymap.set("n", "<C-/>", api.toggle.linewise.current)

      -- Toggle selection (linewise)

      function vcomment()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end

      vim.keymap.set("x", "<C-_>", vcomment)
      vim.keymap.set("x", "<C-/>", vcomment)

      local ft = require "Comment.ft"
      ft.vala = { "//%s", "/*%s*/" }
    end,
  },
  -- {
  --   "sbdchd/neoformat",
  --   config = function()
  --     require("config.neoformat").setup()
  --   end,
  -- },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("config.null-ls").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
        ui = {
          check_outdated_packages_on_open = false,
          border = "single",
        },
      }
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          if server_name == "clangd" then
            vim.keymap.set("n", ",,", function()
              vim.cmd "ClangdSwitchSourceHeader"
            end, { noremap = true })
            require("lspconfig").clangd.setup(require("lspconfig.clangd").options)
          else
            require("lspconfig")[server_name].setup {}
          end
        end,
      }
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("config.nvim-lspconfig").setup()
  --   end,
  --   dependencies = {
  --     -- "hrsh7th/cmp-nvim-lsp",
  --     "folke/neodev.nvim",
  --     -- "rcarriga/nvim-notify",
  --     "b0o/schemastore.nvim",
  --     "creativenull/efmls-configs-nvim",
  --     "SmiteshP/nvim-navbuddy",
  --     -- "williamboman/mason-lspconfig.nvim",
  --   },
  -- },

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
}
