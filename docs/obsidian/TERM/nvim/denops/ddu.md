https://zenn.dev/shougo/articles/ddu-vim-beta

- https://zenn.dev/shougo/articles/ddu-vim-make-plugins

# articles

- @2023 [ddu.vimの基本設定概観](https://zenn.dev/vim_jp/articles/c0d75d1f3c7f33)

- @2023 `lua`, `startFilter` [一歩ずつ始めるddu.vim](https://zenn.dev/vim_jp/articles/20231020step-by-step-ddu)

- @2023 `startFilter` [ddu.vimにちゃんと入門した話](https://zenn.dev/uga_rosa/articles/f55be75a573c0b)
- @2022 [ddu.vim 設定例の紹介 - アルパカログ](https://alpacat.com/posts/my-ddu-settings)

- @2023 `preview` [NeoVimにddu.vimを導入する #neovim - Qiita](https://qiita.com/t7u-ito/items/5227cfcee113e7662c50)

# ui

## ui-ff

`help: ddu-ui-ff`

### PARAMS

```lua
vim.fn["ddu#custom#patch_global"] {
  ui = "ff",
  uiParams = {
    ff = {
      -- here
    },
  },
},
```

# source

## source-help

- [ヘルプ検索から始めるddu](https://zenn.dev/vim_jp/articles/0005-search_help_with_ddu)
