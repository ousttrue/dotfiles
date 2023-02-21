local dot_util = require('dot_util')
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local M = {}
function M.setup()
  --local lsp_status = require "lsp-status"
  -- local aerial = require "aerial"
  -- local symbols_outline = require "symbols-outline"
  -- lsp_status.register_progress()
  local navic = require "nvim-navic"

  ---@diagnostic disable-next-line
  local function on_attach(client, bufnr)
    -- print(vim.inspect(client.server_capabilities))
    -- aerial.on_attach(client, bufnr)
    -- lsp_status.on_attach(client)
    -- symbols_outline.open_outline()
    navic.attach(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set({ "n", "v" }, "F", vim.lsp.buf.format, { buffer = bufnr, noremap = true })
      -- vim.keymap.set("v", "F", vim.lsp.buf.format, { buffer=bufnr, noremap = true })
    end
  end

  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- for k, v in pairs(lsp_status.capabilities) do
  --   capabilities[k] = v
  -- end
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- print(vim.inspect(capabilities))

  lspconfig.lua_ls.setup {
    cmd = {
      dot_util.get_home() .. "/.vscode/extensions/sumneko.lua-3.6.11-win32-x64/server/bin/lua-language-server.exe",
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

  lspconfig.omnisharp.setup {
    cmd = { "dotnet", dot_util.get_home() .. "/.vscode/extensions/ms-dotnettools.csharp-1.25.4-win32-x64/.omnisharp/1.39.4-net6.0/OmniSharp.dll" },
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = {
        full = vim.empty_dict(),
        legend = {
          tokenModifiers = { "static_symbol" },
          tokenTypes = {
            "comment",
            "excluded_code",
            "identifier",
            "keyword",
            "keyword_control",
            "number",
            "operator",
            "operator_overloaded",
            "preprocessor_keyword",
            "string",
            "whitespace",
            "text",
            "static_symbol",
            "preprocessor_text",
            "punctuation",
            "string_verbatim",
            "string_escape_character",
            "class_name",
            "delegate_name",
            "enum_name",
            "interface_name",
            "module_name",
            "struct_name",
            "type_parameter_name",
            "field_name",
            "enum_member_name",
            "constant_name",
            "local_name",
            "parameter_name",
            "method_name",
            "extension_method_name",
            "property_name",
            "event_name",
            "namespace_name",
            "label_name",
            "xml_doc_comment_attribute_name",
            "xml_doc_comment_attribute_quotes",
            "xml_doc_comment_attribute_value",
            "xml_doc_comment_cdata_section",
            "xml_doc_comment_comment",
            "xml_doc_comment_delimiter",
            "xml_doc_comment_entity_reference",
            "xml_doc_comment_name",
            "xml_doc_comment_processing_instruction",
            "xml_doc_comment_text",
            "xml_literal_attribute_name",
            "xml_literal_attribute_quotes",
            "xml_literal_attribute_value",
            "xml_literal_cdata_section",
            "xml_literal_comment",
            "xml_literal_delimiter",
            "xml_literal_embedded_expression",
            "xml_literal_entity_reference",
            "xml_literal_name",
            "xml_literal_processing_instruction",
            "xml_literal_text",
            "regex_comment",
            "regex_character_class",
            "regex_anchor",
            "regex_quantifier",
            "regex_grouping",
            "regex_alternation",
            "regex_text",
            "regex_self_escaped_character",
            "regex_other_escape",
          },
        },
        range = true,
      }

      on_attach(client, bufnr)
    end,
    capabilities = capabilities,

    root_dir = util.root_pattern('*.sln'),

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
  }
end

return M
