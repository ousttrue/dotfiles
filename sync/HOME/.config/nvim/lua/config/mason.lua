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

  --
  -- client_capabilities
  --
  local calient_capabilities = vim.lsp.protocol.make_client_capabilities()
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  if CMP then
    client_capabilities = CMP.default_capabilities()
  end
  -- client_capabilities =
  --   vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("epo").register_cap())
  -- print(vim.inspect(client_capabilities))

  local function get_config(server_name, client_capabilities)
    local config = {
      on_attach = on_attach,
      capabilities = client_capabilities,
    }

    if server_name == "clangd" then
      vim.keymap.set("n", ",,", function()
        vim.cmd "ClangdSwitchSourceHeader"
      end, { noremap = true })
      -- require("lspconfig").clangd.setup()
      require("lspconfig.clangd").override(config, on_attach)
    elseif server_name == "lua_ls" then
      require("lspconfig.lua_ls").override(config, on_attach)
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
    elseif server_name == "jsonls" then
      config.settings = {
        json = {
          -- schemas = require("schemastore").json.schemas(),
          schemas = {
            { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
            { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
          },
          validate = { enable = true },
        },
      }
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
      border = "single",
    },
  }

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      -- print(server_name)
      require("lspconfig")[server_name].setup(get_config(server_name, client_capabilities))
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
