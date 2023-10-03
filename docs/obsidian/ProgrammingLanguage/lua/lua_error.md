'can not change a protected metatable'

違う require 引き数で同じファイルを import すると起きる
```lua
require 'quat'
require 'Quat' -- <-- 大文字小文字

require 'quat'
require 'libs.quat' -- LUA_PATH でどっちでもいける
```
