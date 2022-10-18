local M = {}

function M.setup()
    local bufdelete = require "bufdelete"
    local function d()
        bufdelete.bufdelete(0, true)
    end

    vim.keymap.set("n", "Q", d, { noremap = true })
end

return M
