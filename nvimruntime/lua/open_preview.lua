local api = vim.api
local validate = vim.validate

---Returns true if the line corresponds to a Markdown thematic break.
---@param line string
---@return boolean
local function is_separator_line(line)
  return line and line:match "^ ? ? ?%-%-%-+%s*$"
end

---Returns true if the line is empty or only contains whitespace.
---@param line string
---@return boolean
local function is_blank_line(line)
  return line and line:match "^%s*$"
end

--- Closes the preview window
---
---@param winnr integer window id of preview window
---@param bufnrs table? optional list of ignored buffers
local function close_preview_window(winnr, bufnrs)
  vim.schedule(function()
    -- exit if we are in one of ignored buffers
    if bufnrs and vim.list_contains(bufnrs, api.nvim_get_current_buf()) then
      return
    end

    local augroup = "preview_window_" .. winnr
    pcall(api.nvim_del_augroup_by_name, augroup)
    pcall(api.nvim_win_close, winnr, true)
  end)
end

--- Creates autocommands to close a preview window when events happen.
---
---@param events table list of events
---@param winnr integer window id of preview window
---@param bufnrs table list of buffers where the preview window will remain visible
---@see autocmd-events
local function close_preview_autocmd(events, winnr, bufnrs)
  local augroup = api.nvim_create_augroup("preview_window_" .. winnr, {
    clear = true,
  })

  -- close the preview window when entered a buffer that is not
  -- the floating window buffer or the buffer that spawned it
  api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    callback = function()
      close_preview_window(winnr, bufnrs)
    end,
  })

  if #events > 0 then
    api.nvim_create_autocmd(events, {
      group = augroup,
      buffer = bufnrs[2],
      callback = function()
        close_preview_window(winnr)
      end,
    })
  end
end

local function find_window_by_var(name, value)
  for _, win in ipairs(api.nvim_list_wins()) do
    if vim.w[win][name] == value then
      return win
    end
  end
end

---Replaces separator lines by the given divider and removing surrounding blank lines.
---@param contents string[]
---@param divider string
---@return string[]
local function replace_separators(contents, divider)
  local trimmed = {}
  local l = 1
  while l <= #contents do
    local line = contents[l]
    if is_separator_line(line) then
      if l > 1 and is_blank_line(contents[l - 1]) then
        table.remove(trimmed)
      end
      table.insert(trimmed, divider)
      if is_blank_line(contents[l + 1]) then
        l = l + 1
      end
    else
      table.insert(trimmed, line)
    end
    l = l + 1
  end

  return trimmed
end

---Collapses successive blank lines in the input table into a single one.
---@param contents string[]
---@return string[]
local function collapse_blank_lines(contents)
  local collapsed = {}
  local l = 1
  while l <= #contents do
    local line = contents[l]
    if is_blank_line(line) then
      while is_blank_line(contents[l + 1]) do
        l = l + 1
      end
    end
    table.insert(collapsed, line)
    l = l + 1
  end
  return collapsed
end

--- Normalizes Markdown input to a canonical form.
---
--- The returned Markdown adheres to the GitHub Flavored Markdown (GFM)
--- specification.
---
--- The following transformations are made:
---
---   1. Carriage returns ('\r') and empty lines at the beginning and end are removed
---   2. Successive empty lines are collapsed into a single empty line
---   3. Thematic breaks are expanded to the given width
---
---@private
---@param contents string[]
---@param opts? vim.lsp.util._normalize_markdown.Opts
---@return string[] table of lines containing normalized Markdown
---@see https://github.github.com/gfm
local function _normalize_markdown(contents, opts)
  validate("contents", contents, "table")
  validate("opts", opts, "table", true)
  opts = opts or {}

  -- 1. Carriage returns are removed
  contents = vim.split(table.concat(contents, "\n"):gsub("\r", ""), "\n", { trimempty = true })

  -- 2. Successive empty lines are collapsed into a single empty line
  contents = collapse_blank_lines(contents)

  -- 3. Thematic breaks are expanded to the given width
  local divider = string.rep("─", opts.width or 80)
  contents = replace_separators(contents, divider)

  return contents
end

--- @param border string|(string|[string,string])[]
local function border_error(border)
  error(string.format("invalid floating preview border: %s. :help vim.api.nvim_open_win()", vim.inspect(border)), 2)
end

local default_border = {
  { "",  "NormalFloat" },
  { "",  "NormalFloat" },
  { "",  "NormalFloat" },
  { " ", "NormalFloat" },
  { "",  "NormalFloat" },
  { "",  "NormalFloat" },
  { "",  "NormalFloat" },
  { " ", "NormalFloat" },
}

local border_size = {
  none = { 0, 0 },
  single = { 2, 2 },
  double = { 2, 2 },
  rounded = { 2, 2 },
  solid = { 2, 2 },
  shadow = { 1, 1 },
}

