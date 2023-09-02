local M = {}
M.list = {
  "Afterglow",
  "Atelier Dune Light (base16)",
  "Azu (Gogh)",
  "Belafonte Day",
  "Black Metal (base16)",
  "carbonfox",
  "Ciapre",
  "DimmedMonokai",
  "Fahrenheit",
  "ForestBlue",
  "Green Screen (base16)",
  "Hacktober",
  "idleToes",
  "Man Page",
  "MonaLisa",
  "N0tch2k",
  "nightfox",
  "Operator Mono Dark",
  "Relaxed",
  "Royal",
  "Seafoam Pastel",
  "SeaShells",
  "vimbones",
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
