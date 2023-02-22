local M = {}

local dot_util = require('dot_util')

local function get_lua_ls()
  if vim.fn.has "win32" == 1 then
    return dot_util.get_home() .. "/.vscode/extensions/sumneko.lua-3.6.11-win32-x64/server/bin/lua-language-server.exe"
  else
    return "lua-language-server"
  end
end

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local function get_global()
  return { "vim" }
end

local function get_library()
  return vim.api.nvim_get_runtime_file("", true)
end

function M.setup(lspconfig, capabilities, on_attach)
  lspconfig.lua_ls.setup {
    cmd = { get_lua_ls() },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          enable = true,
          globals = get_global(),
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = get_library(),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = "Replace"
        },
      },
    },
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

return M
