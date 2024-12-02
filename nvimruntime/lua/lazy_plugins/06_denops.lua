return {
  {
    "vim-skk/denops-skkeleton.vim",
    dependencies = "vim-denops/denops.vim",
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "skkeleton-initialize-pre",
        callback = function()
          print "skkeleton-initialize-pre"
          local HOME = vim.fn.expand "~"
          -- call skkeleton#config({
          --   \ 'eggLikeNewline': v:true
          --   \ })
          vim.fn["skkeleton#config"] {
            globalDictionaries = {
              HOME .. "/.skk/SKK_JISYO.seikana",
              HOME .. "/.skk/SKK_JISYO.shikakugoma",
              HOME .. "/.skk/SKK-JISYO.L",
              HOME .. "/.skk/SKK-JISYO.pinyin",
            },
            userDictionary = HOME .. "/.skkeleton",
            eggLikeNewline = true,
          }
          vim.fn["skkeleton#register_kanatable"]("rom", {
            ["z<Space>"] = { "\\u3000", "" },
          })
        end,
      })
      vim.keymap.set({ "i", "c" }, "<C-j>", "<Plug>(skkeleton-enable)")
    end,
  },
  { "delphinus/skkeleton_indicator.nvim", opts = {} },
  {
    "lambdalisue/kensaku.vim",
    dependencies = "vim-denops/denops.vim",
  },
  -- ddc
  -- minimum: https://gist.github.com/rbtnn/4373572564964a905d1c162ed3931497
  -- https://wagomu.me/blog/2023-09-22
  {
    "Shougo/ddc.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",
      -- source
      "vim-skk/denops-skkeleton.vim",
      "LumaKernel/ddc-source-file",
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-cmdline",
      "Shougo/ddc-source-cmdline-history",
      "Shougo/ddc-source-copilot",
      "Shougo/ddc-source-input",
      "Shougo/ddc-source-nvim-lsp",
      "Shougo/ddc-source-rg",
      "Shougo/ddc-source-shell",
      "Shougo/ddc-source-shell-native",
      "matsui54/ddc-buffer",
      "uga-rosa/ddc-source-nvim-lua",
      -- filter
      "Shougo/ddc-filter-converter_remove_overlap",
      "Shougo/ddc-filter-matcher_head",
      "Shougo/ddc-filter-matcher_length",
      "Shougo/ddc-filter-matcher_prefix",
      "Shougo/ddc-filter-sorter_head",
      "Shougo/ddc-filter-sorter_rank",
    },
    config = function()
      vim.fn["ddc#custom#patch_global"]("ui", "pum")
      -- https://github.com/search?q=repo%3AShougo%2Fddc.vim%20completionMenu&type=code
      vim.fn["ddc#custom#patch_global"]("sources", {
        "lsp",
        "around",
        "skkeleton",
      })
      vim.fn["ddc#custom#patch_global"]("sourceOptions", {
        _ = {
          matchers = { "matcher_head" },
          sorters = { "sorter_rank" },
          converters = { "converter_remove_overlap" },
        },
        around = { mark = "A" },
        lsp = {
          mark = "LSP",
          forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
        },
        skkeleton = {
          mark = "SKK",
          matchers = { "skkeleton" },
          sorters = {},
          converters = {},
          isVolatile = true,
          minAutoCompleteLength = 1,
        },
      })
      vim.fn["ddc#enable"]()
      -- vim.keymap.set("n", "<Tab>", "<Cmd>call pum#map#insert_relative(+1)<CR>", { noremap = true })
      -- vim.keymap.set("n", "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>", { noremap = true })
      vim.keymap.set({ "i" }, "<C-n>", "<Cmd>call pum#map#insert_relative(+1)<CR>", { noremap = true })
      vim.keymap.set({ "i" }, "<C-p>", "<Cmd>call pum#map#insert_relative(-1)<CR>", { noremap = true })
      vim.keymap.set({ "i" }, "<C-y>", "<Cmd>call pum#map#confirm()<CR>", { noremap = true })
      vim.keymap.set({ "i" }, "<C-e>", "<Cmd>call pum#map#cancel()<CR>", { noremap = true })
    end,
  },
  -- https://zenn.dev/vim_jp/articles/c0d75d1f3c7f33
  {
    "Shougo/ddu.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-ui-ff",
      -- source
      "Shougo/ddu-source-file_rec",
      -- kind
      "Shougo/ddu-kind-file",
      -- matcher
      "Shougo/ddu-filter-matcher_substring",
    },
    config = function()
      -- 全体に共通する設定を行う
      vim.fn["ddu#custom#patch_global"] {
        ui = "ff",
        sourceOptions = {
          _ = {
            matchers = { "matcher_substring" },
          },
        },
      }

      -- DduWholeFiles
      vim.fn["ddu#custom#patch_local"]("whole-files", {
        sources = { "file_rec" },
        sourceParams = {
          file_rec = {
            ignoredDirectories = { ".git" },
          },
        },
        sourceOptions = {
          file_rec = {
            maxItems = 50000,
          },
        },
      })
      vim.api.nvim_create_user_command("DduWholeFiles", function()
        vim.fn["ddu#start"] {
          name = "whole-files",
          sourceOptions = { file_rec = { path = vim.fn.getcwd() } },
        }
      end, {})

      -- DduNodeFiles
      vim.fn["ddu#custom#patch_local"]("node-files", {
        sources = { "file_rec" },
        sourceParams = {
          file_rec = {
            ignoredDirectories = { ".git", "node_modules" },
          },
        },
      })
      vim.api.nvim_create_user_command("DduNodeFiles", function()
        vim.fn["ddu#start"] {
          name = "node-files",
          sourceOptions = { file_rec = { path = vim.fn.getcwd() } },
        }
      end, {})

      vim.cmd [[
" ddu-ui-ff上でのみ有効なKeymap（`e`）を設定する
function s:ddu_ff_settings() abort
    nnoremap <buffer> e <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>
endfunction
autocmd FileType ddu-ff call s:ddu_ff_settings()
]]
    end,
  },
}
