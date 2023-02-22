-- local api = vim.api
local g = vim.g
local opt = vim.opt
local dot_util = require('dot_util')
vim.api.nvim_set_var('python3_host_prog',
  dot_util.get_home() .. '/.local/venv/nvim/Scripts/python' .. dot_util.get_suffix())

-- -- avoid plugins
-- vim.api.nvim_set_var("did_install_default_menus", 1)
-- vim.api.nvim_set_var("did_install_syntax_menu", 1)
-- vim.api.nvim_set_var("did_indent_on", 1)
-- --vim.api.nvim_set_var('did_load_filetypes', 1)
-- --vim.api.nvim_set_var('did_load_ftplugin', 1)
-- vim.api.nvim_set_var("loaded_2html_plugin", 1)
-- vim.api.nvim_set_var("loaded_gzip", 1)
-- vim.api.nvim_set_var("loaded_man", 1)
-- -- vim.api.nvim_set_var("loaded_matchit", 1)
-- -- vim.api.nvim_set_var("loaded_matchparen", 1)
-- vim.api.nvim_set_var("loaded_netrwPlugin", 1)
-- -- vim.api.nvim_set_var("loaded_remote_plugins", 1)
-- vim.api.nvim_set_var("loaded_shada_plugin", 1)
-- vim.api.nvim_set_var("loaded_spellfile_plugin", 1)
-- vim.api.nvim_set_var("loaded_tarPlugin", 1)
-- vim.api.nvim_set_var("loaded_tutor_mode_plugin", 1)
-- vim.api.nvim_set_var("loaded_zipPlugin", 1)
-- vim.api.nvim_set_var("skip_loading_mswin", 1)

-- Remap leader and local leader to <Space>
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.ambiwidth = 'single'
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
opt.listchars = {
  eol = "$",
  tab = ">-",
  trail = "~",
  extends = ">",
  precedes = "<",
}
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

-- opt.completeopt = "menuone,noinsert"
vim.keymap.set("i", "<C-j>", "<C-x><C-o>")
-- vim.cmd[[
-- inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
-- inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-x><C-o>"
-- inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
-- ]]

-- vim.keymap.set("n", "<S-F>", "<C-i>", { noremap = true })
-- vim.keymap.set("n", "<S-B>", "<C-o>", { noremap = true })
vim.keymap.set("n", ")", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "(", ":bprev<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-l>", ":bnext<CR>", { noremap = true })initl
-- vim.keymap.set("n", "<C-h>", ":bprev<CR>", { noremap = true })
-- vim.keymap.set("n", "<Leader>c", "<C-l>", { noremap = true })
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR><C-l>", {})
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })

local function should_close(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  for i, t in ipairs({ 'fugitive', 'help' }) do
    if filetype == t then
      return true
    end
  end
  if vim.api.nvim_win_get_config(0).zindex then
    return true
  end
  if vim.fn.buflisted(bufnr) then
    return false
  end
  return true
end

local function close_buffer_or_window()
  local currentBufNum = vim.fn.bufnr("%")
  -- local alternateBufNum = vim.fn.bufnr("#")
  if should_close(currentBufNum) then
    vim.cmd('close')
  else
    -- buffer 切り替え｀
    -- if vim.fn.buflisted(alternateBufNum) then
    --   vim.cmd('buffer #')
    -- else
    vim.cmd('bnext')
    -- end
    -- 非表示になった buffer を削除
    vim.cmd("silent bwipeout " .. currentBufNum)
    --   bwipeoutに失敗した場合はウインドウ上のバッファを復元
    if vim.fn.bufloaded(currentBufNum) ~= 0 then
      vim.cmd("buffer " .. currentBufNum)
    end
  end
end
vim.keymap.set("n", "<Leader>q", "q", { noremap = true })
vim.keymap.set("n", "q", close_buffer_or_window, { noremap = true })

vim.keymap.set("n", "]b", ":bn<CR>", { noremap = true })
vim.keymap.set("n", "[b", ":bp<CR>", { noremap = true })
vim.keymap.set("n", "]c", ":cn<CR>", { noremap = true })
vim.keymap.set("n", "[c", ":cp<CR>", { noremap = true })
vim.keymap.set("n", "]l", ":ln<CR>", { noremap = true })
vim.keymap.set("n", "[l", ":lp<CR>", { noremap = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true })
-- vim.keymap.set("n", "<Tab>", vim.diagnostic.goto_next, { noremap = true })
-- vim.keymap.set("n", "<S-Tab>", vim.diagnostic.goto_prev, { noremap = true })

-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- lsp
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config {
  virtual_text = false,
}
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
  border = dot_util.border
}
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
  border = dot_util.border
}
)

vim.diagnostic.config {
  float = { border = dot_util.border }
}

--
--   virtual_text = {
--     prefix = "",
--     spacing = 0,
--   },
--   signs = true,
--   underline = true,
-- })
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { noremap = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { noremap = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true })
vim.keymap.set("n", "<f12>", vim.lsp.buf.references, { noremap = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true })
vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, { noremap = true })
vim.keymap.set("n", "gn", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set("n", "ge", vim.diagnostic.open_float, { noremap = true })
vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, { noremap = true })
vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, { noremap = true })
vim.keymap.set("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
-- vim.keymap.set("n", "<Leader>e", vim.diagnostic.show_line_diagnostics, { noremap = true })
-- vim.keymap.set("n", "<space>q", vim.diagnostic.set_loclist, { noremap = true })

-- LSP handlers
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
--   { virtual_text = true }
-- )

local function floating_window()
  local buf = vim.api.nvim_create_buf(false, true)
  -- vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "test", "text" })
  local opts = {
    relative = 'cursor',
    width = 10,
    height = 2,
    col = 0,
    row = 1,
    anchor = 'NW',
    border = dot_util.border,
  }
  local win = vim.api.nvim_open_win(buf, 0, opts)
  --  " optional: change highlight, otherwise Pmenu is used
  -- vim.api.nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
end
vim.keymap.set("n", "gx", floating_window, { noremap = true })

-- package manager
require "lazy-plugins"
-- vim.cmd [[colorscheme habamax]]
