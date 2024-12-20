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
end

return {
  setup = setup,
}
