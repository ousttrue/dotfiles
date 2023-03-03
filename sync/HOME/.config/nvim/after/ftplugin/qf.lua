-- vim.cmd "Cfilter / error:/"
vim.keymap.set("n", "p", "<CR>zz<C-w>p", { buffer = 0, noremap = true })

-- winbar
vim.cmd [[
setlocal winbar=quickfix:\ %L
]]
