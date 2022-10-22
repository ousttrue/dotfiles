local M = {}

function M.setup()
  local null_ls = require "null-ls"
  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.yapf,
      null_ls.builtins.formatting.cmake_format,
    },
  }
end

return M
