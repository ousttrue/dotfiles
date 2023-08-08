local dot = require "dot"

local M = {}

local win_color = {
  bg = "#00030f",
  comment = "#4e5f54",
  bg2 = "#0f100c",
  nontext = "#382f00",

  -- メイン
  -- user identifier: type, variable
  user = "#ebc048",

  -- 地味
  -- keyword: const let local public function, bracket
  keyword = "#b62a77",
  -- 濃い
  -- literal: 0, nil, true, false, ""
  literal = "#44544b",
  -- 中
  -- filed
  field = "#477284",
  -- 薄い
  -- function: def, call
  func = "#8ea397",
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

local lin_color = {
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

local color = {}
local sys = dot.get_system()
if sys == "wsl" then
  color = wsl_color
elseif sys == "linux" then
  color = lin_color
else
  color = win_color
end

function M.setup()
  if sys == "linux" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end

  vim.cmd.highlight "clear"
  vim.g.colors_name = "fuga"

  vim.api.nvim_set_hl(0, "Normal", { fg = color.literal, bg = color.bg })
  vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = color.literal, bg = color.bg })
  vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
  vim.api.nvim_set_hl(0, "NonText", { fg = color.nontext })
  vim.api.nvim_set_hl(0, "Directory", { fg = color.keyword })

  vim.api.nvim_set_hl(0, "FoldColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "LineNr", { fg = color.nontext, bg = color.bg2 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = color.bg2 })

  vim.api.nvim_set_hl(0, "IncSearch", { reverse = true })
  vim.api.nvim_set_hl(0, "Search", { reverse = true, underline = true })
  vim.api.nvim_set_hl(0, "WildMenu", { reverse = true })
  vim.api.nvim_set_hl(0, "WildMenu", { reverse = true })

  vim.api.nvim_set_hl(0, "Folded", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "Visual", { bg = color.bg2 })

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

  vim.api.nvim_set_hl(0, "@string.nu", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@boolean.nu", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@field.nu", { fg = color.field })
  vim.api.nvim_set_hl(0, "@variable.nu", { fg = color.user })
  vim.api.nvim_set_hl(0, "@parameter.nu", { fg = color.user })
  vim.api.nvim_set_hl(0, "@function.nu", { fg = color.func })
  vim.api.nvim_set_hl(0, "@function.call.nu", { fg = color.func })
  vim.api.nvim_set_hl(0, "@function.builtin.nu", { fg = color.func })
  vim.api.nvim_set_hl(0, "@constant.builtin.nu", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@number.nu", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@namespace.builtin.nu", { fg = color.user })
  vim.api.nvim_set_hl(0, "@constant.nu", { fg = color.user })
  vim.api.nvim_set_hl(0, "@punctuation.bracket.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.return.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.function.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@keyword.operator.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@conditional.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@operator.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@constructor.nu", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@repeat.nu", { fg = color.keyword })

  vim.api.nvim_set_hl(0, "@property.nu", { fg = color.field })
  vim.api.nvim_set_hl(0, "@type.nu", { fg = color.user })

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
