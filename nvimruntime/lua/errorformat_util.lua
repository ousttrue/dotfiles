local M = {
  meson = function()
    -- print "errorformat_util.meson()"
    -- ninja: Entering directory `/grapho/build'
    -- ../subprojects/glew-2.2.0/include/GL/glew.h:224:14: fatal error: 'cstddef' file not found

    vim.opt.errorformat = vim.fn.join({
      "%Dninja: Entering directory `%f'",
      -- clang
      "%f:%l:%c: %t%*[^:]: %m",
      "%f:%l:%c: fatal %t%*[^:]: %m",
      -- gcc
      "%f|%l col %c %t%*[^|]| %m",
    }, ",")
  end,
}
return M
