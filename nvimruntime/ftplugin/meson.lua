-- for subdir('dir')
vim.bo.suffixesadd = "/meson.build"

require("errorformat_util").meson()
