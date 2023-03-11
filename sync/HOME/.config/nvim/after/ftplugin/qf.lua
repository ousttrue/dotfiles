-- vim.cmd "Cfilter / error:/"
vim.keymap.set("n", "<C-n>", ":cnewer<CR>", { buffer = 0, noremap = true })
vim.keymap.set("n", "<C-p>", ":colder<CR>", { buffer = 0, noremap = true })
vim.keymap.set("n", "p", "<CR>zz<C-w>p", { buffer = 0, noremap = true })

local qfu = require "qfu"

-- winbar
vim.api.nvim_win_set_option(0, "winbar", qfu.get_status())

vim.keymap.set("n", "R", function()
  vim.api.nvim_win_set_option(0, "winbar", qfu.get_status())
end, { buffer = 0 })
