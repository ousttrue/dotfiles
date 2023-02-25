local M = {}

function M.setup()
  require("bufferline").setup {
    options = {
      ---@param buf_number integer
      custom_filter = function(buf_number)
        local name = vim.fn.bufname(buf_number)
        local tab_num = vim.fn.tabpagenr()
        if vim.startswith(name, "term:") then
          return tab_num == 1
        else
          return tab_num ~= 1
        end
      end,
    },
  }

  vim.keymap.set("n", ")", ":BufferLineCycleNext<CR>", { noremap = true })
  vim.keymap.set("n", "(", ":BufferLineCyclePrev<CR>", { noremap = true })
end

return M
