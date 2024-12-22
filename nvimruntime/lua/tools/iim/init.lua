local M = {}

local KEYS = vim.split("abcdefghijklmnopqrstuvwxyz", "")

function M.setup()
  local Context = require "tools.iim.context"
  M.Keymap = require "tools.iim.keymap"
  M.context = Context.new()
  M.enabled = false
  M.start = 0
  M.buffer = ""

  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = { "*" },
    callback = function(ev)
      M.enabled = false
      M.start = 0
      M.buffer = ""
      local indicator = require "tools.indicator"
      indicator:close()
      vim.cmd [[set iminsert=0]]
    end,
  })

  vim.keymap.set("i", "<C-j>", M.toggle, { expr = true })

  for _, lhs in ipairs(KEYS) do
    vim.keymap.set("l", lhs, function()
      M.Keymap.handleKey(M.context, lhs)
      return M.context.preEdit:output(M.context:toString())
    end, {
      -- buffer = true,
      silent = true,
      expr = true,
    })
  end
end

---@return string
function M.enable()
  if M.enabled then
    return ""
  end

  local expr = ""
  if vim.bo.iminsert ~= 1 then
    expr = "<C-^>"
  end

  M.enabled = true
  local indicator = require "tools.indicator"
  indicator.set "あ"
  indicator:open()

  return expr
end

---@return string
function M.disable()
  if not M.enabled then
    return ""
  end

  local expr = ""
  if vim.bo.iminsert == 1 then
    -- for _, lhs in ipairs(KEYS) do
    --   vim.keymap.del("l", lhs, {
    --     -- buffer = true,
    --   })
    -- end
    expr = "<C-^>"
  end

  M.start = 0
  M.buffer = ""
  M.enabled = false
  local indicator = require "tools.indicator"
  indicator.set "Aa"

  return expr
end

---@return string
function M.toggle()
  if M.enabled then
    return M.disable()
  else
    return M.enable()
  end
end

return M
