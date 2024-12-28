local MODULE_NAME = "tools.loghighlighter"

---@class LogHighlighter
---@field bufnr integer
---@field ns integer
local Highlighter = {}

---@return LogHighlighter
function Highlighter.new(_bufnr)
  local ns = vim.api.nvim_create_namespace(("%s.%d"):format(MODULE_NAME, _bufnr))

  local self = setmetatable({
    bufnr = _bufnr,
    ns = ns,
  }, { __index = Highlighter })

  vim.api.nvim_set_decoration_provider(ns, {
    on_win = function(win, winid, bufnr, toprow, botrow)
      ---@diagnostic disable-next-line
      return bufnr == self.bufnr
      -- return false
    end,
    on_line = function(_, _, bufnr, row)
      self:highlight(bufnr, row)
    end,
  })

  return self
end

function Highlighter.delete(self)
  vim.api.nvim_set_decoration_provider(self.ns, {})
end

function Highlighter.highlight(self, bufnr, row)
  local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1]
  -- lsp.log
  -- [ERROR][2024-12-11 23:53:50] message...

  local s, e, severity = line:find "^%[(%w+)%]"
  local hl = nil
  if severity == "ERROR" then
    hl = "DiagnosticError"
  elseif severity == "WARN" then
    hl = "DiagnosticWarn"
  end
  if hl then
    vim.api.nvim_buf_set_extmark(bufnr, self.ns, row, s, {
      -- end_line = row + 1,
      end_col = e - 1,
      hl_group = hl,
      hl_eol = true,
      ephemeral = true,
    })
  end
end

---
--- module
---
local M = {
  ---@type {[integer]:LogHighlighter}
  map = {},
}

function M.enable()
  local bufnr = vim.api.nvim_get_current_buf()
  local hl = M.map[bufnr]
  if not hl then
    hl = Highlighter.new(bufnr)
    M.map[bufnr] = hl
  end
end

function M.disable()
  for k, v in pairs(M.map) do
    v:delete()
  end
  M.map = {}
end

function M.setup()
  local group = vim.api.nvim_create_augroup(MODULE_NAME, {})

  require("tools.reload").autocmd(group, MODULE_NAME, function()
    -- shutdown
    M.disable()
    return nil
  end, function(content)
    -- reload
  end)

  vim.api.nvim_create_user_command("LogHighlightEnable", function()
    require(MODULE_NAME).enable()
  end, {})
  vim.api.nvim_create_user_command("LogHighlightDisable", function()
    require(MODULE_NAME).disable()
  end, {})
end

return M
