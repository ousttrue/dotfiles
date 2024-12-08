return {
  {
    "liangxianzhe/floating-input.nvim",
    config = function()
      vim.ui.input = function(opts, on_confirm)
        require("floating-input").input(opts, on_confirm, { border = "double" })
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.lualine").setup()
    end,
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    config = function()
      require("barbar").setup {}
      vim.keymap.set("n", ")", ":BufferNext<CR>", { noremap = true })
      vim.keymap.set("n", "(", ":BufferPrevious<CR>", { noremap = true })
    end,
    init = function()
      vim.g.barbar_auto_setup = false
    end,
  },
}
