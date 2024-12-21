local Cls = {}
Cls.__index = Cls

function Cls.set_content(self, content)
  local row = vim.fn.winline()
  local col = vim.fn.wincol()
  self.content = content
  if not self.win then
    return
  end
  local lines = vim.fn.split(content, "\n")
  local w = 0
  local h = 0
  for i, line in ipairs(lines) do
    if #line > w then
      w = #line
    end
    h = h + 1
  end
  if type(row) == "number" and type(col) == "number" then
    local y, x = unpack(vim.fn.win_screenpos(0))
    vim.api.nvim_win_set_config(self.win, {
      relative = "editor",
      anchor = "SW",
      row = y + row - 1,
      col = x + col - 2,
      width = w,
      height = h,
    })
  else
    vim.api.nvim_win_set_config(self.win, {
      relative = "editor",
      anchor = "NE",
      row = 0,
      col = vim.o.columns,
      width = w,
      height = h,
    })
  end
  vim.api.nvim_buf_set_lines(self.buf, 0, -1, true, lines)
  vim.cmd [[redraw]]
end

function Cls.buf_enter(self, event)
  -- print("BufEnter")
  --
  -- local buf = vim.api.nvim_win_get_buf(0)
  --
  -- if vim.bo[buf].readonly then
  --   return
  -- end
  -- self:open()
  -- self:set_content(vim.inspect(event))
end

function Cls.buf_leave(self, event)
  -- self:set_content(vim.inspect(event))
end

function Cls.cursor_moved(self, event)
  local current_win = vim.api.nvim_get_current_win()
  if current_win ~= self.current_win then
    self.current_win = current_win
    self:close()
    -- print("BufEnter")
    local buf = vim.api.nvim_win_get_buf(0)
    if vim.bo[buf].readonly or not vim.bo[buf].modifiable or not vim.bo[buf].buflisted then
      return
    end
    self:open()
  end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  self:set_content(("%03d:%03d"):format(row, col))
end

function Cls.close(self)
  if self.win then
    vim.api.nvim_win_close(self.win, false)
    self.win = nil
  end
end

function Cls.open(self)
  local win = vim.api.nvim_open_win(self.buf, false, {
    relative = "editor",
    row = 1,
    col = 1,
    width = 1,
    height = 1,
    border = "rounded",
    zindex = 9001,
    style = "minimal",
  })
  vim.wo[win].winfixbuf = true
  self.win = win
end

function Cls.delete(self)
  self:close()
  vim.api.nvim_buf_delete(self.buf, {
    force = true,
    unload = false,
  })
end

function Cls.new(opts)
  local buf = vim.api.nvim_create_buf(false, true)
  local self = setmetatable({
    opts = opts,
    buf = buf,
  }, Cls)
  return self
end

--
-- singleton
--
local M = {}

function M.get_instance(opts)
  if not M.instance then
    M.instance = Cls.new(opts)
  end
  return M.instance
end

function M.delete()
  if M.instance then
    local content = M.instance.win and M.instance.content
    M.instance:delete()
    M.instance = nil
    return content
  end
end

return M
