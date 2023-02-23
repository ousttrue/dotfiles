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

  vim.keymap.set("n", "<Leader>o", "<cmd>OverseerToggle<CR>")
  vim.keymap.set("n", "<F7>", function()
    vim.cmd [[
:OverseerRun
" :OverseerOpen
    ]]
  end, { noremap = true })
end

return M
