local M = {}
local DOT = require "dot"

function M.setup()
  -- vim.api.nvim_set_keymap("n", "<S-f>", ":Neoformat<CR>", { noremap = true })
  -- vim.api.nvim_set_keymap("v", "<S-f>", ":Neoformat<CR>", { noremap = true })
  -- vim.api.nvim_set_var("neoformat_basic_format_retab", "1")

  vim.g.neoformat_enabled_html = { "prettier" }
  vim.g.neoformat_enabled_glsl = { "clang-format" }
  vim.g.neoformat_enabled_python = { "black" }
  -- vim.g.neoformat_enabled_python = { "yapf" }

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
      "-i",
      "%:p",
    },
    replace = 1,
  }
  vim.g.neoformat_enabled_meson = { "muon" }

  local function formatter()
    vim.cmd [[:Neoformat]]
  end
  DOT.formatters.lua = formatter
  DOT.formatters.html = formatter
  DOT.formatters.json = formatter
  DOT.formatters.python = formatter
  DOT.formatters.vala = formatter
  DOT.formatters.meson = formatter
end

return M
