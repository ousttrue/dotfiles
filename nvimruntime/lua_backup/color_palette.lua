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

return M

