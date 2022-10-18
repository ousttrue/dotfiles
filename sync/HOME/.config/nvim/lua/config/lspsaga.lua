local M = {}

function M.setup()
    local saga = require "lspsaga"

    saga.init_lsp_saga {
        -- your configuration
    }

    local keymap = vim.keymap.set
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
end

return M
