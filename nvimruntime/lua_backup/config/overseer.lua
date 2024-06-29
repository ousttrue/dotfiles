local M = {}

function M.setup()
  local overseer = require "overseer"
  local dot = require "dot"

  ---@diagnostic disable-next-line
  overseer.setup {
    -- strategy = {
    --   "toggleterm",
    --   -- load your default shell before starting the task
    --   use_shell = false,
    --   -- overwrite the default toggleterm "direction" parameter
    --   direction = nil,
    --   -- overwrite the default toggleterm "highlights" parameter
    --   highlights = nil,
    --   -- overwrite the default toggleterm "auto_scroll" parameter
    --   auto_scroll = nil,
    --   -- have the toggleterm window close automatically after the task exits
    --   close_on_exit = false,
    --   -- open the toggleterm window when a task starts
    --   open_on_start = true,
    --   -- mirrors the toggleterm "hidden" parameter, and keeps the task from
    --   -- being rendered in the toggleable window
    --   hidden = false,
    -- },
    form = {
      border = dot.border,
    },
    confirm = {
      border = dot.border,
    },
    task_win = {
      border = dot.border,
    },
    templates = {
      "builtin",
      "user.cpp_build",
      "user.cpp_configure",
      "user.cpp_reconfigure",
      "user.go_run",
    },
  }

  vim.keymap.set("n", "<Leader>o", "<cmd>OverseerToggle<CR>")
  --   vim.keymap.set("n", "<F7>", function()
  --     vim.cmd [[
  -- :OverseerRun
  -- " :OverseerOpen
  --     ]]
  --   end, { noremap = true })
end

return M
