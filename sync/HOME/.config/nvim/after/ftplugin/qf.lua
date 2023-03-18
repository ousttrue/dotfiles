-- vim.cmd "Cfilter / error:/"
-- vim.keymap.set("n", "p", "<CR>zz<C-w>p", { buffer = 0, noremap = true })
--
local qfu = require "qfu"

-- winbar
qfu.win_id = vim.fn.win_getid()

vim.cmd(string.format("autocmd WinClosed %d ++once lua require('qfu').win_id=nil", qfu.win_id))

qfu.set_status()

vim.keymap.set("n", "<Space>f", qfu.Qf_filter, { buffer = 0 })
