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
    -- local frecency = require("telescope").extensions.frecency
    -- local function frecency_cwd()
    --     frecency.frecency { workspace = "CWD" }
    -- end
    local function git_files_untracked()
        builtin.git_files { show_untracked = true }
    end
    vim.keymap.set("n", "<Leader><Space>", git_files_untracked, { noremap = true })
    -- vim.keymap.set("n", "<Leader><Space>", frecency_cwd, { noremap = true })
    vim.keymap.set("n", "<Leader>b", builtin.buffers, { noremap = true })
    vim.keymap.set("n", "<Leader>g", builtin.live_grep, { noremap = true })
    vim.keymap.set("n", "<Leader>h", builtin.help_tags, { noremap = true })
    -- vim.keymap.set("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
end

return M
