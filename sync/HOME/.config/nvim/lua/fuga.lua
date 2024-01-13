local M = {}

---@param group_name string
---@param val table
local function hl(group_name, val)
  val.force = true
  vim.api.nvim_set_hl(0, group_name, val)
end

local dark = {
  fg = "#0a8a11",
  comment = "#666666",
  non = "#303030",
  bg_nc = "#140c36",
  bg = "#000000",

  symbol = "#8605a7",
  literal = "#3165e7",
}

local dark_sample = {
  fg = "#b294bb",
  comment = "#707880",
  non = "#373b41",
  bg_nc = "#282a2e",
  bg = "#1d1f21",

  symbol = "#cc6666",
  literal = "#81a2be",
}

-- light
local light = {
  fg = "#087a02",
  comment = "#8b9e8b",
  non = "#b0bfb0",
  bg_nc = "#CCCCCC",
  bg = "#DDDDDD",

  symbol = "#67048a",
  literal = "#143ca4",
}

local light_sample = {
  fg = "#a54242",
  comment = "#cc6666",
  non = "#373b41",
  bg_nc = "#707880",
  bg = "#c5c8c6",

  symbol = "#67048a",
  literal = "#143ca4",
}

function M.setup()
  package.loaded.pallete = nil
  local palette = require "color_palette"
  -- local bg, color, diff = palette.get()
  local bg, color = "light", light
  -- local bg, color = "light", light_sample
  -- local bg, color = "dark", dark
  -- local bg, color = "dark", dark_sample

  vim.cmd.highlight "clear"
  vim.o.background = "dark"
  vim.g.colors_name = "fuga"
  palette.set_unknown()

  hl("Normal", { fg = color.fg, bg = color.bg })
  hl("TabLineSel", { link = "Normal" }) -- active tab

  -- hl("TermCursor", { fg="#FF0000" })
  -- hl("TermCursorNC", { fg="#FF0000" })
  -- hl("Cursor", { fg="#FF0000" })
  -- hl("lCursor", { fg="#FF0000" })
  -- hl("CursorLine", { fg="#FF0000" })
  -- hl("CursorColumn", { fg="#FF0000" })
  -- hl("CursorIM", { fg="#FF0000" })

  hl("NormalNC", { bg = color.bg_nc })
  hl("Search", { link = "NormalNC" })
  hl("Visual", { link = "NormalNC" })

  hl("Focus", { reverse = true })
  hl("CurSearch", { link = "Focus" })

  hl("NonText", { fg = color.non })
  hl("LineNr", { link = "NonText" })
  hl("Conceal", { link = "NonText" })
  hl("@conceal", { link = "NonText" })

  hl("Comment", { fg = color.comment })
  hl("TabLine", { fg = color.comment, bg = color.bg_nc }) -- inactive tab

  hl("Statement", { fg = color.fg })
  hl("Operator", { link = "Statement" })
  hl("Delimiter", { link = "Statement" })

  hl("Literal", { fg = color.literal })
  hl("Special", { link = "Literal" })
  hl("String", { link = "Literal" })
  hl("Title", { link = "Literal" })
  -- fix lua
  hl("@number.lua", { link = "Literal" })
  hl("@boolean.lua", { link = "Literal" })

  hl("Symbol", { fg = color.symbol })
  hl("@variable", { link = "Symbol" })
  hl("Identifier", { link = "Symbol" })
  hl("@text", { link = "Symbol" })

  --
  -- for debug
  --
  vim.api.nvim_set_keymap("n", "gh", ":Inspect<CR>", {})
  vim.cmd [[command! VimSourceHighlightTest :source $VIMRUNTIME/syntax/hitest.vim]]

  vim.cmd [[
augroup fuga_reload
  autocmd!
  autocmd bufWritePost fuga.lua :lua require('fuga').reload()
augroup END
]]
end

function M.reload()
  package.loaded.fuga = nil
  require("fuga").setup()
  vim.schedule(function()
    vim.cmd [[
  colorscheme fuga
  ]]

    package.loaded.ccc = nil
    require("ccc").setup {
      -- Your preferred settings
      -- Example: enable highlighter
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    }
    vim.cmd [[
  CccHighlighterEnable
  ]]
  end)
end

return M
