local M = {}

function M.setup()
  require("bufferline").setup {
    options = {
      separator_style = "slant",
      show_close_icon = true,
      -- close_icon = "",
      buffer_close_icon = "",
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      ---@param buf_number integer
      ---@return boolean
      custom_filter = function(buf_number)
        -- local name = vim.fn.bufname(buf_number)
        -- local tab_num = vim.fn.tabpagenr()
        local filetype = vim.api.nvim_buf_get_option(buf_number, "filetype")
        if filetype == "qf" then
          return false
        end

        return true
      end,
    },
  }

  vim.keymap.set("n", ")", ":BufferLineCycleNext<CR>", { noremap = true })
  vim.keymap.set("n", "(", ":BufferLineCyclePrev<CR>", { noremap = true })
  -- vim.keymap.set("n", "<M-l>", ":BufferLineCycleNext<CR>", { noremap = true })
  -- vim.keymap.set("n", "<M-h>", ":BufferLineCyclePrev<CR>", { noremap = true })
end

return M
