https://github.com/hrsh7th/nvim-cmp

- @2023 [Neovimを完全にLuaLuaさせた | 点と接線。](https://riq0h.jp/2023/01/20/210601/)

# nvim-cmp

- [GitHub - hrsh7th/nvim-cmp: A completion plugin for neovim coded in Lua.](https://github.com/hrsh7th/nvim-cmp)
- [nvim-cmpで、タブ補完が必要ない時にEnterを押したらそのまま改行するようにしたい - Qiita](https://qiita.com/tamlog06/items/9e5e895f74750c5a197a)

## formatting

- [nvim cmp formatting #5 source name as Emoji 📚 - YouTube](https://www.youtube.com/watch?v=8zENSGqOk8w&ab_channel=YukiUthman)

# keymap

# completion

完全に発動してなかった

```lua
    -- completion = {
    --   autocomplete = false,
    -- },
```

# fomatting

```lua
cmp.setup{
   formatting = {
      format = function(_, vim_item)
         vim.cmd("packadd lspkind-nvim")
         vim_item.kind = require("lspkind").presets.codicons[vim_item.kind]
         .. "  "
         .. vim_item.kind
         return vim_item
      end,
   },
}
```

# sort の比較関数

## qsort

https://learn.microsoft.com/ja-jp/cpp/c-runtime-library/reference/qsort?view=msvc-170

```c
void qsort(
   void *base,
   size_t number,
   size_t width,
   int (__cdecl *compare )(const void *, const void *)
);
```

## 負(左辺が先)

## 正(右辺が先)

## 0(同じ)

# csutomize

- @2022 [nvim-cmpで、タブ補完が必要ない時にEnterを押したらそのまま改行するようにしたい #Vim - Qiita](https://qiita.com/tamlog06/items/9e5e895f74750c5a197a)
- @2024 [📝nvim-cmpで1つ目の候補にデフォルトでフォーカスをあわせたい - Minerva](https://minerva.mamansoft.net/Notes/%F0%9F%93%9Dnvim-cmp%E3%81%A71%E3%81%A4%E7%9B%AE%E3%81%AE%E5%80%99%E8%A3%9C%E3%81%AB%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%81%A7%E3%83%95%E3%82%A9%E3%83%BC%E3%82%AB%E3%82%B9%E3%82%92%E3%81%82%E3%82%8F%E3%81%9B%E3%81%9F%E3%81%84)
