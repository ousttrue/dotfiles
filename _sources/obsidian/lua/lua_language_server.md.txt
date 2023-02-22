[[lua]]

# vscode
- [GitHub - sumneko/vscode-lua: Release lua-language-server for VSCode](https://github.com/sumneko/vscode-lua)
`.vscode/settings.json`
	```json
    "Lua.workspace.library": [
        "${3rd}/lovr/library"
    ],
    "Lua.workspace.userThirdParty": [
        "${workspaceFolder}/.vscode/annotations"
    ],
```

# lspconfig
- [nvim-lspconfig/server_configurations.md at master · neovim/nvim-lspconfig · GitHub](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls)

```lua
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
```

# workspace
## nvim API
[NeoVim API information not working with lua-language-server (sumneko) - Language Server Protocol (LSP) - Neovim Discourse](https://neovim.discourse.group/t/neovim-api-information-not-working-with-lua-language-server-sumneko/2162)

=> [[nvim_cmp]]

# nvim
起動速くするには？
- [FAQ · LuaLS/lua-language-server Wiki · GitHub](https://github.com/LuaLS/lua-language-server/wiki/FAQ#how-can-i-improve-startup-speeds)
 `workspace.ignoreDir`
 
