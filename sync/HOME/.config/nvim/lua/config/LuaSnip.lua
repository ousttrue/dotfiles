local M = {}

function M.setup()
    local dot = require('dot')
  -- Somewhere in your Neovim startup, e.g. init.lua
  -- require("luasnip").config.set_config { -- Setting LuaSnip config

  --   -- Enable autotriggered snippets
  --   enable_autosnippets = true,

  --   -- Use Tab (or some other key if you prefer) to trigger visual selection
  --   store_selection_keys = "<Tab>",
  -- }

  -- Load all snippets from the nvim/LuaSnip directory at startup
  -- local path = (vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. "/.config")) .. "/nvim/LuaSnip"
  -- print(path)
  require("luasnip.loaders.from_lua").load {
    paths = dot.get_config_home() .. '/nvim/LuaSnip',
  }
  -- require("luasnip.loaders.from_vscode").lazy_load()

  --   vim.cmd [[
  -- " press <Tab> to expand or jump in a snippet. These can also be mapped separately
  -- " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
  -- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
  -- " -1 for jumping backwards.
  -- inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
  --
  -- snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
  -- snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
  --   ]]
end

return M
