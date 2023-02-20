local M = {}

function M.get_home()
  if vim.fn.has('win32') == 1 then
    return vim.env.USERPROFILE
  else
    return vim.env.HOME
  end
end

function M.get_suffix()
  if vim.fn.has('win32') == 1 then
    return '.exe'
  else
    return ''
  end
end

return M
