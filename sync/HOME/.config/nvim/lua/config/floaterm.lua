local M = {}

function M.setup()
  -- local sys = require("dot").get_system()
  -- if sys == "msys" then
  --   vim.api.nvim_set_var("floaterm_shell", "bash")
  -- elseif sys == "windows" then
  --   vim.api.nvim_set_var("floaterm_shell", "nyagos.exe")
  -- else
  --   vim.api.nvim_set_var("floaterm_shell", "nu")
  -- end
  vim.api.nvim_set_var("floaterm_width", 0.99)
  vim.api.nvim_set_var("floaterm_height", 0.99)
  vim.keymap.set("n", "<F12>", "<cmd>FloatermToggle<CR>", {})
  vim.keymap.set("t", "<F12>", "<cmd>FloatermToggle<CR>", { noremap = true })
  vim.keymap.set("n", "<F9>", "<cmd>FloatermToggle<CR>", {})
  vim.keymap.set("t", "<F9>", "<cmd>FloatermToggle<CR>", { noremap = true })
end

return M
