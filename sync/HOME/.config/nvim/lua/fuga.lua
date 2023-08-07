local M = {}

local c = {
  asagao = "#2663a4",
  ajisai = "#5373ae",
  tsuyukusa = "#3b91c2",
  konpeki = "#219dd0",
  amairo = "#4dbde3",
  tsukiyo = "#407587",
  kujaku = "#1d9ea3",
  shinkai = "#6c88af",
  syoro = "#388679",
  shinryoku = "#13815e",
  chikurin = "#a4b974",
  fuyusyogun = "#6f8696",
  kirisame = "#828083",
  takessumi = "#4e4e4e",
  tsutsuji = "#d6336c",
  kosumosu = "#ef829f",
  momiji = "#de5743",
  muraskishikibu = "#6c509a",
  yamabudo = "#8d387c",
  yuyake = "#f9983a",
  fuyugaki = "#f06e3a",
  inaho = "#9b7939",
  tsukushi = "#8c6663",
  yamaguri = "#56514e",
}

local highlight = {
  ColorColumn = { fg = c.yamaguri, bg = c.momiji },
  Cursor = { fg = c.takessumi },
  Directory = { fg = c.tsuyukusa },
  ErrorMsg = { fg = "white", bg = c.kosumosu },
  WinSeparator = { fg = c.shinryoku, bg = c.chikurin },
  Folded = { fg = c.yamabudo, bg = "LightGrey" },
  FoldColumn = { fg = c.yamabudo, bg = "LightGrey" },
  SignColumn = { fg = c.tsukiyo, bg = "white" },
  LineNr = { fg = c.amairo, bold = true },
  CursorLineNr = { fg = c.tsutsuji, bold = true },
  MatchParen = { fg = "white", bg = c.muraskishikibu },
  MoreMsg = { fg = c.shinryoku },
  NonText = { fg = c.muraskishikibu, bold = true },
  Normal = { fg = c.tsukiyo, bg = "white" },
  Pmenu = { fg = "white", bg = c.ajisai },
  PmenuSel = { fg = "white", bg = c.konpeki },
  Question = { fg = c.shinryoku },
  Search = { fg = c.tsukiyo, bg = c.kosumosu },
  StatusLine = { fg = "white", bg = c.shinkai },
  StatusLineNC = { fg = "black", bg = c.fuyusyogun },
  TabLine = { fg = c.shinkai },
  Title = { fg = c.yamabudo, bold = true },
  Visual = { fg = c.yuyake, bg = c.fuyusyogun },
  WarningMsg = { fg = c.tsutsuji },
  --
  Comment = { fg = c.syoro },
  Constant = { fg = c.kujaku },
  Identifier = { fg = c.asagao },
  Statement = { fg = c.takessumi },
  PreProc = { fg = c.kosumosu },
  Type = { fg = c.fuyugaki },
  Special = { fg = c.inaho },
  Underlined = { fg = c.ajisai, underline = true },
  Error = { fg = c.yamabudo },
  Todo = { fg = c.yuyake },
}

local function set_hl(tbl)
  for group, conf in pairs(tbl) do
    vim.api.nvim_set_hl(0, group, conf)
  end
end

function M.setup()
  vim.g.colors_name = "fuga"
  -- vim.g.colors_name = "colorshizuku"

  -- print(vim.g.colors_name)
  if vim.fn.exists "syntax_on" then
    vim.cmd "syntax reset"
  end
  vim.cmd.highlight "clear"
  vim.o.background = "dark"
  -- vim.o.background = "light"
  -- vim.g.terminal_color_0 = "#123456"
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#000000", bg = "#ffffff" })

  -- set_hl(highlight)
  -- vim.cmd "hi clear"
  -- vim.g.colors_name = ""
  -- vim.cmd [[colorscheme fuga]]
  --
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
  vim.cmd [[colorscheme fuga]]
end

return M
