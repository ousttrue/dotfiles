local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Q", function(ev)
    local url = ("https://www.google.com/search?hl=ja&ie=UTF-8&q=%s"):format(vim.uri_encode(ev.fargs[1]))
    print(url)
    -- vim.cmd(("edit %s"):format(url))
    local w = vim.api.nvim_get_current_win()
    local b = vim.fn.bufadd(url)
    vim.api.nvim_win_set_buf(w, b)
  end, {
    nargs = 1,
  })
end

return M
