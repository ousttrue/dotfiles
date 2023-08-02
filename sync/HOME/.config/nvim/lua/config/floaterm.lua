local M = {}

function M.setup()
  -- if vim.fn.has "win32" == 1 then
  --   -- vim.api.nvim_set_var("floaterm_shell", "pwsh.exe")
  --   vim.api.nvim_set_var("floaterm_shell", "nyagos.exe")
  -- end
  vim.api.nvim_set_var("floaterm_shell", "nu")
  vim.api.nvim_set_var('floaterm_width', 0.99)
  vim.api.nvim_set_var('floaterm_height', 0.99)
  vim.keymap.set("n", "<F12>", "<cmd>FloatermToggle<CR>", {})
  vim.keymap.set("t", "<F12>", "<cmd>FloatermToggle<CR>", { noremap = true })
  vim.keymap.set("n", "<F9>", "<cmd>FloatermToggle<CR>", {})
  vim.keymap.set("t", "<F9>", "<cmd>FloatermToggle<CR>", { noremap = true })
end

return M
