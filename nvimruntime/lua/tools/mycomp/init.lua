local MODULE_NAME = "tools.mycomp"

---@class Comp
---@field buf number buffer number
---@field win number winow number
---@field content string
local Comp = {}
Comp.__index = Comp

function Comp.set_content(self, content)
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

  local y, x = unpack(vim.fn.win_screenpos(0))

  local anchor = ""
  if row > h + 2 then
    row = y + row - 1
    anchor = "SW"
  else
    row = y + row
    anchor = "NW"
  end

  col = x + col - 2
  vim.api.nvim_win_set_config(self.win, {
    relative = "editor",
    anchor = anchor,
    row = row,
    col = col,
    width = w,
    height = h,
  })

  vim.api.nvim_buf_set_lines(self.buf, 0, -1, true, lines)
  vim.cmd [[redraw]]
end

function Comp.buf_enter(self, event)
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

function Comp.buf_leave(self, event)
  -- self:set_content(vim.inspect(event))
end

function Comp.cursor_moved(self, event)
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

function Comp.close(self)
  if self.win then
    vim.api.nvim_win_close(self.win, false)
    self.win = nil
  end
end

function Comp.open(self)
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

function Comp.delete(self)
  self:close()
  vim.api.nvim_buf_delete(self.buf, {
    force = true,
    unload = false,
  })
end

function Comp.new(opts)
  local self = setmetatable({
    opts = opts,
  }, Comp)

  --
  -- buf
  --
  self.buf = vim.api.nvim_create_buf(false, true)

  --
  -- VimEvent
  --
  local group = vim.api.nvim_create_augroup("mycomp", { clear = true })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(event)
      self:buf_enter(event)
    end,
  })

  vim.api.nvim_create_autocmd("BufLeave", {
    group = group,
    callback = function(event)
      self:buf_leave(event)
    end,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    callback = function(event)
      self:cursor_moved(event)
    end,
  })

  --
  -- reload when write
  --
  local file = debug.getinfo(1, "S").source:sub(2)
  local dir = vim.fs.dirname(file)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = { dir .. "/*.lua" },
    -- reload
    callback = function(event)
      local content = self.win and self.content
      -- shutdown
      self:delete()
      -- clear module
      for key in pairs(package.loaded) do
        if key == MODULE_NAME then
          package.loaded[key] = nil
        end
      end
      -- reload new module
      local new_instance = require(MODULE_NAME):setup(opts)
      if content then
        new_instance:open()
        new_instance:set_content(content)
      end
    end,
  })

  --
  -- keymap
  --
  vim.keymap.set("n", "gy", function()
    if self.win then
      self:close()
    else
      self:open()
      if self.content then
        self:set_content(self.content)
      end
    end
  end, { noremap = true })

  return self
end

local M = {}

function M.setup(opts)
  --
  -- singleton
  --
  if not M.instance then
    M.instance = Comp.new(opts)
  end
  return M.instance
end

return M
