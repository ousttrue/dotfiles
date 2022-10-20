for k, v in pairs(vim.lsp.handlers) do
  print(k, v)
end

local function on_symbol(...)
  print { ... }
end

vim.lsp.handlers["textDocument/documentSymbol"] = on_symbol

-- コンテンツ用ウィンドウの作成
local function create_contents_window(config)
  local buffer = vim.api.nvim_create_buf(false, true)
  return vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    row = config.row + 1,
    col = config.col + 2,
    width = config.width - 4,
    height = config.height - 2,
    style = "minimal",
  })
end

local function create_line(ch, length)
  local line = ""
  for _ = 1, length do
    line = line .. ch
  end
  return line
end

-- 枠線用ウィンドウの作成
local function create_border_window(config)
  local top = "╭" .. create_line("─", config.width - 2) .. "╮"
  local mid = "│" .. create_line(" ", config.width - 2) .. "│"
  local bot = "╰" .. create_line("─", config.width - 2) .. "╯"
  local lines = { top }
  for _ = 1, config.height - 2 do
    table.insert(lines, mid)
  end
  table.insert(lines, bot)
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buffer, 0, -1, true, lines)
  return vim.api.nvim_open_win(buffer, true, config)
end

-- 2つで1つのウィンドウとしてみせる
local function new_window(config)
  create_border_window(config)
  create_contents_window(config)
end

-- ex.) 使い方
local config = {
  relative = "editor",
  row = 30,
  col = 30,
  width = 50,
  height = 20,
  anchor = "NW",
  style = "minimal",
}
new_window(config)
