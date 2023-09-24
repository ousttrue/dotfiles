return {

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = require("config.nvim-tree").setup,
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
}
