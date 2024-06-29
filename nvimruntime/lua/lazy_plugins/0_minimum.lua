--
--
--
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
  {
    "liangxianzhe/floating-input.nvim",
    config = function()
      vim.ui.input = function(opts, on_confirm)
        require("floating-input").input(opts, on_confirm, { border = "double" })
      end
    end,
  },
}
