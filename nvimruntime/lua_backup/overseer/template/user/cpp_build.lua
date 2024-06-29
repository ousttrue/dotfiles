local function get_problem_matcher()
  if vim.fn.has "win32" then
    return {
      -- Extract fields using lua patterns
      -- To integrate with other components, items in the "diagnostics" result should match
      -- vim's quickfix item format (:help setqflist)
      { "extract", "^([^%s].+)|(%d+)| (.+)$", "filename", "lnum", "text" },
    }
  else
    return {
      -- -- gcc
      -- -- src/tagtable.cpp|7 col 14| warning: ISO C++ forbids converting a string constant to ‘char*’ [-Wwrite-strings]
      -- { "extract", "([^ |]+)|(%d+) col %d+| (%w+): (.*)", "filename", "lnum", "text" },
      -- -- link
      -- -- /usr/bin/ld: src/istream.cpp|637| undefined reference to `growbuf_init_without_GC(growbuf*)
      -- { "extract", "[^ :]+: ([^|]+)|(%d+)| (%w+): (.*)", "filename", "lnum", "text" },
      -- { "extract", "([^ |]+)|(%d+)| (%w+): (.*)", "filename", "lnum", "text" },
      -- -- { "extract", "^([^|]+)|(%d+)| (%w+): (.*)", "filename", "lnum", "text" },
      -- -- /w3m/builddir/../src/terms.cpp:182: undefined reference to `write1(char)'
    }
  end
end

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
        -- "default",
        {

          "on_output_parse",
          parser = {
            -- Put the parser results into the 'diagnostics' field on the task result
            diagnostics = get_problem_matcher(),
          },
        },
        { "on_output_quickfix", open = true },
        "on_result_diagnostics",
        { "on_result_diagnostics_quickfix", { open = true } },
      },
    }
  end,
  condition = {
    filetype = { "cpp", "c", "meson" },
  },
}
