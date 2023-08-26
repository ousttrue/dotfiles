local M = {}
local V = require "vars"
local U = require "my_util"

local cm_str = require "common.string"
local cm = require "common"
local sys_name = cm.get_system()

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

local function get_git_branch()
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

local function get_git_status()
  local git_status = U.eval("git", "status", "--porcelain", "--branch")
  local lines = cm_str.split(git_status, "\n")
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

local function get_current()
  -- local current = "$P"
  local current = string.gsub(nyagos.getwd(), "\\", "/")

  -- gibhub
  local github = "/ghq/github.com/"
  local found = string.find(current, github, 1, true)
  if found then
    return " /" .. string.sub(current, found + #github)
  else
    return "$P"
  end
end

function M.prompt2(_)
  -- error check
  local error = false
  if nyagos.env.ERRORLEVEL and nyagos.env.ERRORLEVEL ~= "0" then
    error = true
  end

  -- start
  local start = sys_name == "windows" and "red" or "blue"
  local sep = new_sep(start)

  -- path
  local prefix = sys_name == "windows" and "🐱" or "🐧"
  local current = get_current()
  local prompt = "$e[0m" .. fg_bg_attr(V.fg.white, V.bg[start]) .. prefix .. "$s" .. current

  -- git
  local git_branch = get_git_branch()
  if git_branch then
    local sync, git_status = get_git_status()
    prompt = prompt
      .. sep("white", "black")
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

  local error_color = error and "red" or "green"
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
