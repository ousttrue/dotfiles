- @2022 [vimでmarkdownで`*`とかが隠れちゃう(conceal)やつへの対処（のひとつ）](https://zenn.dev/miyataka/scraps/87ddc4c9de7394)
- @2020 [vim-pandoc-syntaxでurlを非表示にしたい #Vim - Qiita](https://qiita.com/Cj-bc/items/e4d1ecfed8197d1f04b7)
- @2016 [Vim で JSON のダブルクォーテーションが表示されない場合の解決法 #Vim - Qiita](https://qiita.com/karur4n/items/a26007236c59c5fb8735)
- @2014 [vimのconcealを使ってJavadocを奇麗に表示 - mfumiの日記](https://mfumi.hatenadiary.org/entry/20140328/1395946070)
- @2011 [【Vim】新機能“conceal”構文属性を使う | blog.delphinus.dev](https://blog.delphinus.dev/2011/02/use-vim-conceal.html)

# 使いたいところ
- 消えるところ選びたい
- markdown の link の url
- conceallevel=2 にして cchar を明示的に設定するのがよさそう

# syntax: cchar, cstr

- syntax match conceal 
- hi link Conceal

## js

```vim
syntax clear javaScriptFunction
syntax match javaScriptFunction /\<function\>/ nextgroup=javaScriptFuncName skipwhite conceal cchar=𝔽
syntax match javaScriptFunctionNoParams /function()/ conceal cchar=𝔽

hi link javaScriptFunctionNoParams javaScriptFunction
hi! link Conceal javaScriptFunction
```

## markdown

- @2019 [Vim – ちとくのホームページ](https://chitoku.jp/tag/vim/)

# highlight
- @2013 [vim syntax highlighting - Vim Conceal highlight - Stack Overflow](https://stackoverflow.com/questions/15071808/vim-conceal-highlight)
# カスタマイズするには？

- https://github.com/Jxstxs/conceal.nvim

