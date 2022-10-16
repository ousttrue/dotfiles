local M = {}

function M.setup()
    require("aerial").setup()
    vim.keymap.set("n", "<Leader>a", ":AerialOpen<CR>", { noremap = true })
end

return M
