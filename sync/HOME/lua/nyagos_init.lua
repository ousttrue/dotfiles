-- https://github.com/nyaosorg/nyagos/blob/master/docs/07-LuaFunctions_ja.md
local M = {}

local NYA = require "my_nyagos"
local STR = require "common.string"

use "git.lua"

function M.setup()
  -- nyagos.alias {
  --   -- clear = "cls",
  --   -- ll = "ls -la $*",
  --   rm = "del $*",
  --   mv = "move $*",
  --   cp = "copy $*",
  -- }
  --

  nyagos.skk {
    user = "~/.go-skk-jisyo", -- ユーザ辞書
    "~/skk/SKK-JISYO.L", -- システム辞書(ラージ)
    "~/skk/SKK-JISYO.emoji", -- システム辞書(絵文字)
  }

  require("zoxide").setup()

  -- nyagos.env.prompt = "$L" .. nyagos.getenv "COMPUTERNAME" .. ":$P$G"
  -- set {
  --   PROMPT = "$P",
  -- }

  nyagos.alias.fzf = "~/.fzf/bin/fzf $*"
  nyagos.env.FZF_DEFAULT_OPTS = "--layout=reverse"

  function nyagos.alias.gg()
    local result = NYA.evalf "ghq list|fzf"
    if #result > 0 then
      local root = NYA.raweval("ghq", "root")
      NYA.evalf('cd "%s/%s"', root, result)
    end
  end

  function nyagos.alias.gs()
    local result = STR.trim(nyagos.eval "git branch|fzf")
    if #result > 0 then
      nyagos.eval("git switch " .. result)
    end
  end

  function nyagos.alias.gst()
    local result = STR.trim(nyagos.eval "git tag| fzf")
    if #result > 0 then
      nyagos.eval("git switch -c branch_" .. result .. " " .. result)
    end
  end

  function nyagos.alias.gt()
    nyagos.exec "git status"
  end

  function nyagos.alias.r()
    local root = NYA.raweval("git", "rev-parse", "--show-toplevel")
    if root then
      nyagos.exec("cd " .. root)
    end
  end

  function nyagos.alias.mewrap(args)
    local result = nyagos.eval 'meson wrap list| fzf --preview "meson wrap info {}"'
    if result then
      nyagos.exec("meson wrap install " .. result)
    end
  end

  function nyagos.alias.tig(args)
    nyagos.exec '"C:/Program Files/Git/usr/bin/tig"'
  end

  local NVIM = "nvim"
  for _, v in ipairs {
    nyagos.env.USERPROFILE .. "/local/bin/nvim.exe",
    nyagos.env.PROGRAMFILES .. "/Neovim/bin/nvim.exe",
    nyagos.env.LOCALAPPDATA .. "/Programs/Neovim/bin/nvim.exe",
    nyagos.env.USERPROFILE .. "/neovim/bin/nvim.exe",
  } do
    if nyagos.access(v, 4) then
      NVIM = v
      break
    end
  end

  function nyagos.alias.nvim(args)
    return nyagos.rawexec(NVIM, unpack(args.rawargs))
  end
  function nyagos.alias.v(args)
    return nyagos.rawexec(NVIM, unpack(args.rawargs))
  end

  function nyagos.alias.ls(args)
    return nyagos.rawexec("lsd.exe", unpack(args.rawargs))
  end
  function nyagos.alias.la(args)
    return nyagos.rawexec("lsd.exe", "-a", unpack(args.rawargs))
  end
  function nyagos.alias.ll(args)
    return nyagos.rawexec("lsd.exe", "-al", unpack(args.rawargs))
  end

  -- nyagos.bindkey("C_P", function(this)
  --   search_history(this, true)
  -- end)

  function nyagos.alias.pipup(args)
    nyagos.eval "py -m pip install pip --upgerade"
  end

  if nyagos.env.USERPROFILE then
    nyagos.envadd("PATH", "C:\\Python310\\Scripts")
    nyagos.envadd("PATH", "C:\\Python311\\Scripts")
    -- nyagos.envadd("PATH", "C:\\Program Files\\Git\\usr\\bin")
    -- muon
    -- nyagos.envadd("PATH", "D:\\msys64\\usr\\bin")
    -- zig
    -- nyagos.envadd("PATH", nyagos.env.USERPROFILE .. "\\local\\src\\zig-windows-x86_64-0.11.0-dev.1969+d525ecb52")
    nyagos.envadd("PATH", nyagos.env.USERPROFILE .. "\\local\\src\\zig-windows-x86_64-0.11.0-dev.2196+bc0f24691")

    -- nyagos.eval 'source "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC/Auxiliary/Build/vcvars64.bat"'
    nyagos.eval "chcp 65001"
  end
  nyagos.envadd("PATH", "~\\go\\bin")
  nyagos.envadd("PATH", "~\\.cargo\\bin")
  nyagos.envadd("PATH", "~\\local\\bin")
  -- nyagos.envadd("PATH", "~/.local/share/aquaproj-aqua/bat")
  nyagos.envdel("PATH", "WindowsApp", "PhysX", "Skype", "Wbem", "PowerShell", "OpenSSH")
  nyagos.complete_for.git = require("completion_git").complete_for

  nyagos.prompt = require("prompt").prompt2

  function nyagos.alias.print_args(args)
    print(args)
    print(#args, args[0])
    for i, v in ipairs(args) do
      print(i, v)
    end
    print("unpack", unpack(args.rawargs))
  end

  function nyagos.alias.path(args)
    local cmd = unpack(args.rawargs)
    if cmd == "list" then
      for _, v in ipairs(STR.split(nyagos.env.PATH, ";")) do
        print(v)
      end
      -- return 0
    else
      print "unknown"
      return 1
    end
  end

  function nyagos.alias.toolchain()
    -- llvm + windows SDK
    local kits = "C:/Program Files (x86)/Windows Kits/10"
    local version = "10.0.22621.0"
    nyagos.env.WindowsSdkVersion = version
    nyagos.env.UCRTVersion = version
    nyagos.env.UCRTContentRoot = kits
    nyagos.env.UniversalCRTSdkDir = kits .. "/"
    nyagos.env.LIB = STR.join(";", {
      kits .. "lib/" .. version .. "/ucrt/x64",
      kits .. "lib/" .. version .. "/um/x64",
    })
    nyagos.env.INCLUDE = kits .. "/include/" .. version .. "/ucrt"
    -- nyagos.env.CMAKE_C_FLAGS = STR.join(" ", {
    --   string.format('-I"%s"', kits .. "/include/" .. version .. "/ucrt"),
    --   string.format('-I"%s"', kits .. "/include/" .. version .. "/shared"),
    --   string.format('-I"%s"', kits .. "/include/" .. version .. "/um"),
    -- })
  end

  require("nyagos_history").setup()
end

return M
