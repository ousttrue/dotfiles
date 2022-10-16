local M = {}

function M.setup()
    local sidebar = require "sidebar-nvim"
    sidebar.setup()
    vim.keymap.set("n", "<Leader>s", ":SidebarNvimToggle<CR>", { noremap = true })
end

return M
