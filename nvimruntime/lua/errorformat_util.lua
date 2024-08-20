local M = {
  meson = function()
    -- qf
    if vim.fn.has "win32" == 1 then
      -- vim.opt.makeprg = "meson install -C builddir"
    else
      vim.opt.shellpipe = "2>&1| tee"
    end

    vim.opt.errorformat = vim.fn.join({
      "%Dninja: Entering directory `%f'",
      -- clang
      "%f:%l:%c: %t%*[^:]: %m",
      "%f:%l:%c: fatal %t%*[^:]: %m",
      -- gcc
      "%f|%l col %c %t%*[^|]| %m",
      -- msvc
      "%f(%l): %t%*[^ ] C%n: %m",
      "%f(%l): fatal %t%*[^ ] C%n: %m",
    }, ",")
  end,
}
return M
