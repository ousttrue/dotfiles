local M = {
  "query",
  -- "help" => vimdoc,
  "vimdoc",
  -- langs
  "lua",
  "c",
  "cpp",
  "c_sharp",
  "python",
  "go",
  "zig",
  "vala",
  "bash",
  -- web
  "markdown",
  "markdown_inline",
  "html",
  "css",
  "svelte",
  "scss",
  "typescript",
  "javascript",
  "tsx",
  "yaml",
  "json",
  "jsonc",
  "toml",
  -- "nu",
  "uri",
}

local langs = {}

function M.setup()
  -- パーサーのインストール先（任意）
  local treesitterpath = vim.fn.stdpath "cache" .. "/treesitter"
  vim.opt.runtimepath:append(treesitterpath)

  -- URIパーサーの設定追加
  -- https://blog.atusy.net/2023/11/17/tree-sitter-uri/
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.uri = {
    install_info = {
      url = "https://github.com/atusy/tree-sitter-uri",
      branch = "main",
      files = { "src/parser.c" },
      generate_requires_npm = false, -- if stand-alone parser without npm dependencies
      requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "uri", -- if filetype does not match the parser name
  }

  -- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
  -- ft_to_parser.mdx = "markdown"
  vim.treesitter.language.register("markdown", "mdx")

  vim.treesitter.language.register("xml", "html")

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

  -- fsharp
  parser_config.fsharp = {
    install_info = {
      url = "https://github.com/Nsidorenco/tree-sitter-fsharp",
      branch = "develop",
      files = { "src/scanner.cc", "src/parser.c" },
      generate_requires_npm = true,
      requires_generate_from_grammar = true,
    },
    filetype = "fsharp",
  }

  -- powershell
  -- https://medium.com/@kacpermichta33/powershell-development-in-neovim-23ed44d453b4
  -- tree-sitter-cli  ^0.15.2  →  ^0.20.8
  -- %LOCALAPPDATA%\tree-sitter\lib\powershell.dll
  -- parser/<lang>.so
  -- module.exports = grammar({
  --   name: 'PowerShell',
  -- parser_config.PowerShell
  -- 大文字小文字 /
  parser_config.PowerShell = {
    install_info = {
      -- url = "https://github.com/jrsconfitto/tree-sitter-powershell",
      -- url = "https://github.com/JamesWTruher/tree-sitter-powershell",
      -- branch = "operator001",
      url = "D:/ghq/github.com/JamesWTruher/tree-sitter-PowerShell",
      files = { "src/scanner.c" },
      -- generate_requires_npm = true,
      -- requires_generate_from_grammar = true,
    },
    filetype = "ps1",
    used_by = { "psm1", "psd1", "pssc", "psxml", "cdxml" },
  }

  require("nvim-treesitter.configs").setup {
    parser_install_dir = treesitterpath,
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    matchup = {
      enable = true,
    },
    -- ensure_installed = "all",
    ensure_installed = langs,

    indent = {
      enable = true,
      disable = {
        "c",
        "cpp",
      },
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    -- sync_install = true,

    -- List of parsers to ignore installing
    -- ignore_install = { "javascript" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is the name of the parser)
      -- list of language that will be disabled
      -- disable = { "lua" },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      -- additional_vim_regex_highlighting = false,
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["of"] = "@function.outer",
          ["if"] = "@function.inner",
          ["oc"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },

    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  }
end

return M
