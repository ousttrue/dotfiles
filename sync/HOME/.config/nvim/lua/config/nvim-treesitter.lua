local langs = {
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

local M = {}

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
      url = "https://github.com/ousttrue/tree-sitter-powershell",
      -- url = "D:/ghq/github.com/ousttrue/tree-sitter-PowerShell",
      files = { "src/scanner.c", "src/parser.c" },
      generate_requires_npm = true,
      requires_generate_from_grammar = true,
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
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = true,
      },

      -- move = {
      --   enable = true,
      --   set_jumps = true, -- whether to set jumps in the jumplist
      --   goto_next_start = {
      --     ["]m"] = "@function.outer",
      --     ["]]"] = { query = "@class.outer", desc = "Next class start" },
      --     --
      --     -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
      --     ["]o"] = "@loop.*",
      --     -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
      --     --
      --     -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
      --     -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
      --     ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
      --     ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      --   },
      --   goto_next_end = {
      --     ["]M"] = "@function.outer",
      --     ["]["] = "@class.outer",
      --   },
      --   goto_previous_start = {
      --     ["[m"] = "@function.outer",
      --     ["[["] = "@class.outer",
      --   },
      --   goto_previous_end = {
      --     ["[M"] = "@function.outer",
      --     ["[]"] = "@class.outer",
      --   },
      --   -- Below will go to either the start or the end, whichever is closer.
      --   -- Use if you want more granular movements
      --   -- Make it even more gradual by adding multiple queries and regex.
      --   -- goto_next = {
      --   --   ["]d"] = "@conditional.outer",
      --   -- },
      --   -- goto_previous = {
      --   --   ["[d"] = "@conditional.outer",
      --   -- },
      -- },
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

  local ts_utils = require "nvim-treesitter.ts_utils"
  local function markdown_get_url_node(node)
    local node_type = node:type()
    if node_type == "uri" then
      return node
    elseif node_type == "scheme" or node_type == "path" or node_type == "host" then
      -- uri/{scheme,path}
      node = node:parent()
      while node do
        if node:type() == "uri" then
          return node
        end
        node = node:parent()
      end
    elseif node_type == "link_text" then
      -- treesitter
      --
      -- * [link_text](link_destination)
      -- inline_link [10, 2] - [10, 188]
      --   link_text [10, 3] - [10, 116]
      --   link_destination [10, 118] - [10, 187]
      --
      return ts_utils.get_next_node(node)
    elseif node_type == "link_destination" then
      return node
    end

    print(node_type)
  end

  vim.keymap.set("n", "gx", function()
    -- https://nanasi.jp/articles/code/screen/cursor-text.html
    local cfile = vim.fn.expand "<cfile>"
    if type(cfile) == "string" then
      if vim.bo.filetype == "markdown" then
        local node = ts_utils.get_node_at_cursor()
        if node then
          local url_node = markdown_get_url_node(node)
          if url_node then
            local url = vim.treesitter.get_node_text(url_node, 0)
            vim.ui.open(url)
          end
        end
      else
        if cfile:match "^https?://" then
          vim.ui.open(cfile)
        -- if DOT.get_system() == "windows" then
        --   vim.fn.system { "cmd.exe", "/c", "start", cfile }
        -- else
        --   vim.fn.system { "xdg-open", cfile }
        -- end
        else
          vim.cmd "normal! gF"
        end
      end
    end
  end)
end

return M
