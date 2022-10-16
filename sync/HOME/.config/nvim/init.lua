local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
-- opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.laststatus = 3
opt.winbar = "%f"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.list = true
opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<"
opt.belloff = "all"
opt.swapfile = false
opt.undofile = false
opt.backup = false
opt.hlsearch = true
opt.hidden = true
opt.modeline = true

-- Highlight on yank
vim.cmd [[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]]

vim.keymap.set("n", "q", ":close<CR>", { noremap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.keymap.set("n", "<S-f>", vim.lsp.buf.format, { noremap = true })
vim.keymap.set("v", "<S-f>", vim.lsp.buf.format, { noremap = true })

 
-- packer
require("plugins").setup()
