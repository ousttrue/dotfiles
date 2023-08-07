local dot = require "dot"

local M = {}

local win_color = {
  bg = "#00030f",
  bg2 = "#050505",
  comment = "#37433b",
  nontext = "#262626",

  -- literal: 0, nil, true, false, ""
  -- メイン
  literal = "#5ad076",

  -- keyword: const let local public function, bracket
  -- 地味
  keyword = "#3d3678",
  -- user identifier: type, variable
  -- 濃い
  user = "#147fb7",
  -- filed
  -- 中
  field = "#297a58",
  -- function: def, call
  -- 薄い
  func = "#8be1a7",
}

local wsl_color = {
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

local color = {}
if dot.is_wsl then
  color = wsl_color
else
  color = win_color
end

function M.setup()
  vim.o.background = "dark"
  vim.cmd.highlight "clear"
  vim.g.colors_name = "fuga"

  vim.api.nvim_set_hl(0, "Normal", { fg = color.literal, bg = color.bg })
  vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = color.literal, bg = color.bg })
  vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
  vim.api.nvim_set_hl(0, "NonText", { fg = color.nontext })

  vim.api.nvim_set_hl(0, "FoldColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "LineNr", { fg = color.nontext, bg = color.bg2 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = color.bg2 })

  vim.api.nvim_set_hl(0, "IncSearch", { reverse = true })
  vim.api.nvim_set_hl(0, "Search", { reverse = true, underline = true })
  vim.api.nvim_set_hl(0, "WildMenu", { reverse = true })

  --
  -- syntax
  --
  vim.api.nvim_set_hl(0, "Special", { fg = "#FF00FF" })
  vim.api.nvim_set_hl(0, "Statement", { fg = "#FF00FF" })
  vim.api.nvim_set_hl(0, "Constant", { fg = "#FF00FF" })
  vim.api.nvim_set_hl(0, "Comment", { fg = color.comment })

  vim.api.nvim_set_hl(0, "@string.lua", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@boolean.lua", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@field.lua", { fg = color.field })
  vim.api.nvim_set_hl(0, "@variable.lua", { fg = color.user })
  vim.api.nvim_set_hl(0, "@parameter.lua", { fg = color.user })
  vim.api.nvim_set_hl(0, "@function.lua", { fg = color.func })
  vim.api.nvim_set_hl(0, "@function.call.lua", { fg = color.func })
  vim.api.nvim_set_hl(0, "@function.builtin.lua", { fg = color.func })
  vim.api.nvim_set_hl(0, "@constant.builtin.lua", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@number.lua", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@namespace.builtin.lua", { fg = color.user })
  vim.api.nvim_set_hl(0, "@constant.lua", { fg = color.user })
  vim.api.nvim_set_hl(0, "@punctuation.bracket.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.return.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.function.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.operator.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@conditional.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@operator.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@constructor.lua", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@repeat.lua", { fg = color.keyword })

  --
  -- for debug
  --
  vim.api.nvim_set_keymap("n", "gh", ":Inspect<CR>", {})

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
