local M = {}

local color = {
  fg = "#bababa",
  bg = "#323838",
  bg2 = "#363636",

  comment = "#707070",
  nontext = "#4f4f4f",

  -- keyword: const let local public function, bracket
  keyword = "#cc7b7e",
  -- literal: 0, nil, true, false, ""
  literal = "#84995e",
  -- function: def, call
  func = "#44a189",
  -- param
  param = "#b381b4",
  -- user identifier: type, variable
  user = "#119fba",
  -- filed
  field = "#b58959",
}

function M.setup()
  vim.o.background = "dark"
  vim.cmd.highlight "clear"
  vim.g.colors_name = "fuga"

  vim.api.nvim_set_hl(0, "Normal", { fg = color.fg, bg = color.bg })
  vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = color.fg, bg = color.bg })
  vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
  vim.api.nvim_set_hl(0, "NonText", { fg = color.nontext })

  vim.api.nvim_set_hl(0, "FoldColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "LineNr", { bg = color.bg2 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = color.bg2 })

  vim.api.nvim_set_hl(0, "IncSearch", { reverse = true })
  vim.api.nvim_set_hl(0, "Search", { reverse = true, underline = true })
  vim.api.nvim_set_hl(0, "WildMenu", { reverse = true })

  --
  -- syntax
  --
  vim.api.nvim_set_hl(0, "Statement", { fg = color.keyword })
  vim.api.nvim_set_hl(0, "@string.lua", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@boolean.lua", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@field.lua", { fg = color.field })
  vim.api.nvim_set_hl(0, "@variable.lua", { fg = color.user })
  vim.api.nvim_set_hl(0, "@function.lua", { fg = color.func })
  vim.api.nvim_set_hl(0, "@function.call.lua", { fg = color.func })
  vim.api.nvim_set_hl(0, "@parameter.lua", { fg = color.param })
  vim.api.nvim_set_hl(0, "@function.builtin.lua", { fg = color.func })
  vim.api.nvim_set_hl(0, "@constant.builtin.lua", { fg = color.literal })
  vim.api.nvim_set_hl(0, "@namespace.builtin.lua", { fg = color.user })

  vim.api.nvim_set_hl(0, "Special", { fg = color.fg })
  vim.api.nvim_set_hl(0, "Comment", { fg = color.comment })

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
  package.loaded.colorizer = nil
  require("fuga").setup()
  require("colorizer").setup()
  vim.cmd [[colorscheme fuga]]
  vim.cmd "ColorizerAttachToBuffer"
end

return M
