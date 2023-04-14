-- local api = vim.api
local g = vim.g
local opt = vim.opt
local dot = require "dot"

if vim.fn.has "win32" == 1 then
  vim.keymap.set("n", "<C-z>", "<Nop>")
else
  vim.cmd [[set clipboard+=unnamedplus]]
end

-- vim.cmd [[
-- if system('uname -a | grep microsoft') != ''
--   augroup myYank
--     autocmd!
--     autocmd TextYankPost * :call system('/mnt/c/Windows/System32/clip.exe', @")
--   augroup END
-- endif"
-- ]]
-- vim.keymap.set("n", "P", "O<ESC>P<CR>")

-- Remap leader and local leader to <Space>
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "
-- disable netrw's gx mapping.
g.netrw_nogx = true

vim.cmd [[execute "set colorcolumn=" . join(range(81, 9999), ',')]]
opt.cursorline = true
-- opt.autowrite = true
opt.completeopt = "menu,preview"
opt.ambiwidth = "single"
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

vim.keymap.set({ "n", "i" }, "<F7>", function()
  -- vim.cmd "make!"
  -- vim.cmd "wa"
  vim.cmd "stopinsert"
  local qfu = require "qfu"
  qfu.async_make()
end)

vim.keymap.set("n", "<F8>", function()
  vim.cmd "copen"
  local qfu = require "qfu"
  qfu.Qf_filter()
end)
vim.keymap.set("n", "<C-k>", "<Tab>", { noremap = true })
vim.keymap.set("n", "<Tab>", function()
  local items = vim.fn.getqflist()
  if #items > 1 then
    vim.cmd "cn"
  else
    vim.cmd "cc"
  end
end)
vim.keymap.set("n", "<S-Tab>", "<cmd>cp<CR>", {})
vim.keymap.set("n", "<C-n>", ":cnewer<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", ":colder<CR>", { noremap = true, silent = true })

vim.cmd [[
" " Highlight on yank
" augroup YankHighlight
"   autocmd!
"   autocmd TextYankPost * silent! lua vim.highlight.on_yank()
" augroup end

" autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
" autocmd QuickfixCmdPost make,grep,grepadd,vimgrep tab cwindow
]]

vim.keymap.set({ "i", "c" }, "<C-e>", "<END>")
vim.keymap.set({ "i", "c" }, "<C-a>", "<HOME>")
vim.cmd "packadd cfilter"

-- opt.completeopt = "menuone,noinsert"
vim.keymap.set("i", "<C-j>", "<C-x><C-o>")
-- vim.cmd[[
-- inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
-- inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-x><C-o>"
-- inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
-- ]]

-- vim.keymap.set("n", "<S-F>", "<C-i>", { noremap = true })
-- vim.keymap.set("n", "<S-B>", "<C-o>", { noremap = true })
-- vim.keymap.set("n", "<C-l>", ":bnext<CR>", { noremap = true })initl
-- vim.keymap.set("n", "<C-h>", ":bprev<CR>", { noremap = true })
-- vim.keymap.set("n", "<Leader>c", "<C-l>", { noremap = true })
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR><C-l>", {})
local function write_buffer()
  if vim.startswith(vim.fn.mode(), "i") then
    vim.cmd "stopinsert"
  end
  -- vim.lsp.buf.format { async = false }
  vim.api.nvim_command "write"
end
vim.keymap.set("n", "<C-s>", write_buffer, { noremap = true })
vim.keymap.set("i", "<C-s>", write_buffer, { noremap = true })

local function should_close(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  for i, t in ipairs { "fugitive", "help" } do
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
  local currentBufNum = vim.fn.bufnr "%"
  if should_close(currentBufNum) then
    vim.cmd "close"
  else
    -- buffer 切り替え｀
    vim.cmd "BufferLineCycleNext"
    local newBufNum = vim.fn.bufnr "%"
    if newBufNum == currentBufNum then
      vim.cmd "enew"
    end
    -- 非表示になった buffer を削除
    vim.cmd("silent bwipeout " .. currentBufNum)
    --   bwipeoutに失敗した場合はウインドウ上のバッファを復元
    if vim.fn.bufloaded(currentBufNum) ~= 0 then
      vim.cmd("buffer " .. currentBufNum)
    end
  end
end
vim.keymap.set("n", "<C-q>", close_buffer_or_window, { noremap = true })
vim.keymap.set("n", "Q", close_buffer_or_window, { noremap = true })
vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true })

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
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = dot.border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = dot.border,
})

vim.diagnostic.config {
  float = { border = dot.border },
}
local diag_signs = vim.diagnostic.handlers.signs

local filter_types = {
  "optional",
  "string_view",
  "filesystem",
  "u8string",
  "span",
  "string_view",
  -- c++23
  "expected",
}
local filter_template = {
  "No template named '%s' in namespace 'std'",
  "No type named '%s' in namespace 'std'",
  "No member named '%s' in namespace 'std'",
  "Decomposition declarations are a C++17 extension",
}
local prefix_list = {
  "In included file: ",
}
local function starts_with(str, key)
  return string.sub(str, 1, #key) == key
end
local function is_filter(msg)
  for _, t in ipairs(filter_types) do
    for _, template in ipairs(filter_template) do
      if starts_with(msg, string.format(template, t)) then
        return true
      end
      for _, p in ipairs(prefix_list) do
        if starts_with(msg, string.format(p .. template, t)) then
          return true
        end
      end
    end
  end
end

if vim.fn.has "win32" == 1 then
  vim.diagnostic.handlers.signs = {

    show = function(namespace, bufnr, diagnostics, opts)
      -- print(vim.inspect(diagnostics))
      local filtered = {}
      for _, d in ipairs(diagnostics) do
        if is_filter(d.message) then
          print "skip"
        else
          -- print(vim.inspect(d))
          table.insert(filtered, d)
        end
      end
      diag_signs.show(namespace, bufnr, filtered, opts)
    end,

    hide = diag_signs.hide,
  }
end

--
--   virtual_text = {
--     prefix = "",
--     spacing = 0,
--   },
--   signs = true,
--   underline = true,
-- })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("n", "F", vim.lsp.buf.format, { noremap = true })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { noremap = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true })
vim.keymap.set("n", "<f12>", vim.lsp.buf.references, { noremap = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
-- vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true })
vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, { noremap = true })
vim.keymap.set("n", "gn", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set("n", "ge", vim.diagnostic.open_float, { noremap = true })
-- vim.keymap.set("n", "<Leader>e", vim.diagnostic.show_line_diagnostics, { noremap = true })
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { noremap = true })
vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, { noremap = true })
vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, { noremap = true })
vim.keymap.set("n", "<Leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)
-- C-[: ESC
-- C-O: back
-- TAB->C-K: forward
vim.keymap.set("n", "<C-]>", "<cmd>tjump<CR>")
-- vim.keymap.set("n", "<space>q", vim.diagnostic.set_loclist, { noremap = true })

-- LSP handlers
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
--   { virtual_text = true }
-- )

local function floating_window()
  local buf = vim.api.nvim_create_buf(false, true)

  for i, client in ipairs(vim.lsp.get_active_clients()) do
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, vim.split(vim.inspect(client.server_capabilities), "\n"))
    -- print(vim.split(vim.inspect(client.server_capabilities), '\n'))
  end

  local win = vim.api.nvim_open_win(buf, 0, {
    relative = "win",
    width = 50,
    height = 20,
    col = 0,
    row = 1,
    anchor = "NW",
    border = dot.border,
  })
end
vim.keymap.set("n", "gx", floating_window, { noremap = true })

-- package manager
require "lazy-plugins"
