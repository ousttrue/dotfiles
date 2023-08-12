local M = {}

local dot = require "dot"

local util = require "lspconfig.util"

local clangd_list = {
  "clangd-16",
  "clangd-15",
  "clangd",
}

local fallbackFlags = {}
if vim.fn.has "win32" == 1 then
  fallbackFlags = { "/std:c++latest" }
else
  fallbackFlags = { "-std=c++2b" }
end

local function get_clangd()
  if vim.fn.has "win32" == 1 then
    return "C:/Program Files/LLVM/bin/clangd.exe"
  else
    for _, exe in pairs(clangd_list) do
      if dot.which(exe) then
        return exe
      end
    end
  end
end

local function get_compile_commands_dir()
  if dot.exists "builddir/compile_commands.json" then
    return "builddir"
  end

  if dot.exists "build/compile_commands.json" then
    return "build"
  end

  if dot.exists "compile_commands.json" then
    return "."
  end

  return "builddir"
end

---@param lspconfig any
---@param capabilities any
---@param on_attach any
function M.setup(lspconfig, capabilities, on_attach)
  lspconfig.clangd.setup {
    cmd = {
      get_clangd(),
      "--compile-commands-dir=" .. get_compile_commands_dir(),
      "--header-insertion=never",
      "--clang-tidy",
      "--enable-config",
      -- '--query-driver="C:/Program Files/LLVM/bin/clang-cl.exe"',
    },
    -- handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
      fallbackFlags = fallbackFlags,
    },
    root_dir = util.root_pattern("builddir/compile_commands.json", "build/compile_commands.json", ".git"),
    on_attach = function(client, bufnr)
      vim.keymap.set("n", ",,", function()
        vim.cmd "ClangdSwitchSourceHeader"
      end, { noremap = true })
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }
end

return M
