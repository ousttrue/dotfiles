local M = {}

function M.setup()
  if vim.fn.has "win32" == 1 then
    vim.api.nvim_set_var("floaterm_shell", "pwsh.exe")
  end
  vim.keymap.set("n", "<F12>", "<cmd>FloatermToggle<CR>", {})
  vim.keymap.set("t", "<F12>", "<cmd>FloatermToggle<CR>", { noremap = true })
end

return M
