-- https://neovim.io/doc/user/lua.html

-- debug
-- local g_print = print
-- print = function(...)
--   local caller = debug.getinfo(2)
--   g_print(("%s:%d"):format(caller.source, caller.currentline), ...)
-- end

vim.g.editorconfig = false
vim.cmd [[
let g:zig_recommended_style = 0
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
  if vim.loop.fs_stat(path) then
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
  -- require("completion").setup()
  require("diagnostics").setup()
  require("markdown").setup()
  require "inspector"
  --
  require("tools.myplugin").setup()
  -- require("tools.indicator").setup()
  -- require("tools.skk").setup()
  require("tools.loghighlighter").setup()

  if vim.fn.has "win64" ~= 0 then
    require("windows_terminal").setup()
  end

  vim.api.nvim_create_user_command("Here", ":!start %:p:h", {});
end

return {
  setup = setup,
}
