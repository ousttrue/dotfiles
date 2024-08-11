local M = {}

function get_muon()
  -- if vim.fn.has "win32" == 1 then
  --   return "D:\\msys64\\usr\\bin\\muon.exe"
  -- else
  return "muon"
  -- end
end

function get_clang_format()
  if vim.fn.has "win32" == 1 then
    return "C:/Program Files/LLVM/bin/clang-format.exe"
  else
    return "clang-format"
  end
end

local uv = vim.loop

-- .. "/.vscode/extensions/ms-dotnettools.csharp-1.25.4-win32-x64/.omnisharp/1.39.4-net6.0/OmniSharp.dll",
local function enum_dir(dir)
  local t = {}
  local d = uv.fs_scandir(dir)
  if d then
    while true do
      local fs = uv.fs_scandir_next(d)
      if not fs then
        break
      end
      table.insert(t, fs)
    end
  end
  return t
end

-- return "C:/Program Files/tidy 5.8.0/bin/tidy.exe"
function get_tidy()
  if vim.fn.has "win32" == 1 then
    local where = "C:/Program Files"
    for i, e in ipairs(enum_dir(where)) do
      if string.find(e, "^tidy") then
        local ret = where .. "/" .. e .. "/bin/tidy.exe"
        return ret
      end
    end
  else
    return "clang-format"
  end
end

function M.setup()
  local null_ls = require "null-ls"
  local helpers = require "null-ls.helpers"

  ---@param client table
  ---@param bufnr number
  local function on_attach(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    if filetype == "meson" then
      vim.keymap.set({ "n", "v" }, "F", vim.lsp.buf.format, { buffer = bufnr, noremap = true })
    end
  end

  null_ls.setup {
    diagnostics_format = "[#{s}] #{c}\n#{m}",
    -- border = dot.border,
    -- debug = true,
    sources = {
      -- null_ls.builtins.formatting.csharpier,
      null_ls.builtins.formatting.rufo,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.uncrustify.with {
        filetypes = { "vala" },
      },
      -- null_ls.builtins.formatting.xmlformat,
      -- null_ls.builtins.formatting.cmake_format,
      --
      null_ls.builtins.formatting.prettierd.with {
        filetypes = { "xml","xml",  "html", "markdown", "mdx", "css" },
      },
      -- null_ls.builtins.formatting.tidy,
      null_ls.builtins.formatting.shfmt.with {
        filetypes = { "sh", "zsh" },
      },
      null_ls.builtins.formatting.clang_format.with {
        command = get_clang_format(),
        filetypes = { "glsl" },
      },
      null_ls.builtins.diagnostics.glslc.with {
        -- use opengl instead of vulkan1.0
        extra_args = { "--target-env=opengl" },
      },
      -- null_ls.builtins.formatting.topiary,

      -- null_ls.builtins.diagnostics.eslint,
      -- null_ls.builtins.diagnostics.eslint.with {
      --   prefer_local = "node_modules/.bin", --プロジェクトローカルがある場合はそれを利用
      -- },
      -- npm install -g textlint textlint-rule-prh textlint-rule-preset-jtf-style textlint-rule-preset-ja-technical-writing textlint-rule-terminology textlint-rule-preset-ja-spacing
      -- null_ls.builtins.diagnostics.textlint.with {
      --   filetypes = { "markdown" },
      -- },
      -- null_ls.builtins.diagnostics.markdownlint,
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1256
      -- https://blog.aoirint.com/entry/2023/markdownlint_cli2/
      -- null_ls.builtins.diagnostics.markdownlint_cli2.with {
      --   args = { "$FILENAME" },
      -- },
    },
    on_attach = on_attach,
  }

  --
  -- muon
  --
  null_ls.register {
    method = null_ls.methods.FORMATTING,
    name = "muon_fmt",
    filetypes = { "meson" },
    generator = null_ls.formatter {
      command = get_muon(),
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
      command = get_muon(),
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

  --
  -- dotnet format
  --
  null_ls.register {
    method = null_ls.methods.FORMATTING,
    name = "dotnet_fmt",
    filetypes = { "cs" },
    generator = null_ls.formatter {
      command = { "dotnet" },
      args = {
        "format",
        "whitespace",
        "--folder",
        "--include",
        "$FILENAME",
      },
      to_stdin = false,
      to_temp_file = true,
      from_temp_file = true,
    },
  }

  --
  -- zig format
  --
  null_ls.register {
    method = null_ls.methods.FORMATTING,
    name = "zig_fmt",
    filetypes = { "zig" },
    generator = null_ls.formatter {
      command = { "zig" },
      args = {
        "fmt",
        "$FILENAME",
      },
      to_stdin = false,
      to_temp_file = true,
      from_temp_file = true,
    },
  }
end

return M
