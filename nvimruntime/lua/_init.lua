-- https://neovim.io/doc/user/lua.html

local g_print = print
local function debug_print(...)
  local caller = debug.getinfo(2)
  g_print(("%s:%d"):format(caller.source, caller.currentline), ...)
end

-- debug
-- print = debug_print

vim.g.editorconfig = false
vim.cmd [[
let g:zig_recommended_style = 0

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
]]

-- Remap leader and local leader to <Space>
vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })

vim.g.maplocalleader = " "
if vim.fn.has "win32" == 1 then
  vim.keymap.set("n", "<C-z>", "<Nop>")
end

function GET_SYSTEM()
  if vim.fn.has "wsl" ~= 0 then
    return "wsl"
  elseif vim.fn.has "win64" ~= 0 then
    if vim.env.MSYSTEM then
      vim.opt.shellcmdflag = "-c"
      return string.lower(vim.env.MSYSTEM)
    else
      return "windows"
    end
  elseif vim.fn.has "mac" ~= 0 then
    return "mac"
  elseif vim.fn.has "linux" ~= 0 then
    return "linux"
  end
end

function PATH_EXISTS(path)
  if vim.uv.fs_stat(path) then
    return true
  end
end

local function setup()
  require("option").setup()
  require("keymap").setup()
  require("quick_fix").setup()
  require("clipboard").setup()
  require("lazy_plugins").setup()
  require("color").setup()
  require("lsp").setup()
  require("completion").setup()
  require("diagnostics").setup()
  require("markdown").setup()
  require "inspector"
  require("hoversplit").setup()
  --
  require("tools.myplugin").setup()
  -- require("tools.indicator").setup()
  -- require("tools.skk").setup()
  require("tools.loghighlighter").setup()

  if vim.fn.has "win64" ~= 0 then
    require("windows_terminal").setup()
  end

  require("bufread").setup()

  vim.api.nvim_create_user_command("Here", ":!start %:p:h", {})

  vim.filetype.add {
    pattern = {
      [".*/pkgconfig/.*%.pc"] = "pkg-config",
    },
  }

  --python
  local function auto_activate_venv()
    local venv_path = vim.fn.getcwd() .. "/.venv"
    if vim.fn.isdirectory(venv_path) == 1 then
      vim.env.VIRTUAL_ENV = venv_path
      vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
    end
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      auto_activate_venv()
    end,
  })
end

return {
  setup = setup,
}
