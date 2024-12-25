-- local version = _VERSION:match("%d+%.%d+")
package.path = ([[%s/dotfiles/nvimruntime/lua/?.lua;%s/nvim-data/lazy/utf8.nvim/lua/?.lua;]]):format(
  os.getenv "USERPROFILE",
  os.getenv "LOCALAPPDATA"
) .. package.path

print(package.path)
