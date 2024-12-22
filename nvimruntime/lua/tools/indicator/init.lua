local MODULE_NAME = "tools.indicator"
local MODULE_NAME_DOT = MODULE_NAME .. "."
local USER_SET_CONTENT = "tools.indicator.set_content"

--
-- カーソルに追随する
--

local M = {}

---@class Opts

---@class Content
---@field content string
---@field lines string[]
---@field cols integer
---@field rows integer
local Content = {}
Content.__index = Content

---@return Content
function Content.new()
  local self = setmetatable({}, Content)
  return self
end

---@param content string
---@param buf integer
function Content.set(self, content, buf)
  self.content = content
  self.lines = nil
end

function Content.get_lines(self, buf)
  if not self.content then
    return nil
  end
  if self.lines then
    return self.lines
  end
  self.lines = vim.fn.split(self.content, "\n")
  self.cols = 0
  self.rows = 0
  for i, line in ipairs(self.lines) do
    if #line > self.cols then
      self.cols = vim.fn.strwidth(line)
    end
    self.rows = self.rows + 1
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, self.lines)
end

---@class Comp
---@field opts Opts
---@field buf number
---@field win number
---@field content Content
local Comp = {
  content = Content.new(),
}
M.Comp = Comp
Comp.__index = Comp

---@param opts Opts
function Comp.new(opts)
  local self = setmetatable({
    opts = opts,
    content = Content.new(),
  }, Comp)
  M.instance = self

  --
  -- buf
  --
  self.buf = vim.api.nvim_create_buf(false, true)
  self.content:set(" ", self.buf)

  --
  -- VimEvent
  --
  local group = vim.api.nvim_create_augroup(MODULE_NAME, { clear = true })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    callback = function(event)
      self:redraw()
    end,
  })

  vim.api.nvim_create_autocmd("CursorMovedI", {
    group = group,
    callback = function(event)
      self:redraw()
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = USER_SET_CONTENT,
    callback = function(event)
      -- self:redraw()
      vim.defer_fn(function()
        self:set_content(event.data)
        self:redraw()
      end, 0)
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
      local content = self.content
      -- shutdown
      self:delete()
      -- clear module
      for key in pairs(package.loaded) do
        if key == MODULE_NAME or vim.startswith(key, MODULE_NAME_DOT) then
          package.loaded[key] = nil
        end
      end
      -- reload new module
      local new_instance = require(MODULE_NAME).Comp.new(opts)
      new_instance:set_content(content.content)

      if new_instance.content then
        new_instance:redraw()
      end
    end,
  })

  --
  -- keymap
  --
  vim.keymap.set("n", "gy", function()
    self:toggle_window()
  end, { noremap = true })

  return self
end

function Comp.redraw(self)
  if not self.win then
    return
  end
  local lines = self.content:get_lines(self.buf)
  if not lines then
    return
  end

  local y, x = unpack(vim.fn.win_screenpos(0))
  local row = vim.fn.winline()
  local col = vim.fn.wincol()
  local anchor = ""
  if row > self.content.rows + 2 then
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
    width = self.content.cols,
    height = self.content.rows,
  })

  vim.cmd [[redraw]]
end

---@param content string
function Comp.set_content(self, content)
  local lines = self.content:set(content, self.buf)
  if not lines then
    return
  end
end

function Comp.open(self)
  if self.win then
    return
  end
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
  self:redraw()
end

function Comp.close(self)
  if self.win then
    vim.api.nvim_win_close(self.win, false)
    self.win = nil
  end
end

function Comp.toggle_window(self)
  if self.win then
    self:close()
  else
    self:open()
  end
end

function Comp.delete(self)
  self:close()
  vim.api.nvim_buf_delete(self.buf, {
    force = true,
    unload = false,
  })
end

function M.setup(opts)
  Comp.new(opts)
end

function M.set(content)
  vim.api.nvim_exec_autocmds("User", {
    pattern = USER_SET_CONTENT,
    data = content,
  })
end

function M.open()
  if M.instance then
    vim.defer_fn(function()
      M.instance:open()
    end, 0)
  end
end

function M.close()
  if M.instance then
    vim.defer_fn(function()
      M.instance:close()
    end, 0)
  end
end

return M
