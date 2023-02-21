return {
  name = "[meson] build",
  builder = function()
    -- Full path to current file (see :help expand())
    -- local file = vim.fn.expand("%:p")
    return {
      cmd = { "meson" },
      args = { "install" },
      cwd = "builddir",
      components = {
        { "on_output_quickfix", open = true },
        { "on_output_parse", parser = {
          -- Put the parser results into the 'diagnostics' field on the task result
          diagnostics = {
            -- Extract fields using lua patterns
            -- To integrate with other components, items in the "diagnostics" result should match
            -- vim's quickfix item format (:help setqflist)
            { "extract", "^([^%s].+)|(%d+)| (.+)$", "filename", "lnum", "text" },

          }
        } },
        "default" },
    }
  end,
  condition = {
    filetype = { "cpp", "c", "meson" },
  },
}
