local M = {}

-- workaround
local org = vim.lsp.handlers["window/showMessageRequest"]
vim.lsp.handlers["window/showMessageRequest"] = function(...)
  if vim.bo.filetype == "lua" then
    return vim.NIL
  else
    return org(...)
  end
end

local dot = require "dot"
local path = require "plenary.path"
local scandir = require "plenary.scandir"
local neodev = require "neodev"

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
neodev.setup {
  -- add any options here, or leave empty to use the default settings
}

local function get_extensions()
  if dot.is_wsl then
    return dot.get_home() .. "/.vscode-server/extensions"
  else
    return dot.get_home() .. "/.vscode/extensions"
  end
end

local function get_dir()
  local dir = get_extensions()
  if not dot.exists(dir) then
    --print("not found:", dir)
    return ""
  end
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

  print("not found sumneko in:", dir)
  return ""
end

local function get_server()
  local path = get_dir() .. "/server/bin/lua-language-server"
  if dot.get_system() == "windows" then
    path = path .. dot.get_suffix()
  end
  return path
end

local function get_lua_ls()
  local LUA_SERVER = "sumneko.lua-3.7.4"

  local path = get_server()
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

---@param root_dir string
---@return table
local function get_library(root_dir)
  -- return vim.api.nvim_get_runtime_file("", true)

  return {
    vim.env.VIMRUNTIME,
    -- "${3rd}/luv/library"
    -- "${3rd}/busted/library",
  }
end

---@param lspconfig any
---@param capabilities any vim.lsp.client.capabilities
---@param on_attach function
function M.setup(lspconfig, capabilities, on_attach)
  capabilities.window.showMessage = nil

  -- https://luals.github.io/wiki/settings
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
  require("lspconfig").lua_ls.setup {
    -- cmd = { get_lua_ls() },
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
        print "luals: use default config"
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            format = {
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
          },
        })

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
    end,
    on_attach = function(client, bufnr)
      -- client.server_capabilities.executeCommandProvider = false
      -- client.capabilities.window.showMessage = nil
      client.server_capabilities.documentFormattingProvider = false
      -- print(vim.inspect(client.server_capabilities))

      on_attach(client, bufnr)

      require("nvim-navbuddy").attach(client, bufnr)
    end,
  }
end

function M.override(config, on_attach)
  config.on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      print "luals: use default config"
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          format = {
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
        },
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
  config.on_attach = function(client, bufnr)
    -- client.server_capabilities.executeCommandProvider = false
    -- client.capabilities.window.showMessage = nil
    client.server_capabilities.documentFormattingProvider = false
    print(vim.inspect(client.server_capabilities))

    on_attach(client, bufnr)

    require("nvim-navbuddy").attach(client, bufnr)
  end
end

return M