--- Check the border given by opts or the default border for the additional
--- size it adds to a float.
--- @param opts? {border:string|(string|[string,string])[]}
--- @return integer height
--- @return integer width
local function get_border_size(opts)
  local border = opts and opts.border or default_border

  if type(border) == "string" then
    if not border_size[border] then
      border_error(border)
    end
    return unpack(border_size[border])
  end

  if 8 % #border ~= 0 then
    border_error(border)
  end

  --- @param id integer
  --- @return string
  local function elem(id)
    id = (id - 1) % #border + 1
    local e = border[id]
    if type(e) == "table" then
      -- border specified as a table of <character, highlight group>
      return e[1]
    elseif type(e) == "string" then
      -- border specified as a list of border characters
      return e
    end
    --- @diagnostic disable-next-line:missing-return
    border_error(border)
  end

  --- @param e string
  local function border_height(e)
    return #e > 0 and 1 or 0
  end

  local top, bottom = elem(2), elem(6)
  local height = border_height(top) + border_height(bottom)

  local right, left = elem(4), elem(8)
  local width = vim.fn.strdisplaywidth(right) + vim.fn.strdisplaywidth(left)

  return height, width
end

--- Creates a table with sensible default options for a floating window. The
--- table can be passed to |nvim_open_win()|.
---
---@param width integer window width (in character cells)
---@param height integer window height (in character cells)
---@param opts? vim.lsp.util.open_floating_preview.Opts
---@return vim.api.keyset.win_config
local function make_floating_popup_options(width, height, opts)
  validate("opts", opts, "table", true)
  opts = opts or {}
  validate("opts.offset_x", opts.offset_x, "number", true)
  validate("opts.offset_y", opts.offset_y, "number", true)

  local anchor = ""

  local lines_above = opts.relative == "mouse" and vim.fn.getmousepos().line - 1 or vim.fn.winline() - 1
  local lines_below = vim.fn.winheight(0) - lines_above

  local anchor_bias = opts.anchor_bias or "auto"

  local anchor_below --- @type boolean?

  if anchor_bias == "below" then
    anchor_below = (lines_below > lines_above) or (height <= lines_below)
  elseif anchor_bias == "above" then
    local anchor_above = (lines_above > lines_below) or (height <= lines_above)
    anchor_below = not anchor_above
  else
    anchor_below = lines_below > lines_above
  end

  local border_height = get_border_size(opts)
  local row, col --- @type integer?, integer?
  if anchor_below then
    anchor = anchor .. "N"
    height = math.max(math.min(lines_below - border_height, height), 0)
    row = 1
  else
    anchor = anchor .. "S"
    height = math.max(math.min(lines_above - border_height, height), 0)
    row = 0
  end

  local wincol = opts.relative == "mouse" and vim.fn.getmousepos().column or vim.fn.wincol()

  if wincol + width + (opts.offset_x or 0) <= vim.o.columns then
    anchor = anchor .. "W"
    col = 0
  else
    anchor = anchor .. "E"
    col = 1
  end

  local title = (opts.border and opts.title) and opts.title or nil
  local title_pos --- @type 'left'|'center'|'right'?

  if title then
    title_pos = opts.title_pos or "center"
  end

  return {
    anchor = anchor,
    col = col + (opts.offset_x or 0),
    height = height,
    focusable = opts.focusable,
    relative = opts.relative == "mouse" and "mouse" or "cursor",
    row = row + (opts.offset_y or 0),
    style = "minimal",
    width = width,
    border = opts.border or default_border,
    zindex = opts.zindex or 50,
    title = title,
    title_pos = title_pos,
  }
end

---@private
--- Computes size of float needed to show contents (with optional wrapping)
---
---@param contents string[] of lines to show in window
---@param opts? vim.lsp.util.open_floating_preview.Opts
---@return integer width size of float
---@return integer height size of float
local function _make_floating_popup_size(contents, opts)
  validate("contents", contents, "table")
  validate("opts", opts, "table", true)
  opts = opts or {}

  local width = opts.width
  local height = opts.height
  local wrap_at = opts.wrap_at
  local max_width = opts.max_width
  local max_height = opts.max_height
  local line_widths = {} --- @type table<integer,integer>

  if not width then
    width = 0
    for i, line in ipairs(contents) do
      -- TODO(ashkan) use nvim_strdisplaywidth if/when that is introduced.
      line_widths[i] = vim.fn.strdisplaywidth(line:gsub("%z", "\n"))
      width = math.max(line_widths[i], width)
    end
  end

  local _, border_width = get_border_size(opts)
  local screen_width = api.nvim_win_get_width(0)
  width = math.min(width, screen_width)

  -- make sure borders are always inside the screen
  width = math.min(width, screen_width - border_width)

  if wrap_at then
    wrap_at = math.min(wrap_at, width)
  end

  if max_width then
    width = math.min(width, max_width)
    wrap_at = math.min(wrap_at or max_width, max_width)
  end

  if not height then
    height = #contents
    if wrap_at and width >= wrap_at then
      height = 0
      if vim.tbl_isempty(line_widths) then
        for _, line in ipairs(contents) do
          local line_width = vim.fn.strdisplaywidth(line:gsub("%z", "\n"))
          height = height + math.ceil(line_width / wrap_at)
        end
      else
        for i = 1, #contents do
          height = height + math.max(1, math.ceil(line_widths[i] / wrap_at))
        end
      end
    end
  end
  if max_height then
    height = math.min(height, max_height)
  end

  return width, height
