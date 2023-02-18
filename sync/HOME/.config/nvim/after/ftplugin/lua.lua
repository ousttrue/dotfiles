vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 120

local opts = { noremap = true, silent = true }
vim.api.nvim_buf_set_keymap(0, "n", "F", [[<cmd>lua require("stylua-nvim").format_file()<CR>]], opts)

