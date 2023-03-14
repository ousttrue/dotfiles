local M = {}
function M.setup()
  local dot = require "dot"
  local lspconfig = require "lspconfig"
  local util = require "lspconfig.util"
  local lsp_status = require "lsp-status"

  require("lspconfig.ui.windows").default_options.border = dot.border

  lsp_status.register_progress()

  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    lsp_status.on_attach(client)
  end

  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  for k, v in pairs(lsp_status.capabilities) do
    capabilities[k] = v
  end
  -- print(vim.inspect(capabilities))

  require("lspconfig.lua_ls").setup(lspconfig, capabilities, on_attach)
  require("lspconfig.clangd").setup(lspconfig, capabilities, on_attach)
  require("lspconfig.omnisharp").setup(lspconfig, capabilities, on_attach)

  lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.pyright.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }

  lspconfig.zls.setup {
    -- cmd = { vim.env.YAZLS_EXE },
    cmd = { dot.get_home() .. "/.vscode-server/data/User/globalStorage/ziglang.vscode-zig/zls_install/zls" },
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.zk.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.groovyls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.jsonls.setup {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  }

  lspconfig.tsserver.setup {}
end

return M
