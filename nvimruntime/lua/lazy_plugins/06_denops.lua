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
      -- ui
      "Shougo/ddu-ui-ff",
      -- source
      "Shougo/ddu-source-file_rec",
      "matsui54/ddu-source-help",
      -- filter
      "Shougo/ddu-filter-matcher_substring",
      -- kind
      "Shougo/ddu-kind-file",
    },
    config = function()
      local height = tonumber(vim.api.nvim_command_output "echo &lines") or 0
      local width = tonumber(vim.api.nvim_command_output "echo &columns") or 0
      -- 全体に共通する設定を行う
      vim.fn["ddu#custom#patch_global"] {
        ui = "ff",
        uiParams = {
          ff = {
            -- autoResize = true,
            winWidth = width,
            winHeight = height * 0.7,
            split = "floating",
            -- split = "vertical",
            -- splitDirection = "topleft",
            -- startFilter = true,
            -- filterFloatingPosition = "bottom",
            filterSplitDirection = "floating",
            floatingBorder = "rounded",
            --
            startAutoAction = true,
            autoAction = { name = "preview", delay = 0 },
            --
            previewWidth = width,
            -- previewHeight = height * 0.3,
            previewFloating = true,
            previewFloatingBorder = "rounded",
            previewFloatingTitle = "Preview",
            -- previewSplit = "horizontal",
            prompt = "> ",
          },
        },
        kindOptions = {
          file = {
            defaultAction = "open",
          },
          colorscheme = {
            defaultAction = "set",
          },
        },
        sourceOptions = {
          _ = {
            matchers = { "matcher_substring" },
          },
        },
      }

      vim.fn["ddu#custom#patch_local"]("help-ff", {
        sources = {
          { name = "help" },
        },
      })
      local keymap = vim.keymap.set
      local ddu_do_action = vim.fn["ddu#ui#do_action"]

      local function ddu_ff_keymaps()
        keymap("n", "<CR>", function()
          ddu_do_action "itemAction"
        end, { buffer = true })
        keymap("n", "i", function()
          ddu_do_action "openFilterWindow"
        end, { buffer = true })
        keymap("n", "q", function()
          ddu_do_action "quit"
        end, { buffer = true })
      end

      local function ddu_ff_filter_keymaps()
        keymap("i", "<CR>", function()
          vim.cmd.stopinsert()
          ddu_do_action "closeFilterWindow"
        end, { buffer = true })
        keymap("n", "<CR>", function()
          ddu_do_action "cloeFilterWindow"
        end, { buffer = true })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = ddu_ff_keymaps,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff-filter",
        callback = ddu_ff_filter_keymaps,
      })

      vim.api.nvim_create_user_command("Help", function()
        vim.fn["ddu#start"] { name = "help-ff" }
      end, {})
      -- DduWholeFiles
      vim.fn["ddu#custom#patch_local"]("files", {
        sources = {
          {
            name = "file_rec",
            options = {
              matchers = {
                "matcher_substring",
              },
            },
          },
        },
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
          name = "files",
          sourceOptions = { file_rec = { path = vim.fn.getcwd() } },
        }
      end, {})

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = function()
          -- vim.bo.cursorline = true

          local opts = { noremap = true, silent = true, buffer = true }
          vim.keymap.set("n", "e", [[<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>]], opts)
          vim.keymap.set("n", "<CR>", [[<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>]], opts)
          vim.keymap.set({ "n" }, "q", [[<Cmd>call ddu#ui#do_action("quit")<CR>]], opts)
          vim.keymap.set({ "n" }, "<ESC>", [[<Cmd>call ddu#ui#do_action("quit")<CR>]], opts)
          vim.keymap.set({ "n" }, "i", [[<Cmd>call ddu#ui#do_action("openFilterWindow")<CR>]], opts)
        end,
      })
    end,

    vim.keymap.set("n", "<SPACE>p", "<Cmd>DduWholeFiles<CR>", { noremap = true }),
  },
}
