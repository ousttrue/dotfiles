local M = {}
function M.setup()
  local mason_lspconfig = require "mason-lspconfig"

  mason_lspconfig.setup {
    ensure_installed = { "sumneko_lua", "clangd", "pyright", "cmake", "zls" },
  }
end

return M
