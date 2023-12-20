return {
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = require("config.nvim-tree").setup,
  -- },
  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require("nvim-web-devicons").setup {
  --       override = {
  --         fs = {
  --           icon = "󰯙 ",
  --           -- color = "#3178C6", -- TypeScriptの色
  --         },
  --         vs = {
  --           icon = "󰯙 ",
  --           -- color = "#3178C6", -- TypeScriptの色
  --         },
  --         gs = {
  --           icon = "󰯙 ",
  --           -- color = "#3178C6", -- TypeScriptの色
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = require("config.neo-tree").setup,
  },
}
