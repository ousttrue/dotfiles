return {
  { "vim-denops/denops.vim" },
  -- skk
  {
    "vim-denops/denops.vim",
  },
  {
    "vim-skk/denops-skkeleton.vim",
    config = function()
      vim.cmd [[
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)
function! s:skkeleton_init() abort
  call skkeleton#config({
    \'globalDictionaries':["~/.skk/SKK-JISYO.L"],
    \'userJisyo':"~/.skkeleton",
    \ 'eggLikeNewline': v:true
    \ })
  call skkeleton#register_kanatable('rom', {
    \ "z\<Space>": ["\u3000", ''],
    \ })
endfunction
augroup skkeleton-initialize-pre
  autocmd!
  autocmd User skkeleton-initialize-pre call s:skkeleton_init()
augroup END

      ]]
    end,
  },
}
