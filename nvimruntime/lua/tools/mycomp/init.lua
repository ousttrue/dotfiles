local function setup(opts)
  local group = vim.api.nvim_create_augroup("mycomp", {})

  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(event)
      require("tools.mycomp.impl").get_instance(opts):buf_enter(event)
    end,
  })

  vim.api.nvim_create_autocmd("BufLeave", {
    group = group,
    callback = function(event)
      require("tools.mycomp.impl").get_instance(opts):buf_leave(event)
    end,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    callback = function(event)
      require("tools.mycomp.impl").get_instance(opts):cursor_moved(event)
    end,
  })

  -- local pattern = vim.fn.expand "<sfile>" --:p:h:h" .. "/*"
  local file = debug.getinfo(1, "S").source:sub(2)
  local dir = vim.fs.dirname(file)
  local reload_key = "tools.mycomp.impl"
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = { dir .. "/impl.lua" }, -- 'lua require("myplugin/cleanup")},
    callback = function(event)
      local content = require("tools.mycomp.impl").delete()
      for key in pairs(package.loaded) do
        if key == reload_key then
          -- if vim.startswith(key, dir) or vim.startswith(key, dot) or key == plugin_name then
          package.loaded[key] = nil
        end
      end
      if content then
        require("tools.mycomp.impl").get_instance(opts):open()
        require("tools.mycomp.impl").get_instance(opts):set_content(content)
      end
    end,
  })
end

return {
  setup = setup,
}
