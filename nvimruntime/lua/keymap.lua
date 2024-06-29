local M = {
  setup = function()
    -- Remap leader and local leader to <Space>
    vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    vim.keymap.set("n", "<C-d>", ":qa<CR>", { noremap = true })
  end,
}
return M
