[[null-ls]]
[[nvim_diagnostics]]

- @2022 `0.7.2` [Neovim+LSPをなるべく簡単な設定で構築する](https://zenn.dev/botamotch/articles/21073d78bc68bf)
- [Nvim documentation: lsp](https://neovim.io/doc/user/lsp.html)
- [Neovimを一瞬でVSCode並みに便利にする - k0kubun's blog](https://k0kubun.hatenablog.com/entry/neovim-lsp)
- @2019 [NeovimのBuiltin LSPを使ってみる - Qiita](https://qiita.com/slin/items/2b43925065de3b9a6d3b)

# manual start

```lua
-- Create an event handler for the FileType autocommand
vim.api.nvim_create_autocmd('FileType', {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = 'python',
  callback = function(ev)
    vim.lsp.start({
      name = 'my-server-name',
      cmd = {'name-of-language-server-executable', '--option', 'arg1', 'arg2'},
      -- Set the "root directory" to the parent directory of the file in the
      -- current buffer (`ev.buf`) that contains either a "setup.py" or a
      -- "pyproject.toml" file. Files that share a root directory will reuse
      -- the connection to the same LSP server.
      root_dir = vim.fs.root(ev.buf, {'setup.py', 'pyproject.toml'}),
    })
  end,
})
```

# version

## 0.8

- `LspAttach` @2023 [Neovim 0.8以降のビルトインLSPについて](https://zenn.dev/ryoppippi/articles/8aeedded34c914)

# border

[[BoxDrawing]]

- [:LspInfo window border - Language Server Protocol (LSP) - Neovim Discourse](https://neovim.discourse.group/t/lspinfo-window-border/1566)
- [neovim - User borders around LSP floating windows - Vi and Vim Stack Exchange](https://vi.stackexchange.com/questions/39074/user-borders-around-lsp-floating-windows)

# nvim-lspconfig

- [GitHub - neovim/nvim-lspconfig: Quickstart configurations for the Nvim LSP client](https://github.com/neovim/nvim-lspconfig)
  - [nvim-lspconfig/server_configurations.md at master · neovim/nvim-lspconfig · GitHub](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

## autostart

```lua
lsp_config.bashls.setup({
    autostart = false,
    ... rest of configuration
})
```

- https://stackoverflow.com/questions/77582090/neovim-start-lsp-only-on-first-insert

# ProjectLocal

- [Project local settings · neovim/nvim-lspconfig Wiki · GitHub](https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings)

# hover

[Neovim LSP Hoverのデザインを変更する](https://zenn.dev/botamotch/scraps/4ce17ce1f311c9)

## quickfix

## virtualtext

## underline

- [Reddit - Dive into anything](https://www.reddit.com/r/neovim/comments/lciqhp/disable_annoying_underline_when_make_errors/)

## gutter

- [LunarVim/init.lua at 359b6fd8e44bc2ad5088aada3f9c037fb85b19af · LunarVim/LunarVim · GitHub](https://github.com/LunarVim/LunarVim/blob/359b6fd8e44bc2ad5088aada3f9c037fb85b19af/lua/lsp/init.lua#L2)

# completion, locationlist, definition, hover...

# mason

- [GitHub - williamboman/mason.nvim: Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.](https://github.com/williamboman/mason.nvim)

## mason-lspconfig

- [GitHub - williamboman/mason-lspconfig.nvim: Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim](https://github.com/williamboman/mason-lspconfig.nvim)

- [nvim-lsp-installerからmason.nvimへ移行する](https://zenn.dev/kawarimidoll/articles/367b78f7740e84)

- @2022 [mason.nvimでFormatter, Linterを自動マッピングする](https://zenn.dev/matcha1024/articles/1a972c6e161ad4)
- [mason.nvimでインストールするLSP, Formatterを管理したい](https://zenn.dev/sakikagr/scraps/a621c775c89b91)
- [Neovim x null-ls x cspellの設定詳解](https://zenn.dev/kawarimidoll/articles/ad35f3dc4a5009)
