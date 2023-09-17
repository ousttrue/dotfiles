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
  --   end,
  -- },
  -- { "nanozuki/tabby.nvim" },
  -- {
  -- { "romgrk/barbar.nvim" },
}
