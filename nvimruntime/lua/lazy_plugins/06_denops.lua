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
              { HOME .. "/.skk/SKK_JISYO.shikakugoma", "utf-8" },
              HOME .. "/.skk/SKK-JISYO.L",
              { HOME .. "/.skk/SKK_JISYO.seikana", "utf-8" },
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
      })
      vim.fn["ddc#enable"]()
      vim.keymap.set("n", "<Tab>", "<Cmd>call pum#map#insert_relative(+1)<CR>", { noremap = true })
      vim.keymap.set("n", "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>", { noremap = true })
      vim.keymap.set("n", "<C-n>", "<Cmd>call pum#map#insert_relative(+1)<CR>", { noremap = true })
      vim.keymap.set("n", "<C-p>", "<Cmd>call pum#map#insert_relative(-1)<CR>", { noremap = true })
      vim.keymap.set("n", "<C-y>", "<Cmd>call pum#map#confirm()<CR>", { noremap = true })
      vim.keymap.set("n", "<C-e>", "<Cmd>call pum#map#cancel()<CR>", { noremap = true })
    end,
  },
}
