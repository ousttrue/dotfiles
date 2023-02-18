-- local api = vim.api
local g = vim.g
local opt = vim.opt

-- avoid plugins
vim.api.nvim_set_var("did_install_default_menus", 1)
vim.api.nvim_set_var("did_install_syntax_menu", 1)
vim.api.nvim_set_var("did_indent_on", 1)
--vim.api.nvim_set_var('did_load_filetypes', 1)
--vim.api.nvim_set_var('did_load_ftplugin', 1)
vim.api.nvim_set_var("loaded_2html_plugin", 1)
vim.api.nvim_set_var("loaded_gzip", 1)
vim.api.nvim_set_var("loaded_man", 1)
-- vim.api.nvim_set_var("loaded_matchit", 1)
-- vim.api.nvim_set_var("loaded_matchparen", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)
vim.api.nvim_set_var("loaded_remote_plugins", 1)
vim.api.nvim_set_var("loaded_shada_plugin", 1)
vim.api.nvim_set_var("loaded_spellfile_plugin", 1)
vim.api.nvim_set_var("loaded_tarPlugin", 1)
vim.api.nvim_set_var("loaded_tutor_mode_plugin", 1)
vim.api.nvim_set_var("loaded_zipPlugin", 1)
vim.api.nvim_set_var("skip_loading_mswin", 1)

-- Remap leader and local leader to <Space>
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
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
opt.keywordprg = ":help"

-- opt.showmatch = true
-- opt.matchtime = 1
-- vim.cmd[[
-- set matchpairs+=<:>
-- ]]

vim.cmd [[
" " Highlight on yank
" augroup YankHighlight
"   autocmd!
"   autocmd TextYankPost * silent! lua vim.highlight.on_yank()
" augroup end

autocmd QuickfixCmdPost make,grep,grepadd,vimgrep cwindow
]]

opt.completeopt = "menuone,noinsert"
vim.keymap.set("i", "<C-j>", "<C-x><C-o>")
-- vim.cmd[[
-- inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
-- inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-x><C-o>"
-- inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
-- ]]

vim.keymap.set("n", "<S-F>", "<C-i>", { noremap = true })
vim.keymap.set("n", "<S-B>", "<C-o>", { noremap = true })
vim.keymap.set("n", "<C-.>", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<C-,>", ":bprev<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-l>", ":bnext<CR>", { noremap = true })initl
-- vim.keymap.set("n", "<C-h>", ":bprev<CR>", { noremap = true })
-- vim.keymap.set("n", "<Leader>c", "<C-l>", { noremap = true })
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR><C-l>", {})
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })

vim.keymap.set("n", "<Leader>q", "q", { noremap = true })
vim.keymap.set("n", "q", ":close<CR>", { noremap = true })
vim.keymap.set("n", "[b", ":bp<CR>", { noremap = true })
vim.keymap.set("n", "]b", ":bn<CR>", { noremap = true })
vim.keymap.set("n", "[c", ":cp<CR>", { noremap = true })
vim.keymap.set("n", "]c", ":cn<CR>", { noremap = true })
vim.keymap.set("n", "<S-Tab>", ":cp<CR>", { noremap = true })
vim.keymap.set("n", "<Tab>", ":cn<CR>", { noremap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("n", "<C-S-B>", ":make<CR>", { noremap = true })

-- lsp
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { noremap = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { noremap = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true })
vim.keymap.set("n", "<f12>", vim.lsp.buf.references, { noremap = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true })
vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { noremap = true })
vim.keymap.set("n", "gn", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set("n", "ge", vim.diagnostic.open_float, { noremap = true })
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { noremap = true })
vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { noremap = true })
vim.keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
-- vim.keymap.set("n", "<space>e", vim.diagnostic.show_line_diagnostics, { noremap = true })
-- vim.keymap.set("n", "<space>q", vim.diagnostic.set_loclist, { noremap = true })

-- LSP handlers
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
--   { virtual_text = true }
-- )

-- package manager
require "lazy-plugins"
-- vim.cmd [[colorscheme habamax]]
