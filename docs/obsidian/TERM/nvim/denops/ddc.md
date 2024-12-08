[GitHub - Shougo/ddc.vim: Dark deno-powered completion framework for neovim/Vim](https://github.com/Shougo/ddc.vim)

# ddc

- [自動補完プラグイン ddc.vim + pum.vim](https://zenn.dev/shougo/articles/ddc-vim-pum-vim)

https://zenn.dev/shougo/articles/ddc-vim-beta

https://zenn.dev/shougo/articles/ddc-vim-pum-vim

- @2023 [NeoVimにddc.vimを導入する #neovim - Qiita](https://qiita.com/t7u-ito/items/e43cbb8597ffa21835a6)
- @2021 [Vimの新しい自動補完プラグイン「ddc.vim」を使ってみた｜Dentsu Digital Tech Blog](https://note.com/dd_techblog/n/n97f2b6ca09d8)
- @2021 [新世代の自動補完プラグイン ddc.vim](https://zenn.dev/shougo/articles/ddc-vim-beta)

# Source

## around

- https://zenn.dev/mstn_/articles/8e92fa90599a95
- @2024 [ddc.vimとpum.vimを試す最小限の設定 · GitHub](https://gist.github.com/rbtnn/4373572564964a905d1c162ed3931497)

```lua
vim.fn["ddc#custom#patch_global"]("ui", "pum")
-- https://github.com/search?q=repo%3AShougo%2Fddc.vim%20completionMenu&type=code
vim.fn["ddc#custom#patch_global"]("sources", { "around" })
vim.fn["ddc#custom#patch_global"]("sourceOptions", {
  _ = {
    matchers = { "matcher_head" },
    sorters = { "sorter_rank" },
    converters = { "converter_remove_overlap" },
  },
  around = { mark = "A" },
})
vim.fn["ddc#enable"]()
vim.keymap.set("n", "<Tab>", "<Cmd>call pum#map#insert_relative(+1)<CR>", { noremap = true })
vim.keymap.set("n", "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>", { noremap = true })
vim.keymap.set("n", "<C-n>", "<Cmd>call pum#map#insert_relative(+1)<CR>", { noremap = true })
vim.keymap.set("n", "<C-p>", "<Cmd>call pum#map#insert_relative(-1)<CR>", { noremap = true })
vim.keymap.set("n", "<C-y>", "<Cmd>call pum#map#confirm()<CR>", { noremap = true })
vim.keymap.set("n", "<C-e>", "<Cmd>call pum#map#cancel()<CR>", { noremap = true })
```

## ddc-source-nvim-lsp

- @2024 [ddc.vim導入時に詰まったところメモ（LSP）](https://zenn.dev/airrnot1106/articles/d0a2485bd309b4)
- @2023 [ddc-source-nvim-lspを大幅に強化した](https://zenn.dev/vim_jp/articles/6a2c9717930e54)

## skkeleton

- [【メモ】skkeletonとddcの設定 | 自ら環境を構築して執筆するブログ ](https://blog.takef-n.com/entry/post049/)
- @2024 [neovimとlazy.nvimでskkeletonを使いたい #Linux - Qiita](https://qiita.com/osamou/items/99b05016f1417bd7b46d)

## plugins

- https://zenn.dev/vim_jp/articles/4fa91c21-fffc-4a74-9444-b06658b194b3
