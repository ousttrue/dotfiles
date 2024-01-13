local M = {}
M.diff_color = {
  add = "#092e18",
  cahnge = "#9c9407",
  delete = "#9c0707",
}

M.win_color = {
  bg = "#00030f",
  comment = "#38443b",
  bg2 = "#0f100c",
  nontext = "#382f00",

  -- メイン
  -- top level symbol: type, variable, function
  user = "#7cbd2f",

  -- 地味
  -- keyword: const let local public function, bracket, def
  keyword = "#0188ab",
  -- 濃い
  -- literal: 0, nil, true, false, ""
  literal = "#44544b",
  -- 中
  -- filed, property, method
  field = "#477284",
  -- 薄い
  -- function: def, call
  func = "#8ea397",
}

M.wsl_color = {
  bg = "#0f0000",
  bg2 = "#050505",
  comment = "#684545",
  nontext = "#262626",

  -- literal: 0, nil, true, false, ""
  -- メイン
  literal = "#f69ad1",

  -- keyword: const let local public function, bracket
  -- 地味
  keyword = "#773704",
  -- user identifier: type, variable
  -- 濃い
  user = "#7a1e2c",
  -- filed
  -- 中
  field = "#b55e21",
  -- function: def, call
  -- 薄い
  func = "#fd9e3c",
}

M.lin_color = {
  bg = "#e7f6fa",
  bg2 = "#def0f9",
  comment = "#7db2c7",
  nontext = "#bfdeeb",

  -- literal: 0, nil, true, false, ""
  -- メイン
  literal = "#65bfc5",

  -- keyword: const let local public function, bracket
  -- 地味
  keyword = "#9da0dd",
  -- user identifier: type, variable
  -- 濃い
  user = "#51afe0",
  -- filed
  -- 中
  field = "#6e97ce",
  -- function: def, call
  -- 薄い
  func = "#917eee",
}

function M.get()
  local dot = require "dot"
  local sys = dot.get_system()

  local color = {}
  if sys == "wsl" then
    color = M.wsl_color
  elseif sys == "linux" then
    color = M.lin_color
  else
    color = M.win_color
  end

  local bg = ""
  if sys == "linux" then
    bg = "light"
  else
    bg = "dark"
  end

  return bg, color, M.diff_color
end

function hl_clear(name)
  -- vim.api.nvim_set_hl(0, name, { link = "Unknown" })
  vim.api.nvim_set_hl(0, name, {})
end

function M.set_unknown()
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

return M

