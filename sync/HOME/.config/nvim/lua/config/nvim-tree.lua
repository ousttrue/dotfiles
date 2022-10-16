local M = {}

function M.setup()
    -- vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
    vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
    require("nvim-tree").setup {
        renderer = {
            indent_width = 1,
        },
    }
end

return M
