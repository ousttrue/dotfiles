local M = {}
function M.setup()
    local lspconfig = require "lspconfig"

    lspconfig.sumneko_lua.setup {
        settings = {
            Lua = {
                diagnostics = {
                    enable = true,
                    globals = { "vim" },
                },
            },
        },
    }
end
return M
