local PLUGIN_NAME = "tools.myplugin"
local utf8 = require "utf8"

local Highlighter = {}
Highlighter.__index = Highlighter

function Highlighter.new(bufnr, ns)
  local tbl = { _bufnr = bufnr, _ns = ns }
  return setmetatable(tbl, Highlighter)
end

local hl_groups = { "DiffAdd", "DiffChange", "DiffDelete" }
function Highlighter.highlight(self, row)
  local s = vim.api.nvim_buf_get_lines(self._bufnr, row, row + 1, true)[1]

  local i = 0
  local j = 0
  while true do
    i, j = string.find(s, "U%+[0-9A-F]+", i) -- find 'next' newline
    if i == nil then
      break
    end

    local codepoint = tonumber(s:sub(i + 2, j), 16)
    -- print(s:sub(i + 2, i + 5), codepoint)
    local ch = utf8.char(codepoint)
    -- print(ch)
    vim.api.nvim_buf_set_extmark(self._bufnr, self._ns, row, i - 1, {
      -- end_line = row + 1,
      end_col = j,
      hl_group = "DiffChange",
      virt_text = { { ch, "DiffAdd" } },
      virt_text_pos = "overlay",
      -- hl_eol = true,
      ephemeral = true,
    })
    i = j + 1
  end
end

return {
  setup = function()
    vim.keymap.set("n", "gt", function()
      require(PLUGIN_NAME).enable()
    end, { noremap = true })

    vim.keymap.set("n", "gT", function()
      require(PLUGIN_NAME).disable()
    end, { noremap = true })
  end,

  enable = function()
    local highlighters = {}
    local ns = vim.api.nvim_create_namespace(PLUGIN_NAME)
    vim.api.nvim_set_decoration_provider(ns, {
      on_win = function(_, _, bufnr)
        return highlighters[bufnr] ~= nil
      end,
      on_line = function(_, _, bufnr, row)
        highlighters[bufnr]:highlight(row)
        return true
      end,
    })

    local bufnr = vim.api.nvim_get_current_buf()
    -- local bufnr = vim.api.nvim_create_buf(false, true)
    -- vim.cmd("vsplit | buffer " .. bufnr)
    -- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn["repeat"]({ "" }, 100000))
    highlighters[bufnr] = Highlighter.new(bufnr, ns)
  end,

  disable = function()
    local ns = vim.api.nvim_create_namespace(PLUGIN_NAME)
    vim.api.nvim_set_decoration_provider(ns, {})
  end,
}
