require("nvim-tree").setup({})
local lspconfig = require("lspconfig")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local LUA_SERVER = vim.env.HOME .. "/ghq/github.com/sumneko/lua-language-server/bin/lua-language-server"

local custom_lsp_attach = function(client)
	-- See `:help nvim_buf_set_keymap()` for more information
	vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
	-- ... and other keymappings for LSP

	-- Use LSP as the handler for omnifunc.
	--    See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	--    See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- For plugins with an `on_attach` callback, call them here. For example:
	-- require('completion').on_attach()
end

lspconfig.sumneko_lua.setup({
	cmd = { LUA_SERVER },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
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
})

lspconfig.pylsp.setup({
	on_attach = custom_lsp_attach,
})
