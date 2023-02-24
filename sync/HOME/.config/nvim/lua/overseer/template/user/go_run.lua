return {
  name = "[go] run",
  builder = function()
    return {
      cmd = { "go" },
      args = { "run", "." },
      -- cwd = "builddir",
      components = {
        "default",
        -- {
        --
        --   "on_output_parse",
        --   parser = {
        --     -- Put the parser results into the 'diagnostics' field on the task result
        --     diagnostics = get_problem_matcher(),
        --   },
        -- },
        { "on_output_quickfix", open = true },
        -- "on_result_diagnostics",
        -- { "on_result_diagnostics_quickfix", {
        --   open = true,
        -- } },
      },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
