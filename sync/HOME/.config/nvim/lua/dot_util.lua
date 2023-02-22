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

M._border = {
  { "┏", "FloatBorder" }, -- upper left
  { "━", "FloatBorder" }, -- upper
  { "┓", "FloatBorder" }, -- upper right
  { "┃", "FloatBorder" }, -- right
  { "┛", "FloatBorder" }, -- lower right
  { "━", "FloatBorder" }, -- lower
  { "┗", "FloatBorder" }, -- lower left
  { "┃", "FloatBorder" }, -- left
}

M.border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

return M
