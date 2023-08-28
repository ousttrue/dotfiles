local M = {
  env = {
    "LUA_HOME",
    "XDG_XONFIG_HOME",
  },
  download = {
    ["~/.skk/SKK-JISYO.L"] = "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L",
    ["~/.skk/SKK-JISYO.emoji"] = "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.emoji",
    -- font: HackgenNerd
    -- zig
    -- fzf
    -- busybox64
  },
  build = {
    -- nvim
    -- chafa
    -- gtk4
    -- gstreamer
  },
  go = {
    -- ghq
    -- lazygit
  },
  cargo = {
    -- zoxide
    -- exa
    -- lsd
  },
}

local NYA = require "nya.util"
local ES = require "common.escape_seuquence"

function M.setup()
  function nyagos.alias.dotfile(args)
    local cmd = unpack(args.rawargs)
    -- print(args.rawargs)
    if cmd == "download" then
      for k, v in pairs(M.download) do
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
