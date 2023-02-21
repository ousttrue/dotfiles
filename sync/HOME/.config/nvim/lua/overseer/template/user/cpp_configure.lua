return {
  name = "[meson] configure",
  builder = function()
    -- Full path to current file (see :help expand())
    -- local file = vim.fn.expand("%:p")
    return {
      cmd = { "meson" },
      args = { "setup", "builddir", "--prefix", "prefix" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp", "c", "meson" },
  },
}
