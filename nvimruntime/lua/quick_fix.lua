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

local ninja_vc_fmt = "%Dninja: Entering directory `%f',%f(%l): %t%*[^ ] %m,%f:%l:%c: %t%*[^:]: %m"

local gcc_fmt = "%f:%l:%c: %t%*[^:]: %m"

local M = {
  setup = function()
    -- vim.opt.makeprg = "meson install -C builddir --tags runtime"
    -- vim.opt.makeprg = "zig build 2>&1"

    --     vim.cmd [[
    -- autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
    -- ]]

    -- if DOT.get_system() == "windows" then
    --   local qfu = require "qfu"
    -- end
    if GET_SYSTEM() == "windows" then
      vim.opt.errorformat = ninja_vc_fmt
    else
      vim.opt.errorformat = gcc_fmt
    end

    vim.cmd [[
autocmd QuickFixCmdPost *grep* cwindow
autocmd QuickFixCmdPost *make* cwindow
autocmd FileType qf wincmd J
      ]]
  end,
}

return M
