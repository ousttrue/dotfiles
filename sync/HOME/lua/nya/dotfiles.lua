local M = {}

local NYA = require "nya.util"
local ES = require "common.escape_seuquence"

M.data = {
  ["~/.skk/SKK-JISYO.L"] = "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L",
  ["~/.skk/SKK-JISYO.emoji"] = "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.emoji",
}

function M.setup()
  function nyagos.alias.dotfile(args)
    local cmd = unpack(args.rawargs)
    -- print(args.rawargs)
    -- TODO: gum 使う
    if cmd == "data" then
      for k, v in pairs(M.data) do
        if NYA.is_exists(k) then
          nyagos.write(ES.format("%s: <green>OK<default>\n", k))
        else
          nyagos.write(ES.format("%s <red>=><default> %s\n", k, v))
        end
      end
    end
  end
end

return M