end

-- lsp.util.open_floating_preview
local function open_preview(contents, syntax)
  validate("contents", contents, "table")
  validate("syntax", syntax, "string", true)

  local opts = {
    border = "rounded",
    focus_id = vim.lsp.protocol.Methods.textDocument_hover,
    wrap = false,
    focus = false,
    close_events = { "CursorMoved", "CursorMovedI", "InsertCharPre" },
  }

  local bufnr = api.nvim_get_current_buf()

  local floating_winnr = opts._update_win

  -- Create/get the buffer
  local floating_bufnr --- @type integer
  if floating_winnr then
    floating_bufnr = api.nvim_win_get_buf(floating_winnr)
  else
    -- check if this popup is focusable and we need to focus
    if opts.focus_id and opts.focusable ~= false and opts.focus then
      -- Go back to previous window if we are in a focusable one
      local current_winnr = api.nvim_get_current_win()
      if vim.w[current_winnr][opts.focus_id] then
        api.nvim_command "wincmd p"
        return bufnr, current_winnr
      end
      do
        local win = find_window_by_var(opts.focus_id, bufnr)
        if win and api.nvim_win_is_valid(win) and vim.fn.pumvisible() == 0 then
          -- focus and return the existing buf, win
          api.nvim_set_current_win(win)
          api.nvim_command "stopinsert"
          return api.nvim_win_get_buf(win), win
        end
      end
    end

    -- check if another floating preview already exists for this buffer
    -- and close it if needed
    local existing_float = vim.b[bufnr].lsp_floating_preview
    if existing_float and api.nvim_win_is_valid(existing_float) then
      api.nvim_win_close(existing_float, true)
    end
    floating_bufnr = api.nvim_create_buf(false, true)
  end

  -- Set up the contents, using treesitter for markdown
  local do_stylize = syntax == "markdown" and vim.g.syntax_on ~= nil

  if do_stylize then
    local width = _make_floating_popup_size(contents, opts)
    contents = _normalize_markdown(contents, { width = width })
    vim.bo[floating_bufnr].filetype = "markdown"
    vim.treesitter.start(floating_bufnr)
  else
    -- Clean up input: trim empty lines
    contents = vim.split(table.concat(contents, "\n"), "\n", { trimempty = true })

    if syntax then
      vim.bo[floating_bufnr].syntax = syntax
    end
  end

  vim.bo[floating_bufnr].modifiable = true
  api.nvim_buf_set_lines(floating_bufnr, 0, -1, false, contents)

  if floating_winnr then
    api.nvim_win_set_config(floating_winnr, {
      border = opts.border,
      title = opts.title,
    })
  else
    -- Compute size of float needed to show (wrapped) lines
    if opts.wrap then
      opts.wrap_at = opts.wrap_at or api.nvim_win_get_width(0)
    else
      opts.wrap_at = nil
    end

    -- TODO(lewis6991): These function assume the current window to determine options,
    -- therefore it won't work for opts._update_win and the current window if the floating
    -- window
    local width, height = _make_floating_popup_size(contents, opts)
    local float_option = make_floating_popup_options(width, height, opts)

    floating_winnr = api.nvim_open_win(floating_bufnr, false, float_option)

    api.nvim_buf_set_keymap(
      floating_bufnr,
      "n",
      "q",
      "<cmd>bdelete<cr>",
      { silent = true, noremap = true, nowait = true }
    )
    close_preview_autocmd(opts.close_events, floating_winnr, { floating_bufnr, bufnr })

    -- save focus_id
    if opts.focus_id then
      api.nvim_win_set_var(floating_winnr, opts.focus_id, bufnr)
    end
    api.nvim_buf_set_var(bufnr, "lsp_floating_preview", floating_winnr)
  end

  local augroup_name = ("closing_floating_preview_%d"):format(floating_winnr)
  local ok = pcall(api.nvim_get_autocmds, { group = augroup_name, pattern = tostring(floating_winnr) })
  if not ok then
    api.nvim_create_autocmd("WinClosed", {
      group = api.nvim_create_augroup(augroup_name, {}),
      pattern = tostring(floating_winnr),
      callback = function()
        if api.nvim_buf_is_valid(bufnr) then
          vim.b[bufnr].lsp_floating_preview = nil
        end
        api.nvim_del_augroup_by_name(augroup_name)
      end,
    })
  end

  if do_stylize then
    vim.wo[floating_winnr].conceallevel = 2
  end
  vim.wo[floating_winnr].foldenable = false  -- Disable folding.
  vim.wo[floating_winnr].wrap = opts.wrap    -- Soft wrapping.
  vim.wo[floating_winnr].breakindent = true  -- Slightly better list presentation.
  vim.wo[floating_winnr].smoothscroll = true -- Scroll by screen-line instead of buffer-line.

  vim.bo[floating_bufnr].modifiable = false
  vim.bo[floating_bufnr].bufhidden = "wipe"

  return floating_bufnr, floating_winnr
end

return open_preview
