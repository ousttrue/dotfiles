```lua
vim.opt.expandtab = true
```

効かなくなった。

- https://stackoverflow.com/questions/74132882/why-is-my-configs-expandtab-true-overridden-when-most-files-are-opened

`neovim/share/nvim/runtime/lua/editorconfig.lua:104`

```lua
--- One of `"tab"` or `"space"`. Sets the 'expandtab' option.
function properties.indent_style(bufnr, val, opts)
  assert(val == 'tab' or val == 'space', 'indent_style must be either "tab" or "space"')
  vim.bo[bufnr].expandtab = val == 'space'
  if val == 'tab' and not opts.indent_size then
    vim.bo[bufnr].shiftwidth = 0
    vim.bo[bufnr].softtabstop = 0
  end
end
```

`vim.g.editorconfig = false` で止められる。

https://github.com/NvChad/NvChad/issues/2633
