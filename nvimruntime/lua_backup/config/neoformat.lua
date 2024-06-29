local M = {}
local DOT = require "dot"

function M.setup()
  -- vim.api.nvim_set_keymap("n", "<S-f>", ":Neoformat<CR>", { noremap = true })
  -- vim.api.nvim_set_keymap("v", "<S-f>", ":Neoformat<CR>", { noremap = true })
  -- vim.api.nvim_set_var("neoformat_basic_format_retab", "1")

  vim.g.neoformat_enabled_html = { "prettier" }
  vim.g.neoformat_enabled_css = { "prettier" }
  vim.g.neoformat_enabled_glsl = { "clang-format" }
  vim.g.neoformat_enabled_python = { "black" }
  -- vim.g.neoformat_enabled_python = { "yapf" }
  vim.g.neoformat_enabled_markdown = { "prettier" }

  -- vala
  --   vim.cmd [[
  -- let g:neoformat_vala_uc = {
  --     \ 'exe': 'uncrustify',
  --     \ 'args': ['-c -', '-q', '-l C'],
  --     \ 'stdin': 1
  -- \}
  -- ]]

  local uncrustify = "uncrustify"
  if vim.fn.executable(uncrustify) ~= 1 then
    uncrustify = "D:/msys64/mingw64/bin/uncrustify.exe"
  end
  vim.g.neoformat_vala_uc = {
    exe = uncrustify,
    args = { "-c -", "-q", "-l C" },
    stdin = 1,
  }
  vim.g.neoformat_enabled_vala = { "uc" }

  -- meson
  local muon = "muon"
  if vim.fn.executable(muon) ~= 1 then
    muon = "D:/msys64/usr/bin/muon.exe"
  end
  vim.g.neoformat_meson_muon = {
    exe = muon,
    args = {
      "fmt",
      -- "-i",
    },
    -- replace = 1,
    valid_exit_codes = { 0 },
  }
  vim.g.neoformat_enabled_meson = { "muon" }

  -- astro
  vim.g.neoformat_astro_prettier = {
    exe = "npx",
    args = { "prettier", "--stdin-filepath", '"%:p"' },
    stdin = 1,
    try_node_exe = 1,
  }

  local function formatter()
    vim.cmd [[:Neoformat]]
  end
  -- DOT.formatters.lua = formatter
  DOT.formatters.html = formatter
  DOT.formatters.json = formatter
  DOT.formatters.css = formatter
  DOT.formatters.python = formatter
  DOT.formatters.vala = formatter
  DOT.formatters.meson = formatter
  DOT.formatters.astro = formatter
  DOT.formatters.fsharp = formatter
  DOT.formatters.markdown = formatter
end

return M
