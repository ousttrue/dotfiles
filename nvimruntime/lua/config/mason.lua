local M = {}
function M.setup()
  -- local lspconfig = require "lspconfig"
  -- local util = require "lspconfig.util"
  -- require("lspconfig.ui.windows").default_options.border = DOT.border

  --- 共用の on_attach
  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    --- lsp highlight の抑止
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- client_capabilities =
  --   vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("epo").register_cap())
  -- print(vim.inspect(client_capabilities))

  local function get_config(server_name)
    --
    -- client_capabilities
    --
    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    -- if CMP then
    --   client_capabilities = CMP.default_capabilities()
    -- end

    -- https://neovim.discourse.group/t/how-to-disable-lsp-snippets/922
    client_capabilities.textDocument.completion.completionItem.snippetSupport = false

    local config = {
      -- on_attach = on_attach,
      capabilities = client_capabilities,
    }

    if server_name == "json-lsp" or server_name == "jsonls" then
      print(require("schemastore").json.schemas())
      config.settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
        -- json = {
        --   schemas = {
        --     {
        --       fileMatch = { "package.json" },
        --       url = "https://json.schemastore.org/package.json",
        --     },
        --     {
        --       fileMatch = { "tsconfig.json", "tsconfig.*.json" },
        --       url = "http://json.schemastore.org/tsconfig",
        --     },
        --   },
        -- },
      }
    elseif server_name == "clangd" then
      vim.keymap.set("n", ",,", function()
        vim.cmd "ClangdSwitchSourceHeader"
      end, { noremap = true })
      -- require("lspconfig").clangd.setup()
      require("lspconfig.clangd").override(config, on_attach)
    elseif server_name == "csharp_ls" then
      config.on_attach = function(client, bufnr)
        -- print(vim.inspect(client.server_capabilities))
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
      end
    elseif server_name == "pyright" then
      config.on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        on_attach(client, bufnr)
      end
    elseif server_name == "denols" then
      -- lspconfig.denols.setup {
      --   root_dir = lspconfig.util.root_pattern "deno.json",
      --   init_options = {
      --     lint = true,
      --     unstable = true,
      --     suggest = {
      --       imports = {
      --         hosts = {
      --           ["https://deno.land"] = true,
      --           ["https://cdn.nest.land"] = true,
      --           ["https://crux.land"] = true,
      --         },
      --       },
      --     },
      --   },
      -- }
    elseif server_name == "bashls" then
      config.filetypes = { "sh", "bash", "zsh" }
    elseif server_name == "powershell_es" then
      config.on_attach = function(client, bufnr)
        -- print(vim.inspect(client.server_capabilities))
        -- client.server_capabilities.documentFormattingProvider = false
        -- on_attach(client, bufnr)
      end

      if vim.fn.has "win32" == 1 then
        config.bundle_path = vim.env.LOCALAPPDATA .. "/nvim-data/mason/packages/powershell-editor-services/"
      else
        config.bundle_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/powershell-editor-services/"
      end
    elseif server_name == "elixirls" then
      if vim.fn.has "win32" == 1 then
        config.cmd = { vim.env.LOCALAPPDATA .. "/nvim-data/mason/bin/elixir-ls.cmd" }
      else
        config.cmd = { "bash", "-c", vim.env.HOME .. "/.local/share/nvim/mason/bin/elixir-ls" }
      end
    elseif server_name == "zls" then
      -- if vim.fn.has "win32" == 1 then
      --   config.cmd = { vim.env.HOME .. "/ghq/github.com/zigtools/zls/zig-out/bin/zls.exe" }
      -- end
      -- elseif server_name == "lua_ls" then
      --   -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
      --   local lua_libs = vim.api.nvim_get_runtime_file("lua", true)
      --
      --   config.on_init = function(client)
      --     if client.workspace_folders then
      --       local path = client.workspace_folders[1].name
      --       if
      --         path ~= vim.fn.stdpath "config"
      --         and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
      --       then
      --         -- .luarc.json
      --         return
      --       end
      --     end
      --
      --     client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      --       runtime = {
      --         -- Tell the language server which version of Lua you're using
      --         -- (most likely LuaJIT in the case of Neovim)
      --         version = "LuaJIT",
      --       },
      --       -- Make the server aware of Neovim runtime files
      --       workspace = {
      --         checkThirdParty = false,
      --         library = vim.list_extend(lua_libs, {
      --           "${3rd}/luv/library",
      --           "${3rd}/busted/library",
      --         }),
      --       },
      --       diagnostics = {
      --         globals = { "vim" },
      --       },
      --     })
      --   end
      --   config.settings = {
      --     Lua = {},
      --   }
    end
    -- if vim.fn.executable "vala-language-server" == 1 then
    --   require("lspconfig").vala_ls.setup {}
    -- end
    -- lspconfig.fsharp_language_server.setup {}
    -- lspconfig.fsautocomplete.setup {}
    -- lspconfig.glslls.setup {}
    --
    -- web
    --
    -- lspconfig.tsserver.setup {
    --   on_attach = function(client, bufnr)
    --     client.server_capabilities.documentFormattingProvider = false
    --     on_attach(client, bufnr)
    --   end,
    --   root_dir = lspconfig.util.root_pattern "package.json",
    --   single_file_support = false,
    -- }
    -- require("lspconfig").astro.setup {}
    -- require("lspconfig").svelte.setup {}
    --
    -- markdown
    --
    -- require("lspconfig").remark_ls.setup {
    --   settings = {
    --     requireConfig = true,
    --   },
    -- }
    -- lspconfig.zk.setup {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- }
    -- require("lspconfig").marksman.setup {
    --   on_attach = function(client, bufnr)
    --     client.server_capabilities.documentFormattingProvider = false
    --     on_attach(client, bufnr)
    --   end,
    --   root_dir = lspconfig.util.root_pattern(".marksman.toml", ".git"),
    -- }

    return config
  end

  require("mason").setup {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      check_outdated_packages_on_open = false,
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      -- print(server_name)
      require("lspconfig")[server_name].setup(get_config(server_name))
    end,
  }
  require("mason-lspconfig").setup {}

  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = ".sh|.inc|.bash|.command|.zsh|zshrc|zsh_*",
  --   callback = function()
  --     vim.lsp.start {
  --       name = "bash-language-server",
  --       cmd = { "bash-language-server", "start" },
  --     }
  --   end,
  -- })
end

return M
