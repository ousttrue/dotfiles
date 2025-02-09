local M = {}

---@param src string
---@param dst string
local function copy(src, dst)
  print(dst, "<-", src)
end

function M.setup()
  vim.api.nvim_create_user_command("DotSyncAdd", function(args)
    local full = vim.fs.abspath(vim.fn.bufname())
    local base = vim.fs.abspath "~"
    if full:match(base) then
      local relative = full:sub(#base + 2)
      if relative:find "^AppData/" then
        copy(full, "APPDATA")
      else
        copy(full, "HOME")
      end
    else
      print(full, base)
    end
  end, {})
end

return M
