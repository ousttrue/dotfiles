local M = {}

function M.setup()
    -- vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
    vim.keymap.set("n", "<Leader>e", ":NvimTreeFindFileToggle<CR>", { noremap = true })
    require("nvim-tree").setup {
        view = {
            float = {
                enable = true,
                quit_on_focus_loss = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1,
                },
            },
        },
        renderer = {
            -- indent_width = 1,
            icons = {
                glyphs = {
                    git = {
                        unstaged = "",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "ﰂ",
                        deleted = "ﯰ",
                        ignored = "◌",
                    },
                },
            },
        },
    }
end

return M