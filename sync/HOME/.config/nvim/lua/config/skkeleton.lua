local M = {}

function M.setup()
  vim.fn["skkeleton#config"]({
    globalJisyo = vim.fn.expand('~/.skk/SKK-JISYO.L')
  })
  vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-enable)')
  vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-enable)')
end

return M
