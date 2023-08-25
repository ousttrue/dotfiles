local M = {}

local V = require "vars"
local U = require "my_util"

---@param fg string
---@param bg string
local function fg_bg_attr(fg, bg)
  return "$e[" .. fg .. ";" .. bg .. "m"
end

local SEP = ""
local function new_sep(init)
  local current = init
  ---@param bg string
  ---@param newfg string
  ---@return string
  return function(bg, newfg)
    local str = "$s" .. fg_bg_attr(V.fg[current], V.bg[bg]) .. SEP .. fg_bg_attr(V.fg[newfg], V.bg[bg]) .. "$s"
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

local function gitBranch()
  if U.has_git() then
    local branch = U.eval("git", "branch", "--show-current")
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

local function increment(t, k)
  if t[k] then
    t[k] = t[k] + 1
  else
    t[k] = 1
  end
end

local function gitStatus()
  local git_status = U.eval("git", "status", "--porcelain", "--branch")
  local lines = U.split(git_status, "\n")
  local sync_status, n = string.match(lines[1], "%[(%w+)%s+(%d+)%]")

  local sync = " "
  if sync_status == "behind" then
    sync = string.format(" %s", n)
  elseif sync_status == "ahead" then
    sync = string.format(" %s", n)
  end
  table.remove(lines, 1)

  local status = {}
  for _, v in ipairs(lines) do
    local k, _ = string.match(v, "%s*([^%s]+)%s+(.*)")
    if k then
      increment(status, string.sub(k, 1, 1))
    end
  end

  return sync, status
end

local git_status_map = {
  M = " ",
  A = " ",
  D = " ",
  R = " ",
  ["?"] = " ",
}

local org_prompter = nyagos.prompt
function M.prompt2(_)
  local error = false
  if nyagos.env.ERRORLEVEL and nyagos.env.ERRORLEVEL ~= '0' then
    error = true
  end

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
  local prompt = "$e[0m" .. fg_bg_attr(V.fg.white, V.bg[start]) .. get_prefix() .. "$s" .. current

  local git_branch = gitBranch()
  if git_branch then
    local sync, git_status = gitStatus()
    prompt = prompt
      .. sep("yellow", "black")
      .. " "
      .. git_branch
      .. sep("green", "black")
      .. U.eval("git", "log", "--pretty=format:%cr   %s", "-n", "1")
      .. sep("gray", "black")
      .. sync
    if next(git_status) then
      prompt = prompt .. "  "
      for _, k in ipairs { "M", "A", "D", "R", "C", "U", "?" } do
        if git_status[k] then
          local icon = k
          if git_status_map[k] then
            icon = git_status_map[k]
          end
          prompt = prompt .. string.format(" %s%d", icon, git_status[k])
        end
      end
    end
  end

  local error_color = "green"
  if error then
    error_color = "red"
  end

  prompt = prompt
    .. sep("default", "default")
    .. "$_" -- '\n'
    .. fg_bg_attr(V.fg[error_color], V.bg.default)
    .. ">"
    .. fg_bg_attr(V.fg.default, V.bg.default)
    .. "$s" -- 'space'
  return org_prompter(prompt)
end

return M
