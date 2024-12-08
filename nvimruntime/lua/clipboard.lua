local function setup()
  -- vim.opt.clipboard = "unnamedplus" -- Access system clipboard
  vim.opt.clipboard:append { "unnamedplus" }
  -- require xclip ? xsel ?
  vim.keymap.set({ "i", "c" }, "<S-Insert>", "<C-R>+", { noremap = true })
  vim.keymap.set({ "n" }, "<S-Insert>", "p", { noremap = true })
end

return {
  setup = setup,
}
