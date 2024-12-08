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
              -- HOME .. "/.skk/SKK_JISYO.seikana",
              -- HOME .. "/.skk/SKK_JISYO.shikakugoma",
              HOME .. "/.skk/SKK-JISYO.L",
              -- HOME .. "/.skk/SKK-JISYO.pinyin",
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
    "delphinus/skkeleton_indicator.nvim",
    opts = {
      eijiText = " ",
    }
  },
  {
    "lambdalisue/kensaku.vim",
    dependencies = "vim-denops/denops.vim",
  },
}
