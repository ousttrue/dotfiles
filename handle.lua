for k, v in pairs(vim.lsp.handlers) do
  print(k, v)
end

local function on_symbol(...)
  print({ ... })
end

vim.lsp.handlers["textDocument/documentSymbol"] = on_symbol

