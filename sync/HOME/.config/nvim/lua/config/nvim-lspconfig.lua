local function get_home()
	if vim.fn.has('win32')==1 then
		return vim.env.USERPROFILE
	else
		return vim.env.HOME
	end
end
local function get_suffix()
	if vim.fn.has('win32')==1 then
		return '.exe'
	else
		return ''
	end
end

local M = {}
function M.setup()
  local lspconfig = require "lspconfig"
  --local lsp_status = require "lsp-status"
  -- local aerial = require "aerial"
  -- local symbols_outline = require "symbols-outline"
  -- lsp_status.register_progress()
  local navic = require "nvim-navic"
  local util = require "lspconfig.util"

  ---@diagnostic disable-next-line
  local function on_attach(client, bufnr)
    -- print(vim.inspect(client.server_capabilities))
    vim.diagnostic.config {
      virtual_text = false,
    }
    -- aerial.on_attach(client, bufnr)
    -- lsp_status.on_attach(client)
    -- symbols_outline.open_outline()
    navic.attach(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set({"n", "v"}, "F", vim.lsp.buf.format, { buffer=bufnr, noremap = true })
      -- vim.keymap.set("v", "F", vim.lsp.buf.format, { buffer=bufnr, noremap = true })
    end
  end

  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- for k, v in pairs(lsp_status.capabilities) do
  --   capabilities[k] = v
  -- end
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- print(vim.inspect(capabilities))

  lspconfig.lua_ls.setup {
    cmd = {
      get_home() .. "/.vscode/extensions/sumneko.lua-3.6.11-win32-x64/server/bin/lua-language-server.exe",
    },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.clangd.setup {
    cmd = { "C:/Program Files/LLVM/bin/clangd.exe" },
    -- handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
    },
    root_dir = util.root_pattern("build/compile_commands.json", ".git"),
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.pyright.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }

  lspconfig.zls.setup {
    cmd = { vim.env.YAZLS_EXE },
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.zk.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.groovyls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
