local DOT = require "dot"

local function fullpath(src)
  local expand = vim.fn.fnamemodify(src, ":p")
  if vim.startswith(expand, "c:") then
    expand = "C:" .. expand:sub(3)
  end
  return expand
end

local function init_nvim()
  vim.cmd [[syntax on]]
  if vim.fn.has "win32" == 1 then
    vim.g.sqlite_clib_path = "D:/msys64/mingw64/bin/libsqlite3-0.dll"
  end

  -- Create an event handler for the FileType autocommand
  vim.api.nvim_create_autocmd("FileType", {
    -- This handler will fire when the buffer's 'filetype' is "python"
    pattern = "markdown",
    callback = function(ev)
      local OBS_DIR = string.gsub(DOT.get_dotdir() .. "\\docs\\obsidian", "/", "\\")
      if vim.startswith(fullpath(ev.file), OBS_DIR) then
        -- print "obsidian !"
        vim.lsp.start {
          name = "obsidian-lsp",
          cmd = { "py", "lsp.py" },
          -- Set the "root directory" to the parent directory of the file in the
          -- current buffer (`ev.buf`) that contains either a "setup.py" or a
          -- "pyproject.toml" file. Files that share a root directory will reuse
          -- the connection to the same LSP server.
          root_dir = vim.fs.root(ev.buf, { "lsp.py" }),
        }
      else
        -- print(OBS_DIR, fullpath(ev.file))
      end
    end,
  })

  vim.g.netrw_nogx = true -- disable netrw's gx mapping.

  vim.opt.guicursor = ""
  vim.opt.startofline = false
  vim.opt.completeopt = "menu,preview"
  vim.opt.ambiwidth = "single"
  vim.opt.termguicolors = true -- Enable colors in terminal
  vim.opt.hlsearch = true --Set highlight on search
  -- vim.opt.relativenumber = true --Make relative number default
  vim.opt.mouse = "a" --Enable mouse mode
  vim.opt.smartindent = false
  vim.opt.autoindent = false
  vim.opt.cindent = false
  vim.opt.breakindent = true --Enable break indent
  vim.opt.ignorecase = true --Case insensitive searching unless /C or capital in search
  vim.opt.smartcase = true -- Smart case
  vim.opt.updatetime = 250 --Decrease update time

  vim.opt.concealcursor = "nvic"
  --vim.opt.conceallevel = 2
  vim.opt.belloff = "all"
  vim.opt.swapfile = false
  vim.opt.undofile = false
  vim.opt.backup = false
  vim.opt.hlsearch = true
  vim.opt.hidden = true
  vim.opt.modeline = true
  vim.opt.keywordprg = ":help"
  vim.opt.makeprg = "meson install -C builddir --tags runtime"

  vim.opt.spelllang = "en_us"
  vim.opt.spell = true

  --vim.opt.showmatch = true
  --vim.opt.matchtime = 1
  -- vim.cmd[[
  -- set matchpairs+=<:>
  -- ]]

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

  vim.cmd "packadd cfilter"

  --vim.opt.completeopt = "menuone,noinsert"
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
    -- lazy.lua
  end

  function on_filetype(ev)
    -- print(string.format("event fired: %s", vim.inspect(ev)))
    local ft = ev.match
    local ts = require("nvim-treesitter.parsers").filetype_to_parsername[ft]
    if ts then
      -- print(ts)
      vim.opt_local.syntax = "off"
    else
      -- vim.opt_local.syntax = "ON"
      -- vim.cmd[[syntax on]]
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    callback = on_filetype,
  })
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

vim.cmd "TSEnable highlight"
