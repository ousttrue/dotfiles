[[nvim]]

[GitHub - hrsh7th/cmp-nvim-lua: nvim-cmp source for nvim lua](https://github.com/hrsh7th/cmp-nvim-lua)

- @2023 [Neovimを完全にLuaLuaさせた | 点と接線。](https://riq0h.jp/2023/01/20/210601/)

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
