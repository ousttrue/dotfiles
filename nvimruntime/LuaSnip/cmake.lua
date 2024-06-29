local dot = require "dot"
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
      t(dot.split(CMAKE_LISTS, "\n")),
    }
  ),
}
