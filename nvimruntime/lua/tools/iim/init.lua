local M = {}

-- TODO: indicator

function M.setup()
  local Context = require "tools.iim.context"
  M.Keymap = require "tools.iim.keymap"
  M.context = Context.new()
  M.keys = vim.split("abcdefghijklmnopqrstuvwxyz", "")
  M.enabled = false

  vim.keymap.set("i", "<C-j>", M.toggle, { expr = true })
end

---@param key string
---@return string
function M.handle(key)
  M.Keymap.handleKey(M.context, key)
  local output = M.context.preEdit:output(M.context:toString())
  return output
end

---@return string
function M.enable()
  if not M.enabled then
    for _, lhs in ipairs(M.keys) do
      vim.keymap.set("l", lhs, function()
        return M.handle(lhs)
      end, { buffer = true, silent = true, expr = true })
    end
    return "<C-^>"
  else
    return ""
  end
end

---@return string
function M.disable()
  if M.enabled then
    for _, lhs in ipairs(M.keys) do
      vim.keymap.del("l", lhs, { buffer = true })
    end
    return "<C-^>"
  else
    return ""
  end
end

---@return string
function M.toggle()
  if M.enabled == 1 then
    return M.disable()
  else
    return M.enable()
  end
end

return M
