-- https://www.reddit.com/r/neovim/comments/1dvvdj3/how_to_easily_identify_highlight_groups/
-- https://gist.github.com/roycrippen4/e65c8987f1e7a09959ea69e04362e15c
-- https://github.com/neovim/neovim/discussions/27257
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local iter = vim.iter

local autocmd = api.nvim_create_autocmd
local close_win = api.nvim_win_close
local create_buf = api.nvim_create_buf
local create_namespace = api.nvim_create_namespace
local get_current_win = api.nvim_get_current_win
local get_cursor = api.nvim_win_get_cursor
local get_lines = api.nvim_buf_get_lines
local getmousepos = fn.getmousepos
local inspect_pos = vim.inspect_pos
local map = vim.keymap.set
local open_win = api.nvim_open_win
local set_current_win = api.nvim_set_current_win
local set_extmark = api.nvim_buf_set_extmark
local set_lines = api.nvim_buf_set_lines
local set_option_value = api.nvim_set_option_value
local win_get_buf = api.nvim_win_get_buf
local win_is_valid = api.nvim_win_is_valid
local win_set_buf = api.nvim_win_set_buf
local win_set_config = api.nvim_win_set_config
local win_set_height = api.nvim_win_set_height
local win_set_width = api.nvim_win_set_width

local ns = create_namespace "inspect_word"
local width = 34
local buf = create_buf(false, true)
local uses_mousemoveevent = vim.o.mousemoveevent

vim.bo[buf].ft = "inspector"
local win = nil

---@param inspect_info InspectInfo
---@return FormattedLine[]
local function format_inspect_info(inspect_info)
  ---@type FormattedLine[]
  local result = {}
  local idx = 1
  local has_ts = false
  local has_lsp = false

  ---@param ... FormattedLinePart
  local function insert(...)
    local parts = { ... }
    result[idx] = result[idx] or {}

    for _, part in ipairs(parts) do
      table.insert(result[idx], part)
    end
  end

  local function newline()
    table.insert(result, {})
    idx = idx + 1
  end

  if #vim.tbl_keys(inspect_info.treesitter) > 0 then
    has_ts = true
    insert { text = "Treesitter", col_start = 0, col_end = 9, hl_group = "@function.call.lua" }

    for _, entry in ipairs(inspect_info.treesitter) do
      newline()
      local hl_group = {
        text = "  - " .. entry.hl_group,
        col_start = 4,
        col_end = #entry.hl_group + 4,
        hl_group = entry.hl_group,
      }
      local links_to = {
        text = " links to ",
        col_start = hl_group.col_end,
        col_end = hl_group.col_end + #" links to ",
        hl_group = "@function.call.lua",
      }
      local hl_link = {
        text = entry.hl_group_link,
        col_start = links_to.col_end,
        col_end = #entry.hl_group_link + links_to.col_end,
        hl_group = entry.hl_group_link,
      }
      local lang = {
        text = " " .. entry.lang,
        col_start = hl_link.col_end,
        col_end = #entry.lang + hl_link.col_end,
        hl_group = "@comment",
      }
      insert(hl_group, links_to, hl_link, lang)
    end

    newline()
  end

  if #vim.tbl_keys(inspect_info.semantic_tokens) > 0 then
    has_lsp = true
    if has_ts then
      newline()
    end

    insert { text = "Semantic Tokens", col_start = 0, col_end = 15, hl_group = "@function.lua" }

    for _, entry in ipairs(inspect_info.semantic_tokens) do
      newline()
      local hl_group = {
        text = "  - " .. entry.opts.hl_group,
        col_start = 4,
        col_end = #entry.opts.hl_group + 4,
        hl_group = entry.opts.hl_group,
      }
      local links_to = {
        text = " links to ",
        col_start = hl_group.col_end,
        col_end = hl_group.col_end + #" links to ",
        hl_group = "@function.call.lua",
      }
      local hl_link = {
        text = entry.opts.hl_group_link,
        col_start = links_to.col_end,
        col_end = #entry.opts.hl_group_link + links_to.col_end,
        hl_group = entry.opts.hl_group_link,
      }
      local priority_str = " priority: " .. entry.opts.priority
      local priority = {
        text = priority_str,
        col_start = hl_link.col_end,
        col_end = #priority_str + hl_link.col_end,
        hl_group = "@comment",
      }
      insert(hl_group, links_to, hl_link, priority)
    end

    newline()
  end

  if #vim.tbl_keys(inspect_info.extmarks) > 0 then
    if has_ts or has_lsp then
      newline()
    end
    insert { text = "Extmarks", col_start = 0, col_end = 8, hl_group = "@function.lua" }

    for _, entry in ipairs(inspect_info.extmarks) do
      newline()
      insert {
        text = "  - " .. entry.opts.hl_group,
        col_start = 4,
        col_end = #entry.opts.hl_group + 4,
        hl_group = entry.opts.hl_group,
      }

      if #entry.ns ~= 0 then
        insert {
          text = " " .. entry.ns,
          col_start = #entry.opts.hl_group + 4,
          col_end = #entry.opts.hl_group + 4 + #entry.ns,
          hl_group = "@comment",
        }
      end
    end

    newline()
  end

  if #result > 0 then
    newline()
  end

  return result
