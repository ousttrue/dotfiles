-- local M = {
--   meson = function()
--     -- qf
--     if vim.fn.has "win32" == 1 then
--       -- vim.opt.makeprg = "meson install -C builddir"
--     else
--       vim.opt.shellpipe = "2>&1| tee"
--     end
--
--     vim.opt.errorformat = vim.fn.join({
--       "%Dninja: Entering directory `%f'",
--       -- clang
--       "%f:%l:%c: %t%*[^:]: %m",
--       "%f:%l:%c: fatal %t%*[^:]: %m",
--       -- gcc
--       "%f|%l col %c %t%*[^|]| %m",
--       -- msvc
--       "%f(%l): %t%*[^ ] C%n: %m",
--       "%f(%l): fatal %t%*[^ ] C%n: %m",
--     }, ",")
--   end,
-- }
-- return M

local icon = {
  e = "%#DiagnosticError# %#Normal#",
  w = "%#DiagnosticWarn# %#Normal#",
  n = "%#DiagnosticInfo# %#Normal#",
}

local error_formats = {
  "%Dninja: Entering directory `%f'",
  "%Eld%.lld: %t[^:]: undefined symbol: %m%n",
  "%f:%l:%c: %t%*[^:]: %m",
  "%N>>> referenced by %s (%f:%l)Tn",
  "%N>>> %m,%f(%l): %t%*[^ ] C%n: %m",
  "%f(%l): fatal %t%*[^ ] C%n: %m",
  "%f(%l): %t%*[^ ] %m",
  "%*[^ ] : %t%*[^ ] LNK%n: %m",
}

local zig = "%f:%l:%c: %m,"

local ninja_vc_fmt = zig .. "%Dninja: Entering directory `%f',%f(%l): %t%*[^ ] %m,%f:%l:%c: %t%*[^:]: %m"

local gcc_fmt = zig .. "%f:%l:%c: %t%*[^:]: %m"

local function setup()
  -- vim.opt.makeprg = "meson install -C builddir --tags runtime"
  -- vim.opt.makeprg = "zig build 2>&1"
  if vim.fn.has "win32" == 1 then
    -- vim.opt.makeprg = "meson install -C builddir"
  else
    vim.opt.shellpipe = "2>&1| tee"
  end
  vim.opt.errorformat = vim.fn.join({
    "%t%*[^:]:%*[ \t]%*[^:]:%*[ \t]%f:%l:%c:%*[ \t]%m",
    "%f:%l:%c:%*[ \t]%m",
    -- meson. ninja + msvc
    "%Dninja: Entering directory `%f'",
    "%f(%l): %t%*[^ ] %m",
  }, ",")

  vim.cmd [[
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
    ]]

  -- if DOT.get_system() == "windows" then
  --   local qfu = require "qfu"
  -- end
  -- if GET_SYSTEM() == "windows" then
  --   vim.opt.errorformat = ninja_vc_fmt
  -- else
  --   vim.opt.errorformat = gcc_fmt
  -- end

  vim.cmd [[
autocmd QuickFixCmdPost *grep* copen
autocmd QuickFixCmdPost *make* copen
autocmd FileType qf wincmd J
      ]]
end

return {
  setup = setup,
}
