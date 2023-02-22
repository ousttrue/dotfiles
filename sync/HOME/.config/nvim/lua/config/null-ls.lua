local M = {}

function M.setup()
  local null_ls = require "null-ls"
  local helpers = require "null-ls.helpers"

  null_ls.setup {
    debug = true,
    sources = {
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.yapf,
      -- null_ls.builtins.formatting.cmake_format,
    },
  }

  local muon_diagnostics = {
    method = null_ls.methods.DIAGNOSTICS,
    name = "muon",
    filetypes = { "meson" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator {
      command = "muon",
      args = { "analyze", "-O", "-", "-l" },
      to_stdin = true,
      from_stderr = true,
      -- choose an output format (raw, json, or line)
      format = "line",
      check_exit_code = function(code, stderr)
        local success = code <= 1

        if not success then
          -- can be noisy for things that run often (e.g. diagnostics), but can
          -- be useful for things that run on demand (e.g. formatting)
          print(stderr)
        end

        return success
      end,
      -- use helpers to parse the output from string matchers,
      -- or parse it manually with a function
      -- /path/to/meson.build:1:15: error expected ')', got ','
      on_output = helpers.diagnostics.from_patterns {
        {
          pattern = [[:(%d+):(%d+): (.*)]],
          groups = { "row", "col", "message" },
        },
      },
    },
  }

  null_ls.register(muon_diagnostics)
end

return M