end

---@param info FormattedLine[]
local function put_lines_in_buf(info)
  if #info == 0 then
    return
  end

  ---@param acc string
  ---@param part FormattedLinePart
  local concatenate = function(acc, part)
    return acc .. part.text
  end

  ---@param idx integer
  ---@param parts FormattedLine
  local insert_lines = function(idx, parts)
    local it = iter(parts)
    set_lines(buf, idx - 1, idx, false, { it:fold("", concatenate) })

    it:each(
      ---@param part FormattedLinePart
      function(part)
        set_extmark(buf, ns, idx - 1, part.col_start, {
          end_row = idx - 1,
          end_col = part.col_end + 1,
          hl_group = part.hl_group,
          strict = false,
        })
      end
    )
  end

  iter(ipairs(info)):each(insert_lines)
end

local function inspect_in_split()
  local pos = get_cursor(0)
  local info = format_inspect_info(inspect_pos(0, pos[1] - 1, pos[2]))

  if #info == 0 then
    vim.notify("No information found", vim.log.levels.WARN)
    return
  end

  put_lines_in_buf(info)
  cmd "botright split"
  cmd "set nonumber"
  cmd "set norelativenumber"
  win_set_buf(0, buf)
  win_set_height(0, #info)
  set_option_value("foldcolumn", "0", { win = 0 })
  local quit = "<cmd>q<cr><c-w>l"

  vim.keymap.set("n", "q", quit, { buffer = buf })
  set_extmark(buf, ns, #info - 1, 0, {
    virt_text = { { "q", "@keyword" }, { " - Exit the window" } },
  })
end

---@return integer
local function find_max_width()
  local longest = 0

  ---@param line string
  local function compare_and_set(line)
    if #line > longest then
      longest = #line
    end
  end

  iter(get_lines(buf, 0, -1, false)):each(compare_and_set)

  return longest
end

local function inspect_in_float()
  if not vim.o.mousemoveevent then
    vim.o.mousemoveevent = true
  end

  if win and win_is_valid(win) then
    close_win(win, true)
    return
  end

  local current_win = get_current_win()
  win = open_win(buf, true, {
    relative = "cursor",
    width = 22,
    height = 1,
    row = 1,
    col = 1,
    style = "minimal",
    focusable = false,
    border = "rounded",
    zindex = 1000,
  })
  set_option_value("winblend", 0, { win = win })
  set_lines(buf, 0, -1, false, { " No information found " })
  win_set_buf(win, buf)

  if get_current_win() == win then
    set_current_win(current_win)
  end
end

local function update_float()
  vim.schedule(function()
    --- Early exit if no window, the winid is 0, or the window is invalid
    if not win or win == 0 or not win_is_valid(win) then
      return
    end

    local pos = getmousepos()
    local info = format_inspect_info(inspect_pos(win_get_buf(pos.winid), pos.line - 1, pos.column - 1))

    if #info == 0 and get_lines(buf, 0, -1, false)[1] ~= " No information found " then
      width = 22
      set_lines(buf, 0, -1, false, { " No information found " })
      win_set_height(win, 1)
      win_set_width(win, width)
      return
    end

    if #info > 0 then
      put_lines_in_buf(info)
      width = find_max_width()
      win_set_height(win, #info - 2)
      win_set_width(win, width)
    end

    local row, col = pos.screenrow, pos.screencol
    if vim.o.lines - row <= 4 then
      row = row - 4
    end

    if vim.o.columns - col - width <= 0 then
      col = col - width - 2
    end

    win_set_config(win, { relative = "editor", row = row, col = col })
  end)

  return "<MouseMove>"
end

map({ "", "i" }, "<MouseMove>", update_float, { expr = true })

vim.api.nvim_create_autocmd("WinClosed", {
  pattern = "inspector",
  callback = function()
    win = nil
    vim.o.mousemoveevent = uses_mousemoveevent
  end,
})

-- require("which-key").add {
--   {
--     mode = "n",
--     { "<leader>iw", inspect_in_split, desc = "[I]nspect word", icon = "" },
--     { "<leader>if", inspect_in_float, desc = "[I]nspect in float", icon = "" },
--   },
-- }

vim.keymap.set("n", "<leader>iw", inspect_in_split, { noremap = true })
vim.keymap.set("n", "<leader>if", inspect_in_float, { noremap = true })
