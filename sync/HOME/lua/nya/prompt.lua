local NYA = require "nya.util"

local V = require "common.vars"
local STR = require "common.string"
local COM = require "common"
local SYS_NAME = COM.get_system()
local M = {
  title = SYS_NAME == "windows" and "🐱" or "🐧",
}
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
  if NYA.has_git() then
    local branch = NYA.raweval("git", "branch", "--show-current")
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
  local git_status = NYA.raweval("git", "status", "--porcelain", "--branch")
  local lines = STR.split(git_status, "\n")
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

-- local org_prompter = nyagos.prompt

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

---@param src string
---@return string
local function remove_escape_sequence(src)
  return src:gsub("$e%[%d+;%d+;1m", ""):gsub("$e%[%d+;1m", "")
end

-- https://github.com/aperezdc/lua-wcwidth
---@param src string
---@return integer
function get_string_width(src)
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

---@param str string
---@return integer
local function get_cols(str)
  -- local raw = remove_escape_sequence(str)
  return get_string_width(str)
end

---@param left string
---@param right string
---@return string
local function get_padding(left, right)
  local cols = nyagos.getviewwidth() - get_cols(left) - get_cols(right)
  local padding = ""
  for i = 1, cols do
    padding = padding .. " "
  end
  return padding
end

function M.prompt(this)
  -- error check
  local error = false
  if nyagos.env.ERRORLEVEL and nyagos.env.ERRORLEVEL ~= "0" then
    error = true
  end

  -- start
  local start = SYS_NAME == "windows" and "red" or "blue"
  local sep = new_sep(start)

  -- path
  local prefix = M.title
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
      .. NYA.raweval("git", "log", "--pretty=format:%cr   %s", "-n", "1")
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

  local left = prompt .. sep("default", "default")

  local right = "right"

  local padding = get_padding(left, right)

  prompt = left
    -- .. padding
    -- .. right
    .. "$_" -- '\n'
    .. fg_bg_attr(V.fg[error_color], V.bg.default)
    .. "%"
    .. fg_bg_attr(V.fg.default, V.bg.default)
    .. "$s" -- 'space'

  return nyagos.default_prompt(prompt, M.title)
end

return M
