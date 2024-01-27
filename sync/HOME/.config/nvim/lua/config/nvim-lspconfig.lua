local DOT = require "dot"
-- local CMP = DOT.safe_require("cmp_nvim_lsp")

local VSCODE_SERVER = DOT.get_home() .. "/.vscode-server"
local VSCODE_LOCAL = DOT.get_home() .. "/.vscode"
local VSCODE = DOT.is_wsl and VSCODE_SERVER or VSCODE_LOCAL

local M = {}
function M.setup()
  local lspconfig = require "lspconfig"
  local util = require "lspconfig.util"

  require("lspconfig.ui.windows").default_options.border = DOT.border

  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  --   if CMP then
  --   capabilities = CMP.default_capabilities()
  -- end
  -- print(vim.inspect(capabilities))
  -- local capabilities =
  --   vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("epo").register_cap())

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
  require("lspconfig").csharp_ls.setup {
    on_attach = function(client, bufnr)
      -- print(vim.inspect(client.server_capabilities))
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }

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
  elseif DOT.is_wsl then
    zls_path = VSCODE .. "/data/User/globalStorage/ziglang.vscode-zig/zls_install/zls"
  else
    zls_path = DOT.get_home() .. "/.config/Code/User/globalStorage/ziglang.vscode-zig/zls_install/zls"
  end

  lspconfig.zls.setup {
    -- cmd = { vim.env.YAZLS_EXE },
    cmd = { zls_path },
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.groovyls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  require("lspconfig").jsonls.setup {
    capabilities = capabilities,
    settings = {
      json = {
        -- schemas = require("schemastore").json.schemas(),
        schemas = {
          { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
          { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
        },
        validate = { enable = true },
      },
    },
  }

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

  if vim.fn.executable "vala-language-server" == 1 then
    require("lspconfig").vala_ls.setup {}
  end

  -- lspconfig.fsharp_language_server.setup {}

  -- lspconfig.glslls.setup {}

  -- Register linters and formatters per language
  -- local eslint = require "efmls-configs.linters.eslint"
  -- local prettier = require "efmls-configs.formatters.prettier"
  -- local stylua = require "efmls-configs.formatters.stylua"
  -- local languages = {
  --   -- typescript = { eslint, prettier },
  --   lua = { stylua },
  --   -- html = { markuplint },
  -- }

  -- Or use the defaults provided by this plugin
  -- check doc/SUPPORTED_LIST.md for the supported languages
  --
  -- local languages = require('efmls-configs.defaults').languages()
  -- local efmls_config = {
  --   filetypes = vim.tbl_keys(languages),
  --   settings = {
  --     rootMarkers = { ".git/" },
  --     languages = languages,
  --   },
  --   init_options = {
  --     documentFormatting = true,
  --     documentRangeFormatting = true,
  --   },
  -- }
  -- require("lspconfig").custom_elements_ls.setup {}
  -- require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
  --   -- Pass your custom lsp config below like on_attach and capabilities
  --   --
  --   -- on_attach = on_attach,
  --   -- capabilities = capabilities,
  -- }))

  -- dotnet tool install --global fsautocomplete
  -- dotnet tool install --global fantomas
  require("lspconfig").fsautocomplete.setup {}

  lspconfig.powershell_es.setup {}

  --
  -- web
  --
  lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    root_dir = lspconfig.util.root_pattern "package.json",
    single_file_support = false,
  }
  require("lspconfig").astro.setup {}
  require("lspconfig").svelte.setup {}

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
  require("lspconfig").marksman.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    root_dir = lspconfig.util.root_pattern(".marksman.toml", ".git"),
  }

  local mason_lspconfig = require "mason-lspconfig"
  mason_lspconfig.setup_handlers {
    function(server_name)
      local opts = {}
      opts.on_attach = function(_, bufnr)
        local bufopts = { silent = true, buffer = bufnr }
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gtD", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "grf", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>p", vim.lsp.buf.format, bufopts)
      end
      require("lspconfig")[server_name].setup(opts)
    end,
  }
end

return M
