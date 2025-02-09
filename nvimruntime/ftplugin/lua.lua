vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 120

local function is_lazy_config()
  -- https://zenn.dev/kenkenlysh/articles/9d6d8c40229d55
  local absolute_file_path = vim.api.nvim_buf_get_name(0)
  local git_path = vim.fn.system "git rev-parse --show-toplevel"
  local relative_file_path = "/" .. string.sub(absolute_file_path, git_path:len() + 1)

  local m = relative_file_path:match "^/nvimruntime/lua/lazy_plugins/(%d+_[^/]*.lua)$"
  if m then
    return true
  end
end

if is_lazy_config() then
  vim.keymap.set("n", "gx", function()
    local cfile = vim.fn.expand "<cfile>"
    if cfile:match "^[^/]*/[^/]*$" then
      local url = "https://github.com/" .. cfile
      print(url)
      vim.ui.open(url)
    else
      vim.ui.open(cfile)
    end
  end, { buffer = 0, noremap = true, silent = true })
end

vim.opt.errorformat = vim.fn.join({
  -- ./lua\lkk\input_spec.lua:1: module 'lkk.context' not found:
  "%f:%l: %m",
}, ",")
