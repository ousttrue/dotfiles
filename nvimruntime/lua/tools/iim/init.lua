local M = {}

-- TODO: extmarks 
-- TODO: indicator

function M.setup()
  print "hello"
  local Context = require "tools.iim.context"
  M.Keymap = require "tools.iim.keymap"
  M.context = Context.new()
  M.enabled = false

  vim.keymap.set("i", "<C-j>", M.toggle, { expr = true })

  M.start = 0
  M.buffer = ""

  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = { "*" },
    callback = function(ev)
      M.start = 0
      M.buffer = ""
    end,
  })

  vim.api.nvim_create_autocmd("InsertCharPre", {
    pattern = { "*" },
    callback = function(ev)
      if not M.enabled then
        return
      end
      M.on_insert_char_pre(ev)
    end,
  })

  M.ns = vim.api.nvim_create_namespace ""
  vim.api.nvim_set_decoration_provider(M.ns, {
    on_win = function(_, _, bufnr)
      return M.enabled and #M.buffer > 0
    end,
    on_line = function(_, winid, bufnr, row)
      if not M.enabled or #M.buffer == 0 then
        return false
      end
      vim.api.nvim_buf_set_extmark(bufnr, M.ns, row, M.start, {
        virt_text = { { M.buffer, "DiffAdd" } },
        virt_text_pos = "overlay",
        ephemeral = true,
      })
      return true
    end,
  })

  M.indicator = require "tools.iim.indicator.indicator" ()
  M.indicator:open()
end

function M.on_insert_char_pre(ev)
  if M.buffer == "" then
    M.start = vim.fn.col "." - 1
  end
  -- print(vim.v.char)
  -- print(vim.inspect(ev))
  M.buffer = M.buffer .. vim.v.char
  -- vim.v.char = ""
  -- print(M.buffer)
  -- local bufnr = vim.api.nvim_get_current_buf()
  -- local row = vim.fn.line "."
  -- vim.api.nvim__redraw {
  --   buf = bufnr,
  --   range = { row, row + 1 },
  --   flush = true,
  -- }
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
  if M.enabled then
    return ""
  end

  M.enabled = true
  return "<C-^>"
end

---@return string
function M.disable()
  if not M.enabled then
    return ""
  end

  M.start = 0
  M.buffer = ""
  M.enabled = false
  return "<C-^>"
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
