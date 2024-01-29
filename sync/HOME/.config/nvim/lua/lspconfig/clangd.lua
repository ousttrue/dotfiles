local M = {}

local dot = require "dot"

local util = require "lspconfig.util"

local clangd_list = {
  "clangd-16",
  "clangd-15",
  "clangd",
}

local LLVM_PREBUILT = "C:/Program Files/LLVM/bin/clangd.exe"
local LLVM_MINGW = "D:/llvm-mingw-20230614-ucrt-x86_64/bin/clangd.exe"

local fallbackFlags = {}
-- if vim.fn.has "win32" == 1 then
--   fallbackFlags = { "/std:c++latest" }
-- else
--   fallbackFlags = { "-std=c++2b" }
-- end

local function get_clangd()
  if vim.fn.has "win32" == 1 then
    -- return LLVM_MINGW
    return LLVM_PREBUILT
  else
    for _, exe in pairs(clangd_list) do
      if dot.which(exe) then
        return exe
      end
    end
  end

  return "clangd"
end

local function get_compile_commands_dir()
  local pwd = vim.fn.getcwd()
  if dot.exists "builddir/compile_commands.json" then
    return pwd .. "/builddir"
  end

  if dot.exists "build/compile_commands.json" then
    return pwd .. "/build"
  end

  if dot.exists "compile_commands.json" then
    return pwd
  end

  return pwd .. "/builddir"
end

---@param lspconfig any
---@param capabilities any
---@param on_attach any
function M.setup(lspconfig, capabilities, on_attach)
  vim.keymap.set("n", ",,", function()
    vim.cmd "ClangdSwitchSourceHeader"
  end, { noremap = true })

  lspconfig.clangd.setup {
    -- cmd = {
    --   get_clangd(),
    --   "--compile-commands-dir=" .. get_compile_commands_dir(),
    --   "--header-insertion=never",
    --   "--clang-tidy",
    --   "--enable-config",
    -- },
    -- handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
      fallbackFlags = fallbackFlags,
    },
    root_dir = util.root_pattern("builddir/compile_commands.json", "build/compile_commands.json", ".git"),
    on_attach = function(client, bufnr)
      print "clangd:on_attach"
      vim.keymap.set("n", ",,", function()
        vim.cmd "ClangdSwitchSourceHeader"
      end, { noremap = true })
      -- vim.diagnostic.disable(bufnr)
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }
end

return M
