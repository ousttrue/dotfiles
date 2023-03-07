local M = {}
-- https://gist.github.com/tsuyoshicho/1e6288193047d782b576d8cf5bf9bc13

local function split(str, delim)
  local result = {}
  for i in string.gmatch(str, delim) do
    table.insert(result, i)
  end
  return result
end

local function getBranches()
  local src = nyagos.eval "git branch 2>NUL"
  if string.len(src) <= 0 then
    return nil
  end

  local branches = split(src, "[^\r\n]+")

  local result = ""
  for key, value in pairs(branches) do
    local branch = string.gsub(value, "^[%s]+", "")
    if string.sub(branch, 1, string.len "*") ~= "*" then
      result = result .. branch .. "\n"
    end
  end
  return result
end

-- https://gist.github.com/rcapraro/1b8003002ee47caa4b12
local function getBranch()
  local path = nyagos.getwd()
  repeat
    if nyagos.access(nyagos.pathjoin(path, ".git"), 0) then
      break
    end
    path = string.match(path, "^(.+)\\")
  until not path

  if path then
    local branch = string.match(nyagos.eval "git branch", "* ([%S ]*)")
    if branch then
      local ref = string.match(branch, "^%(detached from ([0-9a-f]+)%)$")
      if ref then
        return "(" .. ref .. "...)"
      else
        return branch
      end
    else
      return "no branch"
    end
  else
    return nil
  end
end

local org_prompter = nyagos.prompt
function M.prompt2(this)
  -- Gitのブランチ名をプロンプトに表示
  local git_branch = getBranch()
  if git_branch then
    git_branch = "$e[37;1m$e[33;50;1m(" .. git_branch .. ")$e[37;1m"
  else
    git_branch = ""
  end
  return org_prompter("$e[36;36;1m" .. this .. "$s" .. git_branch .. "$e[36;36;1m" .. "$_$$$s" .. "$e[37;1m")
end

------------------------------------------------
-- strをpatで分割しテーブルを返す
-- code from 'http://lua-users.org/wiki/SplitJoin'
local function split(str, pat)
  local t = {} -- NOTE: use {n = 0} in Lua-5.0
  local fpat = "(.-)" .. pat
  local last_end = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(t, cap)
    end
    last_end = e + 1
    s, e, cap = str:find(fpat, last_end)
  end
  if last_end <= #str then
    cap = str:sub(last_end)
    table.insert(t, cap)
  end
  return t
end

------------------------------------------------
-- srcの末尾から改行を取り除く
local function chomp(src)
  return string.gsub(src, "[\r\n]+$", "")
end

------------------------------------------------
-- 最下層nのディレクトリ名だけ表示する文字列生成
-- fix nyagos 4.0x api
local function getCompressedPath(num)
  local wd = nyagos.getwd()
  local env = nyagos.env
  local path = chomp(wd)
  local buff = path

  local drive = nil

  -- HOME以下の場合
  local home = env.home or env.userprofile
  if path:find(home) then
    drive = "~"
    path = path:gsub(home, "~")
    buff = path
  end
  -- 通常のドライブ
  if drive == nil then
    drive = buff:match "(%w+:)\\"
    buff = buff:gsub("%w+:\\", "")
  end
  -- UNCパス
  if drive == nil then
    drive = buff:match "(\\\\.-)\\"
    buff = buff:gsub("\\\\.-\\", "")
  end

  local tbl = split(buff, "[\\/]")
  if #tbl > num then
    buff = "/..."
    for i = #tbl - (num - 1), #tbl do
      buff = buff .. "/" .. tbl[i]
    end
    path = drive .. buff
  end

  return path
end

------------------------------------------------
-- エスケープシーケンスを削除
local function removeEscapeSequence(src)
  -- FIXME : なぜか'$e%[(%d+;)+1m'でマッチしない
  return src:gsub("$e%[%d+;%d+;1m", ""):gsub("$e%[%d+;1m", "")
end
------------------------------------------------
-- 文字列の幅を取得
-- 半角文字:1, 全角文字:2 にカウント
local function getStringWidth(src)
  local width = 0
  for p, c in utf8.codes(src) do
    if 0 ~= bit32.band(c, 0x7FFFFF80) then
      if 0xFF61 <= c and c <= 0xFF9F then
        width = width + 1
      else
        width = width + 2
      end
    else
      width = width + 1
    end
  end
  return width
end

------------------------------------------------
-- PROMPT生成部分
-- branch name append
local function makePrompt(pathBlock)
  local prompt = ""
  if pathBlock ~= "" then
    prompt = pathBlock
  else
    prompt = "$e[30;40;1m[" .. getCompressedPath(3):gsub("\\", "/") .. "]$e[37;1m"
  end
  local hgbranch = nyagos.eval "hg branch 2> nul"
  local gitbranch = nyagos.eval "git rev-parse --abbrev-ref HEAD 2> nul"
  local rprompt = ""
  if hgbranch ~= "" then
    rprompt = rprompt .. "$e[30;40;1m[$e[33;40;1m" .. hgbranch .. "$e[30;40;1m]$e[37;1m"
  end
  if gitbranch ~= "" then
    rprompt = rprompt .. "$e[30;40;1m[$e[33;40;1m" .. gitbranch .. "$e[30;40;1m]$e[37;1m"
  end
  local pad = nyagos.getviewwidth() - getStringWidth(removeEscapeSequence(prompt .. rprompt))
  for i = 1, pad - 1 do
    prompt = prompt .. " "
  end
  return prompt .. rprompt .. "\n$ "
end

function M.prompt(this)
  -- path,title,prompt
  local path = getCompressedPath(3):gsub("\\", "/")
  local title = ""

  local pathBlock = ""
  if nyagos.elevated() then
    title = path .. " - NYAGOS(admin)"
    pathBlock = "$e[30;40;1m[$e[40;31;1m" .. path .. "$e[30;40;1m]$e[37;1m"
  else
    title = path .. " - NYAGOS"
    pathBlock = "$e[30;40;1m[$e[40;36;1m" .. path .. "$e[30;40;1m]$e[37;1m"
  end

  return nyagos.default_prompt(makePrompt(pathBlock), title)
end

return M
