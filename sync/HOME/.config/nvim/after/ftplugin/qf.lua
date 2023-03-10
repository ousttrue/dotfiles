-- vim.cmd "Cfilter / error:/"
vim.keymap.set("n", "<C-n>", ":cnewer<CR>", { buffer = 0, noremap = true })
vim.keymap.set("n", "<C-p>", ":colder<CR>", { buffer = 0, noremap = true })
vim.keymap.set("n", "p", "<CR>zz<C-w>p", { buffer = 0, noremap = true })

-- winbar
vim.api.nvim_win_set_option(0, "winbar", "quickfix: %L")
