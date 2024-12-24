local M = {}
---@generic T
---@param group integer
---@param module_name string
---@param shutdown fun():T
---@param reload fun(context: T)
function M.autocmd(group, module_name, shutdown, reload)
  local file = debug.getinfo(2, "S").source:sub(2)
  local dir = vim.fs.dirname(file)
  -- print('reload:'..file)

  local module_name_dot = module_name .. "."
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = { dir .. "/*.lua" },
    -- reload
    callback = function(event)
      -- shutdown
      local context = shutdown()
      -- clear module
      for key in pairs(package.loaded) do
        if key == module_name or vim.startswith(key, module_name_dot) then
          package.loaded[key] = nil
        end
      end
      -- reload new module
      reload(context)
    end,
  })
end

return M
