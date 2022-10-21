local M = {}

function M.setup()
  -- Somewhere in your Neovim startup, e.g. init.lua
  require("luasnip").config.set_config { -- Setting LuaSnip config

    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Use Tab (or some other key if you prefer) to trigger visual selection
    store_selection_keys = "<Tab>",
  }

  vim.cmd [[
" Expand or jump in insert mode
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 

" Jump forward through tabstops in visual mode
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Jump backward through snippet tabstops with Shift-Tab (for example)
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab
  ]]

  -- Load all snippets from the nvim/LuaSnip directory at startup
  require("luasnip.loaders.from_lua").load { paths = vim.env.XDG_CONFIG_HOME .. "/nvim/LuaSnip/" }
end

return M
