local M = {}

local function hl_clear(name)
  -- vim.api.nvim_set_hl(0, name, { link = "Unknown" })
  vim.api.nvim_set_hl(0, name, {})
end

function M.clear_syntax_link(ev)
  if ev.match == "habamax" then
    vim.api.nvim_set_hl(0, "MatchParen", { link = "Title" })
    vim.api.nvim_set_hl(0, "VertSplit", { link = "NotifyDEBUGBorder" })
  end
  if vim.o.background == "dark" then
    vim.api.nvim_set_hl(0, "NonText", { fg = "#444444" })
  elseif vim.o.background == "light" then
    vim.api.nvim_set_hl(0, "NonText", { fg = "#cccccc" })
  end

  vim.api.nvim_set_hl(0, "TabLineSel", { link = "CurSearch" })
  vim.api.nvim_set_hl(0, "TabLine", { link = "Comment" })
  hl_clear "TabLineFill"
  hl_clear "StatusLine"
  hl_clear "StatusLineNC"
  hl_clear "PmenuExtra"
  vim.api.nvim_set_hl(0, "BufferCurrentMod", { link = "TabLineSel" })
  hl_clear "BufferVisibleMod"
  hl_clear "BufferInactiveMod"
  -- vim.cmd "syn clear markdownError"

  -- vim.api.nvim_set_hl(0, "Unknown", { force = true, fg = "#FF00FF" })
  vim.api.nvim_set_hl(0, "Conceal", { link = "NonText" })
  vim.api.nvim_set_hl(0, "@conceal", { link = "NonText" })

  vim.api.nvim_set_hl(0, "SignColumn", { bg = "#111111" })
  vim.api.nvim_set_hl(0, "SatelliteCursor", { bg = "#ff0000" })

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
  -- vim.api.nvim_set_hl(0, "@function", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@function.builtin", { link = "Identifier" })

  -- vim.api.nvim_set_hl(0, "@punctuation.special", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@punctuation.bracket.lua", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@field.lua", { link = "Debug" })
  -- vim.api.nvim_set_hl(0, "@variable.member.lua", { link = "Debug" })
  -- vim.api.nvim_set_hl(0, "@Constant.lua", { link = "Constant" })
  -- hl_clear "@function.call.lua"

  -- vim.api.nvim_set_hl(0, "@variable.c", { link = "Title" })
  -- vim.api.nvim_set_hl(0, "@property.c", { link = "Debug" })
  -- vim.api.nvim_set_hl(0, "@type.c", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@type.builtin.c", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@constant.builtin.c", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@type.typescript", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@tag.astro", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@type.astro", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@tag.attribute.astro", { link = "Debug" })

  -- hl_clear "@string.escape.python"

  -- hl_clear "@text.uri"
  -- hl_clear "@lsp.type.enumMember.markdown"

  -- hl_clear "@markup"
  vim.api.nvim_set_hl(0, "@markup.heading", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@markup.heading.2.marker.markdown", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@markup.heading.3.marker.markdown", { link = "Statement" })
  vim.api.nvim_set_hl(0, "@markup.quote", { link = "Comment" })
  -- vim.api.nvim_set_hl(0, "@markup.list.markdown", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@markup.raw.delimiter.markdown", { link = "Comment" })
  vim.api.nvim_set_hl(0, "@markup.link", { link = "String" })
  -- vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { link = "Conceal" })
  -- vim.api.nvim_set_hl(0, "@text.strong.markdown", { link = "String" })
  vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#FFaa00" })
  vim.api.nvim_set_hl(0, "@text.strong", { fg = "#FFaa00" })

  -- hl_clear "@variable.parameter.vimdoc"
  -- vim.api.nvim_set_hl(0, "@markup.link.vimdoc", { link = "Identifier" })

  -- vim.api.nvim_set_hl(0, "@module.cpp", {})
  -- vim.api.nvim_set_hl(0, "@punctuation.delimiter.cpp", {})
  -- vim.api.nvim_set_hl(0, "@punctuation.bracket.cpp", {})
  -- vim.api.nvim_set_hl(0, "@string.escape.cpp", { link = "String" })
  -- vim.api.nvim_set_hl(0, "@constant.builtin.cpp", { link = "String" })
  vim.api.nvim_set_hl(0, "@variable.builtin", { link = "String" })
  vim.api.nvim_set_hl(0, "@markup.heading", { link = "Identifier" })
  -- vim.api.nvim_set_hl(0, "@constructor.cpp", { link = "String" })
  -- vim.api.nvim_set_hl(0, "@lsp.type.macro.cpp", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@conditional.cpp", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@repeat.cpp", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@storageclass.cpp", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "@include.cpp", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@preproc.cpp", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@keyword.import.cpp", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@keyword.directive.cpp", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@keyword.directive.define.cpp", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@keyword.import.c", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@keyword.directive.c", { fg = "#FFaa00" })
  -- vim.api.nvim_set_hl(0, "@keyword.directive.define.c", { fg = "#FFaa00" })

  -- vim.api.nvim_set_hl(0, "@statement", { link = "Statement" })

  --
  -- cmp
  --
  -- gray
  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
  -- blue
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
  -- light blue
  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
  vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
  vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
  -- pink
  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
  -- front
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
  vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
end

return M
