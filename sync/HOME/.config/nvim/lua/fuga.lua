local M = {}

---@param group_name string
---@param val table
local function hl(group_name, val)
  val.force = true
  vim.api.nvim_set_hl(0, group_name, val)
end

function hl_clear(name)
  -- vim.api.nvim_set_hl(0, name, { link = "Unknown" })
  vim.api.nvim_set_hl(0, name, {})
end

function set_unknown()
  vim.api.nvim_set_hl(0, "Unknown", { force = true, fg = "#FF00FF" })
  hl_clear "SpecialKey"
  -- hl_clear "TermCursor"
  hl_clear "NonText"
  hl_clear "Directory"
  hl_clear "ErrorMsg"
  hl_clear "Search"
  hl_clear "CurSearch"
  hl_clear "MoreMsg"
  hl_clear "ModeMsg"
  hl_clear "LineNr"
  -- hl_clear "CursorLineNr"
  hl_clear "Question"
  hl_clear "StatusLine"
  hl_clear "StatusLineNC"
  hl_clear "Title"
  hl_clear "Visual"
  hl_clear "WarningMsg"
  hl_clear "Folded"
  hl_clear "DiffAdd"
  hl_clear "DiffChange"
  hl_clear "DiffDelete"
  hl_clear "DiffText"
  hl_clear "SignColumn"
  hl_clear "Conceal"
  hl_clear "SpellBad"
  hl_clear "SpellCap"
  hl_clear "SpellRare"
  hl_clear "SpellLocal"
  hl_clear "Pmenu"
  hl_clear "PmenuSel"
  hl_clear "PmenuThumb"
  hl_clear "TabLineSel"
  -- hl_clear "CursorColumn"
  -- hl_clear "CursorLine"
  hl_clear "ColorColumn"
  hl_clear "QuickFixLine"

  hl_clear "NormalFloat"
  hl_clear "Cursor"
  hl_clear "RedrawDebugNormal"
  hl_clear "Todo"
  hl_clear "Underlined"
  -- hl_clear "lCursor"
  hl_clear "Normal"
  hl_clear "Statement"
  hl_clear "Special"
  hl_clear "DiagnosticError"
  hl_clear "DiagnosticWarn"
  hl_clear "DiagnosticInfo"
  hl_clear "DiagnosticHint"
  hl_clear "DiagnosticOk"
  hl_clear "Comment"
  hl_clear "Identifier"
  hl_clear "String"
  hl_clear "Function"
  hl_clear "FloatShadow"
  hl_clear "FloatShadowThrough"
  hl_clear "MatchParen"
  hl_clear "RedrawDebugClear"
  hl_clear "RedrawDebugComposed"
  hl_clear "RedrawDebugRecompose"
  hl_clear "Error"
  hl_clear "DiagnosticUnderlineError"
  hl_clear "DiagnosticUnderlineWarn"
  hl_clear "DiagnosticUnderlineInfo"
  hl_clear "DiagnosticUnderlineHint"
  hl_clear "DiagnosticUnderlineOk"
  hl_clear "DiagnosticDeprecated"
  hl_clear "NvimInternalError"
end

---@param name string
---@param bg string
---@param color table
function M.setup(name, bg, color)
  vim.cmd.highlight "clear"
  vim.o.background = bg
  vim.g.colors_name = name

  -- clear
  set_unknown()

  hl("Normal", { fg = color.fg, bg = color.bg })

  hl("TabLineSel", { fg = color.symbol, bg = color.bg }) -- active tab
  hl("TabLine", { fg = color.comment, bg = color.non }) -- inactive tab

  hl("NormalNC", { bg = color.non })
  -- TODO: fix TSplayground highlight
  hl("Search", { link = "NormalNC" })
  hl("Visual", { link = "NormalNC" })

  hl("Focus", { fg = color.bg, bg = color.comment })
  hl("MatchParen", { link = "Focus" })
  -- TODO: fix hidden letter under cursor
  hl("CurSearch", { link = "Focus" })

  hl("NonText", { fg = color.non })
  hl("LineNr", { link = "NonText" })
  hl("Conceal", { link = "NonText" })
  hl("@conceal", { link = "NonText" })

  hl("Comment", { fg = color.comment })

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
  hl("@text.uri", { link = "Literal" })
  hl("@text.strong", { link = "Literal" })

  hl("Symbol", { fg = color.symbol })
  hl("@variable", { link = "Symbol" })
  hl("Identifier", { link = "Symbol" })
  hl("@text", { link = "Symbol" })

  hl("DiffAdd", { link = "Literal" })
  hl("DiffDelete", { link = "TabLineSel" })
end

return M
