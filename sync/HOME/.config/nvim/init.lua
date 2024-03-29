local DOT = require "dot"

local function init_nvim()
  -- vim.cmd [[syntax off]]
  local g = vim.g
  local opt = vim.opt
  ---@class uv
  local uv = vim.loop

  if vim.fn.has "win32" == 1 then
    vim.keymap.set("n", "<C-z>", "<Nop>")
    vim.g.sqlite_clib_path = "D:/msys64/mingw64/bin/libsqlite3-0.dll"
  end

  -- disable netrw's gx mapping.
  g.netrw_nogx = true

  vim.keymap.set({ "i", "c" }, "<S-Insert>", "<C-R>+", { noremap = true })
  vim.keymap.set({ "n" }, "<S-Insert>", "p", { noremap = true })

  -- vim.cmd [[execute "set colorcolumn=" . join(range(81, 9999), ',')]]
  -- opt.cursorline = true
  -- opt.autowrite = true
  opt.guicursor = ""
  opt.showtabline = 3
  opt.startofline = false
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
  -- opt.winbar = "%f"
  opt.fileformats = "unix"

  opt.tabstop = 2
  opt.softtabstop = 2
  opt.shiftwidth = 2
  opt.expandtab = true
  opt.list = true
  opt.listchars = {
    eol = "$",
    tab = ">-",
    trail = "~",
    extends = ">",
    precedes = "<",
    conceal = "_",
  }
  opt.concealcursor = "nvic"
  -- opt.conceallevel = 2
  opt.belloff = "all"
  opt.swapfile = false
  opt.undofile = false
  opt.backup = false
  opt.hlsearch = true
  opt.hidden = true
  opt.modeline = true
  opt.keywordprg = ":help"
  opt.makeprg = "meson install -C builddir --tags runtime"

  -- opt.showmatch = true
  -- opt.matchtime = 1
  -- vim.cmd[[
  -- set matchpairs+=<:>
  -- ]]

  -- vim.keymap.set({ "n", "i" }, "<F7>", function()
  --   -- vim.cmd "make!"
  --   -- vim.cmd "wa"
  --   vim.cmd "stopinsert"
  --   local qfu = require "qfu"
  --   qfu.async_make()
  -- end)
  vim.keymap.set({ "n" }, "<F7>", ":make<CR>")
  vim.keymap.set({ "i" }, "<F7>", "<c-o>:make<CR><ESC>")

  if DOT.get_system() == "windows" then
    local qfu = require "qfu"
    vim.opt.errorformat = qfu.ninja_vc_fmt
  end

  vim.keymap.set("n", "<F8>", function()
    vim.cmd "bel copen"
    local qfu = require "qfu"
    qfu.Qf_filter()
  end)
  -- vim.keymap.set("n", "<C-k>", "<Tab>", { noremap = true })
  -- vim.keymap.set("n", "<Tab>", function()
  --   local items = vim.fn.getqflist()
  --   if #items > 1 then
  --     vim.cmd "cn"
  --   elseif #items == 1 then
  --     vim.cmd "cc"
  --   end
  -- end)
  vim.keymap.set("n", "<Tab>", ":cnext<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "<S-Tab>", ":cprev<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "]q", ":cnewer<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "[q", ":colder<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "F", "<C-i>", { noremap = true, silent = true })
  vim.keymap.set("n", "B", "<C-o>", { noremap = true, silent = true })

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
      -- vim.cmd "BufferLineCycleNext"
      vim.cmd "BufferNext"
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
  vim.keymap.set("n", "<C-d>", ":qa<CR>", { noremap = true })
  vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true })

  -- vim.keymap.set("n", "]b", ":bn<CR>", { noremap = true })
  -- vim.keymap.set("n", "[b", ":bp<CR>", { noremap = true })
  -- vim.keymap.set("n", "]c", ":cn<CR>", { noremap = true })
  -- vim.keymap.set("n", "[c", ":cp<CR>", { noremap = true })
  -- vim.keymap.set("n", "]l", ":ln<CR>", { noremap = true })
  -- vim.keymap.set("n", "[l", ":lp<CR>", { noremap = true })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true })
  -- vim.keymap.set("n", "<Tab>", vim.diagnostic.goto_next, { noremap = true })
  -- vim.keymap.set("n", "<S-Tab>", vim.diagnostic.goto_prev, { noremap = true })

  -- terminal
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

  -- lsp
  -- vim.lsp.set_log_level "off"
  vim.diagnostic.config {
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.HINT] = "󰌵 ",
      },
    },
  }
  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵 ", texthl = "DiagnosticSignHint" })

  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {

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
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, { noremap = true })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { noremap = true })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true })
  vim.keymap.set("n", "<f12>", vim.lsp.buf.references, { noremap = true })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })

  vim.keymap.set("n", "<M-h>", "<C-w>h", { noremap = true })
  vim.keymap.set("n", "<M-j>", "<C-w>j", { noremap = true })
  vim.keymap.set("n", "<M-k>", "<C-w>k", { noremap = true })
  vim.keymap.set("n", "<M-l>", "<C-w>l", { noremap = true })

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
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
  -- opts.on_attach = function(_, bufnr)
  --   local bufopts = { silent = true, buffer = bufnr }
  --   vim.keymap.set("n", "<space>p", vim.lsp.buf.format, bufopts)
  -- end

  -- C-[: ESC
  -- C-O: back
  -- TAB->C-K: forward
  -- vim.keymap.set("n", "<C-]>", "<cmd>tjump<CR>")
  -- vim.keymap.set("n", "<space>q", vim.diagnostic.set_loclist, { noremap = true })

  -- LSP handlers
  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --   vim.lsp.diagnostic.on_publish_diagnostics,
  --   { virtual_text = true }
  -- )
  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  --   update_in_insert = false,
  --   virtual_text = {
  --     format = function(diagnostic)
  --       return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
  --     end,
  --   },
  -- })

  vim.api.nvim_set_keymap("n", "gh", ":Inspect<CR>", {})
  vim.cmd [[command! VimSyntaxTest :source $VIMRUNTIME/syntax/hitest.vim]]
  vim.cmd [[command! ReloadHl :lua require('dot').reload_hl()]]
  vim.cmd [[command! CrLfToLf :%s/\r$//]]

  local function ff()
    local formatter = DOT.formatters[vim.bo.filetype]
    if formatter then
      formatter()
    else
      vim.lsp.buf.format { timeout_ms = 2000 }
    end
  end
  vim.keymap.set("n", "ff", ff, { noremap = true })

  require("keymap").setup()

  --
  -- package manager
  --
  if vim.env.MSYSTEM then
    require "packer_setup"
  elseif vim.g.vscode then
    -- VSCode extension
    print "vscode"
  else
    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      }
    end
    vim.opt.rtp:prepend(lazypath)

    -- require("lazy").setup "lazy.plugins"
    local opts = {
      change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
      },
    }
    local plugins = {}
    table.insert(plugins, { import = "lazy.0_minimum" })
    table.insert(plugins, { import = "lazy.1_treesitter" })
    table.insert(plugins, { import = "lazy.2_lsp" })
    table.insert(plugins, { import = "lazy.extend" })
    table.insert(plugins, { import = "lazy.filer" })
    table.insert(plugins, { import = "lazy.telescope" })
    table.insert(plugins, { import = "lazy.9_denops" })
    table.insert(plugins, { import = "lazy.git" })
    table.insert(plugins, { import = "lazy.cmp" })
    table.insert(plugins, { import = "lazy.colorschemes" })
    require("lazy").setup(plugins, opts)
  end
