[[lua]]
- [GitHub - lunarmodules/luasocket: Network support for the Lua language](https://github.com/lunarmodules/luasocket)

```lua
local socket = require("socket")

-- change here to the host an port you want to contact
local host, port = "localhost", 13
-- load namespace
-- convert host name to ip address
local ip = assert(socket.dns.toip(host))
-- create a new UDP object
local udp = assert(socket.udp())
-- contact daytime host
assert(udp:sendto("anything", ip, port))
-- retrieve the answer and print results
io.write(assert(udp:receive()))
```