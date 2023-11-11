local M = {}
M.list = {
  "Afterglow",
  "Black Metal (base16)",
  "carbonfox",
  "Ciapre",
  "DimmedMonokai",
  "Hacktober",
  "MonaLisa",
  "N0tch2k",
  "nightfox",
  "Operator Mono Dark",
  "Relaxed",
  "Seafoam Pastel",
  "SeaShells",
}

---@return string
function M.get(yday)
  return M.list[(yday % #M.list) + 1]
end

---@return string
function M.get_today()
  return M.get(os.date("*t")["yday"])
end

return M
