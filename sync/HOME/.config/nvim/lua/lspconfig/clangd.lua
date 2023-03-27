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
---@param on_attach any
function M.setup(lspconfig, capabilities, on_attach)
  lspconfig.clangd.setup {
    cmd = {
      get_clangd(),
      "--compile-commands-dir=builddir",
      "--header-insertion=never",
      -- "--clang-tidy",
      "--enable-config",
      -- '--query-driver="C:/Program Files/LLVM/bin/clang-cl.exe"',
    },
    -- handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
    },
    root_dir = util.root_pattern("builddir/compile_commands.json", "build/compile_commands.json", ".git"),
    on_attach = function(client, bufnr)
      vim.keymap.set("n", ",,", function()
        vim.cmd "ClangdSwitchSourceHeader"
      end, { noremap = true })
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }
end

return M
