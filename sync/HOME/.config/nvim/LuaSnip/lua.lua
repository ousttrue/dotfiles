local ls = require "luasnip"
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

-- Shorthand example: the same snippet as above, but only setting the `trig` param
s(
  "M", -- the snip_param table is replaced by a single string holding `trig`
  { -- Table 2: snippet nodes
    t [[local M={}

function M.setup()
end

return M]],
  }
)

-- Shorthand example: the same snippet as above, but only setting the `trig` param
s(
  "hi", -- the snip_param table is replaced by a single string holding `trig`
  { -- Table 2: snippet nodes
    t "Hello, world!",
  }
)

