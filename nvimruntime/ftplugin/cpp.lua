vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.commentstring = "// %s"
vim.bo.smartindent = true

local function get_builddir()
  local dir = os.getenv "BUILDDIR" 
  if dir then
    return dir
  end
  return "builddir"
end

-- vim.o.errorformat = " %#%f(%l\\,%c): %m"
vim.o.makeprg = "cmake --build " .. get_builddir()
