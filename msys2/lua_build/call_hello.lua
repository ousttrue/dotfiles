--
-- LUA_CPATH="prefix/bin/msys-?.dll" ./prefix/bin/lua.exe call_hello.lua
--
local M = require('hello')
-- print(M)
-- for k, v in pairs(M) do
--     print(k, v)
-- end
print(M.say_hello())

local lpeg = require('lpeg')
local cc = lpeg.Cc('error')
print(cc)

