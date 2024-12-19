[Nvim documentation: diagnostic](https://neovim.io/doc/user/diagnostic.html)

# vim.diagnostic.config / vim.diagnostic.Opts

- @2024 [Neovimのdiagnosticの設定を見直す | えいじのサイバー備忘録](https://eiji.page/blog/neovim-diagnostic-config/)
- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization

```lua
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  -- virtual_text = true,
  virtual_text = {
    source = "always",  -- Or "if_many"
  },
  float = {
    source = "always",  -- Or "if_many"
  },
})
```

- @2024 [nvim-lspの作用に少し凝ったカスタマイズを加える旅](https://zenn.dev/vim_jp/articles/c62b397647e3c9)

```lua
vim.diagnostic.config({severity_sort = true})
```

# vim.diagnostic.open_float

```lua
vim.diagnostic.config {
    float = { border = "rounded" },
}
```

https://neovim.discourse.group/t/lsp-diagnostics-how-and-where-to-retrieve-severity-level-to-customise-border-color/1679

# producer

```lua
nvim_create_namespace()
vim.diagnostic.set()
```
