local M = {}

local list = [[
lua-shop.ocnk.net
seekersport.co.jp
e-words.jp
and-engineer.com
www.geekly.co.jp
www.udemy.com
techsuite.biz
openstandia.jp
web-camp.io
dotinstall.com
www.pythonic-exam.com
www.python.jp
www.skillupai.com
hnavi.co.jp
www.internetacademy.jp
www.teradata.jp
www.rd.ntt
cacco.co.jp
basixs.com
online.dhw.co.jp
udemy.benesse.co.jp
geechs-job.com
www.blender.jp
]]

local HOSTS = {}
for x in list:gmatch "%S+" do
  HOSTS[x] = true
end

---@param url string
---@return boolean?
function M.skip_url(url)
  local host = url:match "https?://([^/]*)"
  if HOSTS[host] then
    return true
  end
end

return M
