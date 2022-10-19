local M = {}
function M.setup()
    local lspconfig = require "lspconfig"
    local lsp_status = require "lsp-status"
    local aerial = require "aerial"
    local symbols_outline = require "symbols-outline"
    lsp_status.register_progress()

    local function on_attach(client, bufnr)
        aerial.on_attach(client, bufnr)
        lsp_status.on_attach(client, bufnr)
        -- symbols_outline.open_outline()
    end

    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    for k, v in pairs(lsp_status.capabilities) do
        capabilities[k] = v
    end

    lspconfig.sumneko_lua.setup {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    enable = true,
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },

        on_attach = on_attach,
        capabilities = capabilities,
    }

    lspconfig.clangd.setup {
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
            clangdFileStatus = true,
        },
        on_attach = on_attach,
        capabilities = lsp_status.capabilities,
    }

    lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = lsp_status.capabilities,
    }

    lspconfig.zls.setup {
        cmd = { vim.env.YAZLS_EXE },
        on_attach = on_attach,
        capabilities = lsp_status.capabilities,
    }

    lspconfig.zk.setup {
        on_attach = on_attach,
        capabilities = lsp_status.capabilities,
    }
end

return M
