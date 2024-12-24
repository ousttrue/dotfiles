local M = {}
---@generic T
---@param group integer
---@param dir string
---@param module_name string
---@param shutdown fun():T
---@param reload fun(context: T)
function M.autocmd(group, dir, module_name, shutdown, reload)
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
