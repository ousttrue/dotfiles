local M = {}
function M.setup()
  --- 共用の on_attach
  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    --- lsp highlight の抑止
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- from mason-lspconfig
  local function get_config(server_name)
    local client_capabilities = vim.lsp.protocol.make_client_capabilities()

    -- https://neovim.discourse.group/t/how-to-disable-lsp-snippets/922
    client_capabilities.textDocument.completion.completionItem.snippetSupport = false

    local config = {
      -- on_attach = on_attach,
      capabilities = client_capabilities,
    }

    if server_name == "json-lsp" or server_name == "jsonls" then
      config.settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
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
    end

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
      require("lspconfig")[server_name].setup(get_config(server_name))
    end,
  }
  ---@diagnostic disable-next-line
  require("mason-lspconfig").setup {}

  require("lspconfig").zls.setup {}
end

return M
