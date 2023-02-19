local M = {}

function M.setup()
  local overseer = require("overseer")
  ---@diagnostic disable-next-line
  overseer.setup {
    templates = {
      "builtin",
      "user.cpp_build",
      "user.cpp_configure",
    }
  }
  vim.keymap.set("n", "<C-B>", ":OverseerRun<CR>", { noremap = true })
end

return M
