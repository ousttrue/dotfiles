return {
  cmd = {
    vim.fn.exepath "remark-language-server",
    "--stdio",
  },
  remark = {
    requireConfig = false,
  },
}
