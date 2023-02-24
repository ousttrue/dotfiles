local M = {}

local util = require "lspconfig.util"

local function get_clangd()
  if vim.fn.has "win32" == 1 then
    return "C:/Program Files/LLVM/bin/clangd.exe"
  else
    return "clangd"
  end
end

---@param lspconfig any
---@param capabilities any
---@param on_init any
---@param on_attach any
function M.setup(lspconfig, capabilities, on_init, on_attach)
  lspconfig.clangd.setup {
    cmd = {
      get_clangd(),
      "--compile-commands-dir=builddir",
      "--header-insertion=never",
    },
    -- handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
    },
    root_dir = util.root_pattern("build/compile_commands.json", ".git"),
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
