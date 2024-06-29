local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("User", {
    pattern = "skkeleton-initialize-pre",
    callback = function()
      print "skkeleton-initialize-pre"
      local HOME = vim.fn.expand "~"
      -- call skkeleton#config({
      --   \ 'eggLikeNewline': v:true
      --   \ })
      vim.fn["skkeleton#config"] {
        globalDictionaries = { HOME .. "/.skk/SKK-JISYO.L" },
        userDictionary = HOME .. "/.skkeleton",
        eggLikeNewline = true,
      }
      vim.fn["skkeleton#register_kanatable"]("rom", {
        ["z<Space>"] = { "\\u3000", "" },
      })
    end,
  })
  vim.keymap.set({ "i", "c" }, "<C-j>", "<Plug>(skkeleton-enable)")
end

return M
