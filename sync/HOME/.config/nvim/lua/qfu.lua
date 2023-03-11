local M = {}

local icon = {
  e = "%#DiagnosticError# %#Normal#",
  w = "%#DiagnosticWarn# %#Normal#",
  n = "%#DiagnosticInfo# %#Normal#",
}

M.qflist = {
  title = "--",
  lines = { "" },
  efm = "%f:%l:%c: %t%*[^:]: %m,%Dninja: Entering directory `%f'",
}

function M.async_make()
  M.qflist.lines = { "" }
  local winnr = vim.fn.win_getid()
  local bufnr = vim.api.nvim_win_get_buf(winnr)

  local makeprg = vim.api.nvim_get_option "makeprg"
  if not makeprg then
    return
  end

  M.qflist.title = vim.fn.expandcmd(makeprg)

  local function on_event(job_id, data, event)
    if event == "stdout" or event == "stderr" then
      if data then
        vim.list_extend(M.qflist.lines, data)
      end
    end

    if event == "exit" then
      vim.fn.setqflist({}, " ", M.qflist)
      vim.api.nvim_command "doautocmd QuickFixCmdPost"
    end
  end

  local job_id = vim.fn.jobstart(M.qflist.title, {
    on_stderr = on_event,
    on_stdout = on_event,
    on_exit = on_event,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

function M.get_status()
  local what = vim.fn.getqflist { title = true }
  local list = vim.fn.getqflist()

  local count = {}
  for _, item in ipairs(list) do
    if #item.type > 0 then
      local current = count[item.type] or 0
      count[item.type] = current + 1
    end
  end

  local status = what.title
  for k, v in pairs(count) do
    status = status .. ", " .. icon[k] .. v
  end

  -- what.title
  return status
end

return M
