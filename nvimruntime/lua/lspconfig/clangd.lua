local M = {}

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
    -- return LLVM_PREBUILT
    return vim.env.LOCALAPPDATA .. "/nvim-data/mason/bin/clangd.cmd"
  else
    -- mason
    return vim.fn.expand "~/.local/share/nvim/mason/bin/clangd"
    -- for _, exe in pairs(clangd_list) do
    --   if dot.which(exe) then
    --     return exe
    --   end
    -- end
  end

  return "clangd"
end

local function get_compile_commands_dir()
  local pwd = vim.fn.getcwd()
  if PATH_EXISTS "builddir/compile_commands.json" then
    return pwd .. "/builddir"
  end

  if PATH_EXISTS "build/compile_commands.json" then
    return pwd .. "/build"
  end

  if PATH_EXISTS "compile_commands.json" then
    return pwd
  end

  return pwd .. "/builddir"
end

M.options = {
  cmd = {
    vim.fn.expand "~" .. "/.local/share/nvim/mason/bin/clangd",
    "--compile-commands-dir=" .. get_compile_commands_dir(),
    "--header-insertion=never",
    "--clang-tidy",
    "--enable-config",
  },
  -- handlers = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true,
    fallbackFlags = fallbackFlags,
  },
  root_dir = util.root_pattern(
    (os.getenv "BUILDDIR" or "buildir") .. "/compile_commands.json",
    "build/compile_commands.json",
    ".git"
  ),
  -- on_attach = function(client, bufnr)
  --   print "clangd:on_attach"
  --   vim.keymap.set("n", ",,", function()
  --     vim.cmd "ClangdSwitchSourceHeader"
  --   end, { noremap = true })
  --   -- vim.diagnostic.disable(bufnr)
  --   on_attach(client, bufnr)
  -- end,
  -- capabilities = capabilities,
}

---@param lspconfig any
---@param capabilities any
---@param on_attach any
function M.setup(lspconfig, capabilities, on_attach)
  print "clangd setup"

  lspconfig.clangd.setup(M.options)
end

function M.override(config, on_attach)
  config.cmd = {
    get_clangd(),
    "--compile-commands-dir=" .. get_compile_commands_dir(),
    "--header-insertion=never",
    "--clang-tidy",
    "--enable-config",
  }

  -- handlers = lsp_status.extensions.clangd.setup(),
  config.init_options = {
    clangdFileStatus = true,
    fallbackFlags = fallbackFlags,
  }

  config.root_dir = util.root_pattern("builddir/compile_commands.json", "build/compile_commands.json", ".git")

  config.on_attach = function(client, bufnr)
    vim.keymap.set("n", "gh", function()
      vim.cmd "LspClangdSwitchSourceHeader"
    end, { noremap = true })

    on_attach(client, bufnr)
  end
end

return M
