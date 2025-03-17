-- https://github.com/roobert/hoversplit.nvim
local M = {}

---@class HoverSplit
---@field command string
---@field hover_bufnr integer
---@field hover_winid integer
local HoverSplit = {}
HoverSplit.__index = HoverSplit

local g_hover = nil

---@param command string
---@return HoverSplit
function HoverSplit.new(command)
  local self = setmetatable({
    command = command,
  }, HoverSplit)
  return self
end

function HoverSplit:close()
  if self.hover_bufnr and vim.api.nvim_buf_is_valid(self.hover_bufnr) then
    vim.api.nvim_buf_delete(self.hover_bufnr, { force = true })
    self.hover_bufnr = nil
  end
end

---@param remain_focused boolean
function HoverSplit:split(remain_focused)
  local orig_winid
  if not self.hover_winid or not vim.api.nvim_win_is_valid(self.hover_winid) then
    orig_winid = vim.api.nvim_get_current_win()
    vim.api.nvim_command(self.command)
    self.hover_winid = vim.api.nvim_get_current_win()
  end
  if not self.hover_bufnr or not vim.api.nvim_buf_is_valid(self.hover_bufnr) then
    self.hover_bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(self.hover_bufnr)
    vim.api.nvim_buf_set_name(self.hover_bufnr, "hoversplit")
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = self.hover_bufnr })
    vim.api.nvim_set_option_value("modifiable", false, { buf = self.hover_bufnr })
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = self.hover_bufnr })
    vim.api.nvim_buf_set_var(self.hover_bufnr, "is_lsp_hover_split", true)
  end
  if orig_winid and remain_focused then
    vim.api.nvim_set_current_win(orig_winid)
  end
end

function HoverSplit:create_buf() end

---@param remain_focused boolean
function HoverSplit:update_hover_content(remain_focused)
  -- Check the current buffer and cursor position
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local current_line = vim.api.nvim_buf_get_lines(bufnr, cursor_pos[1] - 1, cursor_pos[1], false)[1] or ""

  -- Validate the cursor position
  if cursor_pos[1] < 1 or cursor_pos[1] > line_count or cursor_pos[2] < 0 or cursor_pos[2] > #current_line then
    print "Invalid cursor position detected. Skipping hover content update."
    return
  end

  vim.lsp.buf_request(0, "textDocument/hover", vim.lsp.util.make_position_params(nil, "utf-32"), function(err, result)
    if err or not result or not result.contents then
      return
    end

    self:split(remain_focused)
    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    vim.api.nvim_set_option_value("modifiable", true, { buf = self.hover_bufnr })
    vim.api.nvim_buf_set_lines(self.hover_bufnr, 0, -1, false, lines)
    vim.api.nvim_set_option_value("modifiable", false, { buf = self.hover_bufnr })
  end)
end

local function create_hover_split(command, remain_focused)
  if g_hover then
    if g_hover.command ~= command then
      g_hover:close()
      g_hover = HoverSplit.new(command)
    end
  else
    g_hover = HoverSplit.new(command)
  end

  g_hover:update_hover_content(remain_focused)
end

M.split_remain_focused = function()
  create_hover_split("sp", true)
end

function M.setup()
  vim.keymap.set("n", "K", M.split_remain_focused, {
    noremap = true,
    silent = true,
  })

  vim.keymap.set("n", "q", "<CMD>:q<CR>", {})
end

return M
