local M = {}
function M.setup()
  local dot = require "dot"
  local lspconfig = require "lspconfig"
  local util = require "lspconfig.util"
  local lsp_status = require "lsp-status"
  -- local navic = require "nvim-navic"

  require("lspconfig.ui.windows").default_options.border = dot.border

  -- local aerial = require "aerial"
  -- local symbols_outline = require "symbols-outline"
  lsp_status.register_progress()

  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    -- print(vim.inspect(client.server_capabilities))
    lsp_status.on_attach(client)
    -- navic.attach(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set({ "n", "v" }, "F", vim.lsp.buf.format, { buffer = bufnr, noremap = true })
    end
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

  lspconfig.pyright.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }

  lspconfig.zls.setup {
    cmd = { vim.env.YAZLS_EXE },
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
end

return M
