local M = {}

local dot = require "dot"

local function get_lua_ls()
  if vim.fn.has "win32" == 1 then
    local path = dot.get_home() .. "/.vscode/extensions/sumneko.lua-3.6.11-win32-x64/server/bin/lua-language-server.exe"
    if vim.fn.executable(path) == 1 then
      return path
    end
  else
    local path = dot.get_home()
      .. "/.vscode-server/extensions/sumneko.lua-3.6.11-linux-x64/server/bin/lua-language-server"
    if vim.fn.executable(path) == 1 then
      return path
    end
  end

  return "lua-language-server"
end

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup {
  -- add any options here, or leave empty to use the default settings
}

local function get_global(d)
  local globals = { "vim" }
  return globals
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
          callSnippet = "Replace",
        },
      },
    },
    capabilities = capabilities,
    -- https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings
    on_init = function(client)
      vim.notify('lua_ls.init: ' .. client.config.root_dir, vim.log.levels.INFO)
      if vim.endswith(client.config.root_dir, "/dotfiles") then
        client.config.settings.Lua.diagnostics.globals = {
          "vim",
          "nyagos",
        }
      end

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      return true
    end,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
  }
end

return M
