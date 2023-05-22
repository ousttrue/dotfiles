local M = {}
function M.setup()
  local dot = require "dot"
  local lspconfig = require "lspconfig"
  local util = require "lspconfig.util"

  require("lspconfig.ui.windows").default_options.border = dot.border

  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr) end

  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
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

  local zls_path = ""
  if vim.fn.has "win32" == 1 then
    zls_path = vim.env.APPDATA .. "\\Code\\User\\globalStorage\\ziglang.vscode-zig\\zls_install\\zls.exe"
  elseif dot.is_wsl then
    zls_path = dot.get_home() .. "/.vscode-server/data/User/globalStorage/ziglang.vscode-zig/zls_install/zls"
  else
    zls_path = dot.get_home() .. "/.config/Code/User/globalStorage/ziglang.vscode-zig/zls_install/zls"
  end

  lspconfig.zls.setup {
    -- cmd = { vim.env.YAZLS_EXE },
    cmd = { zls_path },
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

  lspconfig.bashls.setup {}

  lspconfig.powershell_es.setup {
    bundle_path = dot.get_home() .. "/.vscode/extensions/ms-vscode.powershell-2023.3.3/modules",
  }

  -- lspconfig.glslls.setup {}
end

return M
