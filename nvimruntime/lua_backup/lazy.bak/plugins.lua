return {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  {
    "simeji/winresizer",
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = "kevinhwang91/nvim-hlslens",
    config = function()
      require("config.nvim-scrollbar").setup()
    end,
  },
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  -- {
  --   "monaqa/dial.nvim",
  --   config = function()
  --     vim.keymap.set("n", "<C-a>", function()
  --       require("dial.map").manipulate("increment", "normal")
  --     end)
  --     vim.keymap.set("n", "<C-x>", function()
  --       require("dial.map").manipulate("decrement", "normal")
  --     end)
  --     vim.keymap.set("n", "g<C-a>", function()
  --       require("dial.map").manipulate("increment", "gnormal")
  --     end)
  --     vim.keymap.set("n", "g<C-x>", function()
  --       require("dial.map").manipulate("decrement", "gnormal")
  --     end)
  --     vim.keymap.set("v", "<C-a>", function()
  --       require("dial.map").manipulate("increment", "visual")
  --     end)
  --     vim.keymap.set("v", "<C-x>", function()
  --       require("dial.map").manipulate("decrement", "visual")
  --     end)
  --     vim.keymap.set("v", "g<C-a>", function()
  --       require("dial.map").manipulate("increment", "gvisual")
  --     end)
  --     vim.keymap.set("v", "g<C-x>", function()
  --       require("dial.map").manipulate("decrement", "gvisual")
  --     end)
  --   end,
  -- },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = true,
      }
    end,
  },
  {
    "tyru/open-browser.vim",
    config = function()
      vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)")
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = true,
    },
  },
}
