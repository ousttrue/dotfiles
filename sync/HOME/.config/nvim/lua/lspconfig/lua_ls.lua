local M = {}

local dot = require "dot"
local path = require "plenary.path"
local scandir = require "plenary.scandir"
local neodev = require "neodev"

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
neodev.setup {
  -- add any options here, or leave empty to use the default settings
}

local function get_server(dir)
  for i, e in
    ipairs(scandir.scan_dir(dir, {
      depth = 1,
      add_dirs = true,
      only_dirs = true,
      search_pattern = "sumneko",
    }))
  do
    return e .. ""
  end

  -- print(path.Path)
  -- local extensions = path.Path:new(dir)
  -- extensions = path:new(dir)
  -- print(extensions)
  -- for e in extensions:iter() do
  --   print(e)
  -- end

  -- for k, v in pairs(path) do
  --   print(k, v)
  -- end
  -- local extensions = path.Path:new(dir)
  -- print(extensions)
end

local function get_lua_ls()
  local LUA_SERVER = "sumneko.lua-3.6.18"

  local path = ""
  if dot.is_wsl then
    path = get_server(dot.get_home() .. "/.vscode-server/extensions") .. "/server/bin/lua-language-server"
  else
    path = get_server(dot.get_home() .. "/.vscode/extensions") .. "/server/bin/lua-language-server" .. dot.get_suffix()
  end
  -- print(path)
  if vim.fn.executable(path) == 1 then
    return path
  end

  return "lua-language-server"
end

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
      -- print(vim.inspect(client.config.capabilities))

      vim.notify("lua_ls.init: " .. client.config.root_dir, vim.log.levels.INFO)
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
