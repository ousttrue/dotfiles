local function gfind(str, pattern)
  local from_idx = nil
  local to_idx = 0
  return function()
    from_idx, to_idx = string.find(str, pattern, to_idx + 1)
    return from_idx, to_idx
  end
end

local function split(str, pattern)
  local p = 1
  local result = {}

  for f, t in gfind(str, pattern) do
    table.insert(result, string.sub(str, p, f - 1))
    p = t + 1
  end
  table.insert(result, string.sub(str, p, -1))
  return result
end

local CMAKE_LISTS = [[# project
CMAKE_MINIMUM_REQUIRED(VERSION 3.14.0)
PROJECT(hello VERSION 0.1.0)

# target
ADD_EXECUTABLE(${PROJECT_NAME}
  main.cpp
)
]]

return {
  -- Shorthand example: the same snippet as above, but only setting the `trig` param
  s(
    "CM", -- the snip_param table is replaced by a single string holding `trig`
    { -- Table 2: snippet nodes
      t(split(CMAKE_LISTS, "\n")),
    }
  ),
}
