[[nvim]]

- https://gist.github.com/dtr2300/2f867c2b6c051e946ef23f92bd9d1180

```lua
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    local diagnostics = args.data.diagnostics
    vim.print(diagnostics)
  end,
})
```
