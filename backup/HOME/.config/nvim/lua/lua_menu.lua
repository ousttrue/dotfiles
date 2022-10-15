--
-- https://github.com/kizza/actionmenu.nvim
-- lua frontend
--
local M = {
    callback = 0,
}

local function map(tbl, f)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

M.open = function(items, callback)
    local vim_items = table.concat(
        map(items, function(x)
            return '"' .. x .. '"'
        end),
        ","
    )
    M.callback = callback
    local cmd = string.format(
        [[call actionmenu#open([%s], { index, item -> execute(':lua require("lua_menu").callback('.index.',"'.item.'")', '') })]],
        vim_items
    )
    print(cmd)
    vim.cmd(cmd)
end

M.example = function()
    M.open({ "a", "c" }, function(i, v)
        print(string.format("%d %s", i, v))
    end)
end

return M
