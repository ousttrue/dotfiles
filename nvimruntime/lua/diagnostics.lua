local open_preview = require "open_preview"

local HOVER_NS = vim.api.nvim_create_namespace "vim_lsp_hover_range"

-- vim.lsp.buf.hover

--- @param params? table
--- @return fun(client: vim.lsp.Client): lsp.TextDocumentPositionParams
local function client_positional_params(params)
  local win = vim.api.nvim_get_current_win()
  return function(client)
    local ret = vim.lsp.util.make_position_params(win, client.offset_encoding)
    if params then
      ret = vim.tbl_extend("force", ret, params)
    end
    return ret
  end
end

---@param bufnr integer
---@param results1 table<integer,lsp.Hover>
---@return string[]
---@return string
local function make_contents(bufnr, results1)
  local format = "markdown"

  local contents = {} --- @type string[]

  local nresults = #vim.tbl_keys(results1)

  for client_id, result in pairs(results1) do
    local client = assert(vim.lsp.get_client_by_id(client_id))
    if nresults > 1 then
      -- Show client name if there are multiple clients
      contents[#contents + 1] = string.format("# %s", client.name)
    end
    if type(result.contents) == "table" and result.contents.kind == "plaintext" then
      if #results1 == 1 then
        format = "plaintext"
        contents = vim.split(result.contents.value or "", "\n", { trimempty = true })
      else
        -- Surround plaintext with ``` to get correct formatting
        contents[#contents + 1] = "```"
        vim.list_extend(contents, vim.split(result.contents.value or "", "\n", { trimempty = true }))
        contents[#contents + 1] = "```"
      end
    else
      vim.list_extend(contents, vim.lsp.util.convert_input_to_markdown_lines(result.contents))
    end
    local range = result.range
    if range then
      local start = range.start
      local end_ = range["end"]
      local start_idx = vim.lsp.util._get_line_byte_from_position(bufnr, start, client.offset_encoding)
      local end_idx = vim.lsp.util._get_line_byte_from_position(bufnr, end_, client.offset_encoding)

      vim.hl.range(
        bufnr,
        HOVER_NS,
        "LspReferenceTarget",
        { start.line, start_idx },
        { end_.line, end_idx },
        { priority = vim.hl.priorities.user }
      )
    end
    contents[#contents + 1] = "---"
  end

  -- Remove last linebreak ('---')
  contents[#contents] = nil

  return contents, format
end

local function on_request(results, ctx)
  local bufnr = assert(ctx.bufnr)
  if vim.api.nvim_get_current_buf() ~= bufnr then
    -- Ignore result since buffer changed. This happens for slow language servers.
    return
  end

  -- Filter errors from results
  local results1 = {} --- @type table<integer,vim.lsp.Hover>

  for client_id, resp in pairs(results) do
    local err, result = resp.err, resp.result
    if err then
      vim.lsp.log.error(err.code, err.message)
    elseif result then
      results1[client_id] = result
    end
  end

  if vim.tbl_isempty(results1) then
    -- if config.silent ~= true then
    --   vim.notify "No information available"
    -- end
    return
  end

  local contents, format = make_contents(bufnr, results1)

  if vim.tbl_isempty(contents) then
    -- if config.silent ~= true then
    --   vim.notify "No information available"
    -- end
    return
  end

  local _, winid = open_preview(contents, format)
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(winid),
    once = true,
    callback = function()
      vim.api.nvim_buf_clear_namespace(bufnr, HOVER_NS, 0, -1)
      return true
    end,
  })
end

local M = {}

function M.setup()
  -- local function on_cursor_hold()
  --   vim.diagnostic.open_float()
  -- end
  -- local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
  -- vim.api.nvim_set_option("updatetime", 500)
  -- vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
  -- vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
  -- https://neovim.io/doc/user/diagnostic.html
  DIAGNOSTIC_CONFIG = {
    severity_sort = true,
    -- underline = true,
    update_in_insert = false,
    virtual_text = false,
    -- virtual_text = {
    --   format = function(diagnostic)
    --     return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    --   end,
    -- },

    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
    },
    float = {
      source = true, -- Or "if_many"
      conig = {
        border = "rounded",
      },
    },
  }
  vim.diagnostic.config(DIAGNOSTIC_CONFIG)

  vim.keymap.set("n", "ga", vim.diagnostic.open_float, { noremap = true })
  -- -- vim.keymap.set("n", "<Leader>e", vim.diagnostic.show_line_diagnostics, { noremap = true })
  -- vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { noremap = true })

  vim.keymap.set("n", "K", function()
    vim.lsp.buf_request_all(0, vim.lsp.protocol.Methods.textDocument_hover, client_positional_params(), on_request)
  end, { noremap = true })
  -- vim.keymap.set("n", "K", ":help <C-r><C-w><CR>", {})
end

return M
