https://neovim.io/doc/user/ui.html

# vim.ui

- https://github.com/MunifTanjim/nui.nvim

## vim.ui.input

- @2023 [vim.ui.inputを自作floating windowにした (Vim駅伝)](https://ryota2357.com/blog/2023/neovim-custom-vim-ui-input/)

## vim.ui.open

## vim.ui.select

# lula

- https://neovim.io/doc/user/lua.html#_lua-module:-vim.ui

# notify

- @2023 [neovim UIプラグイン3選 (2023年9月)](https://zenn.dev/utouto97/articles/ef5ccc615a179a)
- https://github.com/rcarriga/nvim-notify
- https://github.com/folke/noice.nvim

# cmdhight

https://zenn.dev/shougo/articles/set-cmdheight-0


```lua
local WINDOW = {
  documentation = {
    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
  },
  completion = {
    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
  },
}
```
