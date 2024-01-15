local parette = {
  bg = "#000000",
  bg_select = "#00241b",

  non = "#303030", -- よく見れば見える
  comment = "#666666", -- 見やすいが目立たない
  fg = "#0a8a11", -- syntax: keyword
  symbol = "#8605a7", -- syntax: variable, constant, left value
  literal = "#3165e7", -- syntax: literal, right value
}
require("fuga").setup("fuga", "dark", parette)

-- vim.cmd [[
-- augroup fuga_reload
--   autocmd!
--   autocmd bufWritePost fuga.lua :lua require('fuga').reload()
-- augroup END
-- ]]
--
-- local M = {}
--
-- function M.reload()
--   package.loaded.fuga = nil
--   require("fuga").setup(name, "dark", palette)
--
--   vim.schedule(function()
--     vim.cmd "colorscheme fuga"
--
--     package.loaded.ccc = nil
--     require("ccc").setup {
--       -- Your preferred settings
--       -- Example: enable highlighter
--       highlighter = {
--         auto_enable = true,
--         lsp = true,
--       },
--     }
--     vim.cmd [[ CccHighlighterEnable ]]
--   end)
-- ennsd
--
-- return M
