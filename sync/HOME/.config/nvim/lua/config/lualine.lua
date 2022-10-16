local M = {}
function M.setup()
    require("lualine").setup {
        options = {
            globalstatus = true,
        },
    }
end
return M
