local function get_builddir()
  local dir = os.getenv "BUILDDIR"
  if dir then
    return dir
  end
  return "builddir"
end

---@type vim.lsp.Config
return {
  cmd = {
    vim.fn.exepath "clangd",
    "--header-insertion=never",
    "--clang-tidy",
    "--background-index",
    "--offset-encoding=utf-8",
    "--compile-commands-dir=" .. get_builddir(),
  },
  root_markers = {
    ".clangd",
    "compile_commands.json",
    "builddir/compile_commands.json",
    "build_android/compile_commands.json",
  },
  filetypes = { "c", "cpp" },
}
