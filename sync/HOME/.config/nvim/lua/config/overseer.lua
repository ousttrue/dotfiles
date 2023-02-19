local M = {}

function M.setup()
  local overseer = require("overseer")
  ---@diagnostic disable-next-line
  overseer.setup {
    templates = {
      "builtin",
      "user.cpp_build",
      "user.cpp_configure",
      "user.cpp_reconfigure",
    }
  }
  vim.keymap.set("n", "<F7>", ":OverseerRun<CR>", { noremap = true })
end

return M
