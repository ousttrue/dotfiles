local M = {}

function M.setup()
    -- require("telescope").load_extension("ghq")

    local actions = require "telescope.actions"
    require("telescope").setup {
        defaults = { mappings = { i = {
            ["<c-[>"] = actions.close,
        } } },
    }

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<Leader><Space>", builtin.git_files, { noremap = true })
    vim.keymap.set("n", "<Leader>b", builtin.buffers, { noremap = true })
    vim.keymap.set("n", "<Leader>g", builtin.live_grep, { noremap = true })
    vim.keymap.set("n", "<Leader>h", builtin.help_tags, { noremap = true })
    -- vim.keymap.set("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
end

return M
