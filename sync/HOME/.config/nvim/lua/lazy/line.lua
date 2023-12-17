-- tabline
-- winbar
-- statusline

return {
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = {
    --   "nvim-tree/nvim-web-devicons",
    -- },
    config = function()
      require("config.lualine").setup()
    end,
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   -- tag = "v3.*",
  --   -- dependencies = "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require("config.bufferline").setup()
  -- vim.keymap.set("n", ")", ":BufferLineCycleNext<CR>", { noremap = true })
  -- vim.keymap.set("n", "(", ":BufferLineCyclePrev<CR>", { noremap = true })
  --   end,
  -- },
  -- { "nanozuki/tabby.nvim" },
  -- {
  -- { "romgrk/barbar.nvim" },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require("barbar").setup {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
      }
      vim.keymap.set("n", ")", ":BufferNext<CR>", { noremap = true })
      vim.keymap.set("n", "(", ":BufferPrevious<CR>", { noremap = true })
    end,
  },
}
