- [Vimの補完を他エディタやIDEのような挙動にするようにする｜yasukotelin｜note](https://note.com/yasukotelin/n/na87dc604e042)

- [Vimのビルトイン補完中にfuzzy matchの設定を切り替える](https://zenn.dev/kawarimidoll/articles/262785e8ca05b0)

```vim
set completeopt=menuone,noinsert

" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
```

> 'completefunc', 'findfunc', 'omnifunc', 'operatorfunc', 'quickfixtextfunc', 'tagfunc' and 'thesaurusfunc'

# complete-functions

- https://stackoverflow.com/questions/6941842/what-is-the-difference-between-the-omnifunc-and-completefunc-autocomplete-in

## completefunc

> CTRL-X CTRL-U

- @2023 `vim` https://dev.to/cherryramatis/how-to-create-your-own-completion-for-vim-31ip

## omnifunc

> CTRL-X CTRL-O

```vim
function! Complete(findstart, base)
    if a:findstart
        return 補完を開始する列の位置
    endif
    return 補完の候補
endfunction

set omnifunc=Complete
```

## thesaurusfunc

> CTRL-X CTRL-T

# complete関数

- https://www.xmisao.com/2014/05/01/vim-complete.html

# InsertCharPre

- [Vimの手動補完を自動でトリガーすれば自動補完になります](https://zenn.dev/kawarimidoll/articles/c14c8bc0d7d73d)
- `InsertCharPre` [LSP 対応の補完プラグインの機能たち](https://zenn.dev/hrsh7th/scraps/565ac089dbaba1)

# memo

- debug info: floating win
- auto reload: object new
