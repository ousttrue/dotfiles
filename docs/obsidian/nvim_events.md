[[nvim]]

```lua
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    local diagnostics = args.data.diagnostics
    vim.print(diagnostics)
  end,
})
```