end

--
-- functions
--

local function get_platform()
  if vim.g.vscode then
    -- [x] @2023 [VSCode VimからVSCode Neovimに移行した](https://zenn.dev/yubrot/articles/1bf4b8d79d7cae)
    return "vscode"
  elseif vim.g.gonvim_running then
    return "gonvim"
  elseif vim.g.nvy then
    return "nvy"
  elseif vim.g.neovide then
    return "neovide"
  elseif vim.fn.has "wsl" == 1 then
    return "wsl"
  elseif vim.fn.has "mac" == 1 then
    return "osx"
  else
    return "nvim"
  end
end

local function init_vscode()
  local vscode = require "vscode-neovim"

  vim.keymap.set("n", "<leader> ", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
  -- vim.keymap.set("n", "<leader>d", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>")
  vim.keymap.set("n", "(", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
  vim.keymap.set("n", ")", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")

  vim.notify = vscode.notify
end

local function init_buffer_local()
  vim.keymap.set("n", "t", "zt", { noremap = true, silent = true })
end

local function init_wsl_clipboard()
  if vim.fn.executable "win32yank.exe" == 1 then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --crlf",
        ["*"] = "win32yank.exe -o --crlf",
      },
      cache_enable = 0,
    }
  end
end

local function init_osx_clipboard() end

--
-- main
--

local SYNTAX_UTIL = require "syntax_util"

vim.api.nvim_create_autocmd("colorscheme", {
  callback = function(ev)
    SYNTAX_UTIL.clear_syntax_link(ev)
  end,
})

-- Remap leader and local leader to <Space>
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local platform = get_platform()
init_buffer_local()

if platform == "vscode" then
  init_vscode()
else
  -- clipboard
  vim.opt.clipboard = "unnamedplus"
  if platform == "wsl" then
    init_wsl_clipboard()
  elseif platform == "osx" then
    init_osx_clipboard()
  end

  init_nvim()

  local cs = { "dark", "habamax" }
  if platform == "nvy" then
    vim.o.guifont = "HackGen Console NF:h13"
    if vim.endswith(vim.fn.getcwd(), "my_nvim") then
      cs = { "light", "fuga_everforest" }
    else
      cs = { "dark", "duskfox" }
    end
  elseif platform == "nvim" then
    -- cs = { "dark", "fuga" }
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = DOT.border,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = DOT.border,
    })
    vim.diagnostic.config {
      float = {
        border = DOT.border,
      },
    }
    local function floating_window()
      local buf = vim.api.nvim_create_buf(false, true)

      for i, client in ipairs(vim.lsp.get_active_clients()) do
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, vim.split(vim.inspect(client.server_capabilities), "\n"))
        -- print(vim.split(vim.inspect(client.server_capabilities), '\n'))
      end

      -- local win = vim.api.nvim_open_win(buf, 0, {
      --   relative = "win",
      --   width = 50,
      --   height = 20,
      --   col = 0,
      --   row = 1,
      --   anchor = "NW",
      --   border = DOT.border,
      -- })
      -- vim.keymap.set("n", "gx", floating_window, { noremap = true })
    end
  end
  vim.o.bg = cs[1]
  vim.cmd("colorschem " .. cs[2])

  --   vim.cmd [[
  -- augroup HLExtend
  --   autocmd!
  --   autocmd ColorScheme * lua require('dot').extend_hl()
  --   autocmd ColorScheme * lua require('dot').extend_hl_ts()
  -- augroup END
  -- ]]
  --
  --   local cs, bg = DOT.get_colorscheme()
  --   -- print(cs, bg)
  --   vim.o.background = bg
  --   vim.cmd(string.format("colorscheme %s", cs))
  --
  --   if vim.g.gonvim_running then
  --     --
  --     vim.cmd [[
  -- colorschem carbonfox
  --   ]]
  --
  --   vim.g.neovide_cursor_animation_length = 0

  -- for debug
  vim.cmd [[command! VimSourceHighlightTest :source $VIMRUNTIME/syntax/hitest.vim]]
  vim.cmd [[command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')]]
  vim.api.nvim_set_keymap("n", "gh", ":Inspect<CR>", {})
  -- vim.keymap.set("n", "gh", function()
  --   local result = vim.treesitter.get_captures_at_cursor(0)
  --   print(vim.inspect(result))
  -- end, { noremap = true, silent = false })
end
