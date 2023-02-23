local M = {}

function M.setup()
  local null_ls = require "null-ls"
  local helpers = require "null-ls.helpers"
  local dot = require "dot_util"

  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    if filetype == "meson" then
      vim.keymap.set({ "n", "v" }, "F", vim.lsp.buf.format, { buffer = bufnr, noremap = true })
    end
  end

  null_ls.setup {
    border = dot.border,
    -- debug = true,
    sources = {
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.yapf,
      -- null_ls.builtins.formatting.cmake_format,
    },
    on_attach = on_attach,
  }

  null_ls.register {
    method = null_ls.methods.FORMATTING,
    name = "muon_fmt",
    filetypes = { "meson" },
    generator = null_ls.formatter {
      command = "muon",
      args = {
        "fmt",
        "-i",
        "$FILENAME",
      },
      to_stdin = false,
      to_temp_file = true,
      from_temp_file = true,
    },
  }

  null_ls.register {
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    name = "muon_analyze",
    filetypes = { "meson" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator {
      multiple_files = true,
      command = "muon",
      args = { "analyze", "-O", "-l" },
      to_stdin = true,
      from_stderr = true,
      -- choose an output format (raw, json, or line)
      format = "line",
      -- check_exit_code = function(code, stderr)
      --   local success = code <= 1
      --
      --   if not success then
      --     -- can be noisy for things that run often (e.g. diagnostics), but can
      --     -- be useful for things that run on demand (e.g. formatting)
      --     print(stderr)
      --   end
      --
      --   return success
      -- end,
      -- use helpers to parse the output from string matchers,
      -- or parse it manually with a function
      -- /path/to/meson.build:1:15: error expected ')', got ','
      on_output = helpers.diagnostics.from_patterns {
        {
          pattern = [[([^:]+):(%d+):(%d+): (%w+) (.*)]],
          groups = { "filename", "row", "col", "severity", "message" },
        },
      },
    },
  }
end

return M
