local M = {}

local V = require "vars"
local util = require "util"

local SEP = ""

local function gitBranch()
  if util.has_git() then
    local branch = util.eval("git", "branch", "--show-current")
    if #branch > 0 then
      local ref = string.match(branch, "^%(detached from ([0-9a-f]+)%)$")
      if ref then
        return "(" .. ref .. "...)"
      else
        return branch
      end
    else
      return "no branch"
    end
  end
end

---@param fg string
---@param bg string
local function fg_bg_attr(fg, bg)
  local str = "$e[" .. fg .. ";" .. bg
  return str .. "m"
end

local function new_sep(init)
  local current = init
  ---@param bg string
  ---@param fg_right string
  ---@return string
  return function(bg, fg_right)
    local str = "$s" .. fg_bg_attr(V.fg[current], V.bg[bg]) .. SEP .. fg_bg_attr(fg_right, V.bg[bg]) .. "$s"
    current = bg
    return str
  end
end

local H = {
  "🐭",
  "🐮",
  "🐯",
  "🐰",
  "🐉",
  "🐍",
  "🐴",
  "🐏",
  "🐒",
  "🐔",
  "🐶",
  "🐗",
}
local F = {
  "一",
  "二",
  "三",
  "四",
}

local function get_prefix()
  local now = os.date "*t"
  local min = now["hour"] * 60 + now["min"]
  local hour = (now["hour"] + 1 % 24)
  local index12 = math.floor(hour / 2)
  local index = math.floor(min / 30)
  -- return H[(index12 % #H) + 1]
  -- return string.format("%02d", index12)
  return "🐱"
  -- return " "
end

local function gitStatus()
  local git_status = util.eval("git", "status", "--porcelain", "--branch")
  local lines = util.split(git_status, "\n")
  return {
    sync = lines[1],
  }
end

local org_prompter = nyagos.prompt
function M.prompt2(this)
  -- local current = "$P"
  local current = string.gsub(nyagos.getwd(), "\\", "/")

  -- gibhub
  local github = "/ghq/github.com/"
  local found = string.find(current, github, 1, true)
  if found then
    current = " /" .. string.sub(current, found + #github)
  else
    current = "$P"
  end

  local start = "red"
  local sep = new_sep(start)
  local prompt = fg_bg_attr(V.fg.white, V.bg[start]) .. get_prefix() .. "$s" .. current

  local git_branch = gitBranch()
  if git_branch then
    local git_status = gitStatus()
    prompt = prompt
      .. sep("yellow", V.fg.black)
      .. " "
      .. git_branch
      .. sep("green", V.fg.black)
      .. util.eval("git", "log", "--pretty=format:%cr   %s", "-n", "1")
      .. git_status.sync
  end

  prompt = prompt .. sep("default", V.fg.default) .. "$_$$$s"
  return org_prompter(prompt)
end

return M
