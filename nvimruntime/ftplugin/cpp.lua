vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.commentstring = "// %s"
vim.bo.smartindent = true

require("errorformat_util").meson()

-- local gcc_fmt = "%f:%l:%c: %t%*[^:]: %m"
