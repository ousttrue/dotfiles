# gf

- @2023 [VimでgfしたらURLをブラウザで開く | Atusy's blog](https://blog.atusy.net/2023/12/09/gf-open-url/)

- [GitHub - hrsh7th/nvim-gtd: LSP's Go to definition plugin for neovim.](https://github.com/hrsh7th/nvim-gtd)
- @2023 [VimでgfしたらURLをブラウザで開く | Atusy's blog](https://blog.atusy.net/2023/12/09/gf-open-url/)
- @2022 [Vim の gf について(パス移動の救世主)](https://zenn.dev/hasu_83/articles/explain-vim-gf)
- [GitHub - sam4llis/nvim-lua-gf: A utility plugin which extends `gf` functionality in Lua files.](https://github.com/sam4llis/nvim-lua-gf)
- [gf-user で gf の動作を拡張する - 永遠に未完成](https://thinca.hatenablog.com/entry/20140324/1395590910)
- [gfでカーソル下のファイルを開く](https://yanor.net/wiki/?Vim/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%AA%E3%83%BC%E3%83%97%E3%83%B3/gf%E3%81%A7%E3%82%AB%E3%83%BC%E3%82%BD%E3%83%AB%E4%B8%8B%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E9%96%8B%E3%81%8F)

```vim
set path
set includeexpr
set suffixesadd
set isfname
```

# gx

- https://gxliu.hatenablog.com/entry/2021/10/16/230903
- https://sbulav.github.io/vim/neovim-opening-urls/

```lua
local map = require('utils').map
-- URL handling
if vim.fn.has("mac") == 1 then
  map[''].gx = {'<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>'}
elseif vim.fn.has("unix") == 1 then
  map[''].gx = {'<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>'}
else
  map[''].gx = {'<Cmd>lua print("Error: gx is not supported on this OS!")<CR>'}
end
```

## markdown

- https://github.com/ixru/nvim-markdown
