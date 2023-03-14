local M = {}

local icon = {
  e = "%#DiagnosticError# %#Normal#",
  w = "%#DiagnosticWarn# %#Normal#",
  n = "%#DiagnosticInfo# %#Normal#",
}

M.qflist = {
  title = "--",
  lines = { "" },
  efm = "%Dninja: Entering directory `%f',%f:%l:%c: %t%*[^:]: %m,%Eld%.lld: %trror: undefined symbol: %m%n,%N>>> referenced by %s (%f:%l)Tn,%N>>> %m",
}
-- || ld.lld: error: undefined symbol: TabBuffer::eachBuffer(std::function<void (Buffer*)> const&)
-- || >>> referenced by core.cpp:659 (/home/ousttrue/ghq/github.com/ousttrue/w3m/builddir/../src/core.cpp:659)
-- || >>>               src/w3m.p/core.cpp.o:(deleteFiles()::$_0::operator()(TabBuffer*) const)

M.status = ""

function M.async_make()
  M.status = "[prepare...]"
  M.qflist.lines = { "" }

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
      M.job_id = nil
      M.status = ""
      vim.cmd "redrawstatus!"
      M.setqflist()
      vim.api.nvim_command "doautocmd QuickFixCmdPost"
    end
  end

  M.job_id = vim.fn.jobstart(M.qflist.title, {
    on_stderr = on_event,
    on_stdout = on_event,
    on_exit = on_event,
    stdout_buffered = true,
    stderr_buffered = true,
  })
  M.set_status(string.format("[job_id: %d]", M.job_id))
end

function M.setqflist()
  vim.fn.setqflist({}, " ", M.qflist)
end

function M.qf_to_location() end

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
    status = status .. ", " .. (icon[k] or (k .. ": ")) .. v
  end
  status = status .. " " .. M.status

  -- what.title
  return status
end

function M.set_status(status)
  if M.win_id then
    if status then
      M.status = status
    end
    vim.api.nvim_win_set_option(M.win_id, "winbar", M.get_status())
    vim.cmd "redrawstatus!"
  end
end

function M.Qf_filter()
  local title = vim.fn.getqflist({ title = true }).title
  local items = {}
  for _, item in ipairs(vim.fn.getqflist()) do
    if item.type == "e" then
      table.insert(items, item)
    end
  end
  vim.fn.setqflist({}, " ", {
    items = items,
    title = title .. "[error]",
  })
end

return M