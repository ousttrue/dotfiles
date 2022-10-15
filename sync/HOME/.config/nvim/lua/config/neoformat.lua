local M = {}

function M.setup()
    vim.api.nvim_set_keymap("n", "<S-f>", ":Neoformat<CR>", { noremap = true })
    vim.api.nvim_set_keymap("v", "<S-f>", ":Neoformat<CR>", { noremap = true })
    vim.api.nvim_set_var("neoformat_basic_format_retab", "1")
    vim.g.neoformat_enabled_python = { "yapf" }
end

return M
