M = {}

M.setup = function()
  local dap = require "dap"
  local dot_util = require('dot_util')

  --
  --  lldb
  --
  -- https://zenn.dev/saito9/articles/32c57f776dc369
  --
  -- codelldb is executable with tcp connection
  dap.adapters.lldb = function(callback, config)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 13000
    local opts = {
      stdio = { nil, stdout },
      args = { "--port", port },
      detached = true,
    }
    local exe = dot_util.get_home() .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb.exe"
    handle, pid_or_err = vim.loop.spawn(exe, opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print("codelldb exited with code", code)
      end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(function()
      callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
  end

  --
  --  cppvsdbg
  --
  dap.adapters.cppvsdbg = {
    id = 'cppvsdbg',
    type = 'executable',
    command = dot_util.get_home() .. '/.vscode/extensions/ms-vscode.cpptools-1.14.3-win32-x64/debugAdapters/vsdbg/bin/vsdbg.exe',
  }

  --
  -- keymap
  --
  vim.keymap.set("n", "<F5>", function()
    require("dap.ext.vscode").load_launchjs(nil, {
      lldb = { "c", "cpp" },
      cppvsdbg = { "c", "cpp" },
    })
    require("dapui").open()
    vim.cmd("<cmd>DapContinue<CR>")
  end, { silent = true })

  vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<F11>", ":DapStepInto<CR>", { silent = true })
  -- vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "gb", ":DapToggleBreakpoint<CR>", { silent = true })
  vim.api.nvim_set_keymap(
    "n",
    "gB",
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>',
    { silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>lp",
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    { silent = true }
  )
  vim.api.nvim_set_keymap("n", "<leader>dr", ':lua require("dap").repl.open()<CR>', { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>dl", ':lua require("dap").run_last()<CR>', { silent = true })

  vim.fn.sign_define("DapBreakpoint", { text = "⛔", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })

  require("dapui").setup {
    icons = { expanded = "", collapsed = "" },
    layouts = {
      {
        elements = {
          -- { id = "watches", size = 0.20 },
          { id = "stacks", size = 30 },
          -- { id = "breakpoints", size = 0.20 },
          { id = "scopes", size = 30 },
        },
        size = 64,
        position = "right",
      },
      -- {
      --   elements = {
      --     "repl",
      --     "console",
      --   },
      --   size = 0.20,
      --   position = "bottom",
      -- },
    },
  }

  require("dap").listeners.before["event_initialized"]["custom"] = function(session, body)
    require("dapui").open()
  end
end

return M
