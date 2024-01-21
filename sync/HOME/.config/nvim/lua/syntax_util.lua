local M = {}

local function hl_clear(name)
  -- vim.api.nvim_set_hl(0, name, { link = "Unknown" })
  vim.api.nvim_set_hl(0, name, {})
end

function M.clear_syntax_link()
  -- vim.api.nvim_set_hl(0, "Unknown", { force = true, fg = "#FF00FF" })
  vim.api.nvim_set_hl(0, "Conceal", { link = "NonText" })
  vim.api.nvim_set_hl(0, "@conceal", { link = "NonText" })

  -- Keyword
  -- hl_clear "Statement"
  -- hl_clear "Keyword"
  -- hl_clear "Operator"
  -- hl_clear "Conditional"
  vim.api.nvim_set_hl(0, "Type", { link = "Statement" })
  vim.api.nvim_set_hl(0, "Special", { link = "Statement" })
  vim.api.nvim_set_hl(0, "PreProc", { link = "Statement" })

  -- Literal
  -- hl_clear "String"
  vim.api.nvim_set_hl(0, "@boolean", { link = "String" })
  vim.api.nvim_set_hl(0, "@number", { link = "String" })

  -- Identifier
  -- hl_clear "Identifier"
  vim.api.nvim_set_hl(0, "Constant", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "Function", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@function", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@function.builtin", { link = "Identifier" })

  vim.api.nvim_set_hl(0, "@punctuation.bracket.lua", { link = "Operator" })
  vim.api.nvim_set_hl(0, "@field.lua", { link = "Debug" })
  vim.api.nvim_set_hl(0, "@Constant.lua", { link = "Constant" })

  vim.api.nvim_set_hl(0, "@type.typescript", { link = "Identifier" })

  vim.api.nvim_set_hl(0, "@tag.astro", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@type.astro", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@tag.attribute.astro", { link = "Debug" })

  hl_clear "@text.uri"
end

return M
