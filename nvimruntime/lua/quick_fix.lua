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

local M = {
  setup = function()
    vim.opt.makeprg = "meson install -C builddir --tags runtime"

--     vim.cmd [[
-- autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
-- ]]

    -- if DOT.get_system() == "windows" then
    --   local qfu = require "qfu"
    -- end
    vim.opt.errorformat = ninja_vc_fmt
  end,
}

return M
