- https://github.com/chentoast/marks.nvim

# nvim_buf_set_extmark

- `extmark` [Neovim: VirtualTextを使ってVim上に注釈を出す - ハイパーマッスルエンジニア](https://www.rasukarusan.com/entry/2021/01/11/183408)

```lua
nvim_buf_set_virtual_text({buffer}, {ns_id}, {line}, {chunks}, {opts})
-- 👇
-- virtualtext は 行末
-- extmark は他のオプションもある
nvim_buf_set_extmark({buffer}, {ns_id}, {line}, {col}, {opts})
```

- `extmark` [【Neovim】好きな位置にテキストを埋め込んだりハイライトできる「ExtMark」の使い方 - ハイパーマッスルエンジニア](https://www.rasukarusan.com/entry/2021/08/22/202248)

# nvim_set_decoration_provider

- [Neovimでバッファを縞模様にする](https://zenn.dev/notomo/articles/neovim-zebra-highlight)

