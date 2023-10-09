local DOT = require "dot"
-- local CMP = DOT.safe_require("cmp_nvim_lsp")

local M = {}
function M.setup()
  local dot = require "dot"
  local lspconfig = require "lspconfig"
  local util = require "lspconfig.util"

  require("lspconfig.ui.windows").default_options.border = dot.border

  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    -- client.server_capabilities.semanticTokensProvider = nil
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  --   if CMP then
  --   capabilities = CMP.default_capabilities()
  -- end
  -- print(vim.inspect(capabilities))

  require("lspconfig.lua_ls").setup(lspconfig, capabilities, on_attach)

  if true then
    require("lspconfig.clangd").setup(lspconfig, capabilities, on_attach)
  else
    lspconfig.ccls.setup {
      cmd = { "D:/msys64/mingw64/bin/ccls.exe" },
      compilationDatabaseDirectory = "builddir",
      index = {
        threads = 0,
      },
      clang = {
        excludeArgs = {
          "-fms-extensions",
          "-fms-compatibility",
          "-fdelayed-template-parsing",
        },
      },
    }
  end
  -- require("lspconfig.omnisharp").setup(lspconfig, capabilities, on_attach)
  require("lspconfig").csharp_ls.setup {}

  lspconfig.gopls.setup {
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

  local zls_path = ""
  if vim.fn.has "win32" == 1 then
    zls_path = vim.env.APPDATA .. "\\Code\\User\\globalStorage\\ziglang.vscode-zig\\zls_install\\zls.exe"
  elseif dot.is_wsl then
    zls_path = dot.get_home() .. "/.vscode-server/data/User/globalStorage/ziglang.vscode-zig/zls_install/zls"
  else
    zls_path = dot.get_home() .. "/.config/Code/User/globalStorage/ziglang.vscode-zig/zls_install/zls"
  end

  lspconfig.zls.setup {
    -- cmd = { vim.env.YAZLS_EXE },
    cmd = { zls_path },
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

  -- lspconfig.jsonls.setup {
  --   settings = {
  --     json = {
  --       schemas = require("schemastore").json.schemas(),
  --       validate = { enable = true },
  --     },
  --   },
  -- }

  lspconfig.tsserver.setup {}

  -- npm i -g bash-language-server
  lspconfig.bashls.setup {
    filetypes = { "sh", "bash", "zsh" },
  }
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ".sh|.inc|.bash|.command|.zsh|zshrc|zsh_*",
    callback = function()
      vim.lsp.start {
        name = "bash-language-server",
        cmd = { "bash-language-server", "start" },
      }
    end,
  })

  lspconfig.powershell_es.setup {
    bundle_path = dot.get_home() .. "/.vscode/extensions/ms-vscode.powershell-2023.3.3/modules",
  }

  if vim.fn.executable "vala-language-server" == 1 then
    require("lspconfig").vala_ls.setup {}
  end

  -- lspconfig.fsharp_language_server.setup {}

  -- lspconfig.glslls.setup {}
end

return M
