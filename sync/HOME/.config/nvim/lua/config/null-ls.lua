local M = {}

function M.setup()
  require("null-ls").setup {
    sources = {
      require("null-ls").builtins.formatting.stylua,
    },
  }
end

return M
