# none-ls

https://github.com/nvimtools/none-ls.nvim

```lua
local config = {
    name = "null-ls",
    root_dir = root_dir,
     cmd = require("null-ls.rpc").start, -- pass callback to create rpc client
 }

id = lsp.start(config)
```

```lua
---@param dispatchers vim.lsp.rpc.Dispatchers
---@return vim.lsp.rpc.PublicClient
M.start = function(dispatchers)
    ---@param method vim.lsp.protocol.Method|string LSP method name.
    ---@param params table? LSP request params.
    ---@param callback fun(err: lsp.ResponseError|nil, result: any)
    ---@param notify_callback fun(message_id: integer)?
    local function request(method, params, callback, notify_callback)
    end

    ---@param method string LSP method name.
    ---@param params table? LSP request params.
    local function notify(method, params)
    end

    return {
        request = request,
        notify = notify,
        is_closing = function()
            return stopped
        end,
        terminate = function()
            cache._reset()
            stopped = true
        end,
    }
end
```

# null-ls

`archived` [GitHub - jose-elias-alvarez/null-ls.nvim: Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.](https://github.com/jose-elias-alvarez/null-ls.nvim)

- [とりあえずnone-ls.nvimでよくないか？ / null-ls.nvimの保守的代替 | 点と接線。](https://riq0h.jp/2023/11/05/085628/)
- [Nvim lsp: set up null-ls for beginners | SmartTech101](https://smarttech101.com/nvim-lsp-set-up-null-ls-for-beginners/)
- [[Neovim]null_ls.nvimを用いてNeovim上でLinter/Formtterを動かす🌵](https://zenn.dev/fukakusa_kadoma/articles/32884de923fca1)
- [【Neovim】null-lsを導入してElixirのリンターcredoの実行結果を表示する](https://zenn.dev/koga1020/articles/583be482690a3c)
