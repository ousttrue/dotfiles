local M = {}
function M.setup()
    vim.api.nvim_set_keymap("n", "<C-/>", ":Commentary<CR>", { noremap = true })
    vim.api.nvim_set_keymap("", "<C-/>", ":Commentary<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<C-_>", ":Commentary<CR>", { noremap = true })
    vim.api.nvim_set_keymap("", "<C-_>", ":Commentary<CR>", { noremap = true })
end
return M
