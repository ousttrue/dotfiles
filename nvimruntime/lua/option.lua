local function setup()
  vim.opt.belloff = "all"
  vim.opt.hidden = true

  -- visual
  vim.opt.splitkeep = "screen"
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.list = true
  vim.opt.listchars = {
    eol = "$",
    tab = ">-",
    trail = "~",
    extends = ">",
    precedes = "<",
    conceal = "_",
  }
  -- vim.cmd[[set iskeyword-=_]]
  vim.opt.splitkeep = "screen"

  vim.opt.signcolumn = "yes" -- Always show sign column
  vim.opt.showtabline = 0
  -- vim.opt.laststatus = 3
  vim.opt.laststatus = 0
  vim.opt.cmdheight = 0
  vim.opt.number = false

  -- for tmux
  vim.opt.termguicolors = true -- Enable colors in terminal

  -- buffer
  vim.opt.fileformats = { "unix", "dos" }
end

return {
  setup = setup,
}
