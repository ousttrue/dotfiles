-- https://github.com/nyaosorg/nyagos/blob/master/docs/07-LuaFunctions_ja.md
local M = {}

local NYA = require "nya.util"
local COM = require "common"
local STR = require "common.string"
local PATH = require "common.path"

local system_name = COM.get_system()
local HOME = PATH.get_home()

local function to_path(src)
  if system_name == "windows" then
    return string.gsub(src, "/", "\\")
  else
    return string.gsub(src, "\\", "/")
  end
end

local function get_nvim()
  local list = {}
  if nyagos.env.USERPROFILE then
    table.insert(list, nyagos.env.USERPROFILE .. "/local/bin/nvim.exe")
    table.insert(list, nyagos.env.USERPROFILE .. "/neovim/bin/nvim.exe")
    table.insert(list, nyagos.env.PROGRAMFILES .. "/Neovim/bin/nvim.exe")
  end
  if nyagos.env.LOCALAPPDATA then
    table.insert(list, nyagos.env.LOCALAPPDATA .. "/Programs/Neovim/bin/nvim.exe")
  end
  if nyagos.env.HOME then
    table.insert(list, nyagos.env.HOME .. "/local/bin/nvim")
  end

  for _, v in ipairs(list) do
    if NYA.is_exists(v) then
      return v
    end
  end
end

local function setup_path()
  if nyagos.env.USERPROFILE then
    if nyagos.stat "C:/Python310/python.exe" then
      nyagos.envadd("PATH", "C:\\Python310\\Scripts")
    end
    if nyagos.stat "C:/Python311/python.exe" then
      nyagos.envadd("PATH", "C:\\Python311\\Scripts")
    end
    -- nyagos.envadd("PATH", "C:\\Program Files\\Git\\usr\\bin")
    -- muon
    -- nyagos.envadd("PATH", "D:\\msys64\\usr\\bin")
    -- zig
    -- nyagos.envadd("PATH", nyagos.env.USERPROFILE .. "\\local\\src\\zig-windows-x86_64-0.11.0-dev.1969+d525ecb52")
    nyagos.envadd("PATH", nyagos.env.USERPROFILE .. "\\local\\src\\zig-windows-x86_64-0.11.0-dev.2196+bc0f24691")
  end
  nyagos.envadd("PATH", to_path(HOME .. "/build/zig/bin"))
  nyagos.envadd("PATH", to_path(HOME .. "/go/bin"))
  nyagos.envadd("PATH", to_path(HOME .. "/.cargo/bin"))
  nyagos.envadd("PATH", to_path(HOME .. "/local/bin"))
  nyagos.envadd("PATH", to_path(HOME .. "/.local/bin"))
  -- nyagos.envadd("PATH", "~/.local/share/aquaproj-aqua/bat")
  local DEL_PATH = {
    "Oculus",
    "TortoiseGit",
    "PATH",
    "WindowsApp",
    "PhysX",
    "Skype",
    "Wbem",
    -- "PowerShell",
    "OpenSSH",
    "Microsoft VS Code",
    -- "dotnet",
    "sql",
    -- "nodejs",
    "deno",
    -- "npm",
    "Microsoft",
  }
  nyagos.envdel("PATH", unpack(DEL_PATH))
end

local function setup_alias()
  nyagos.alias.fzf = "~/.fzf/bin/fzf $*"
  nyagos.env.FZF_DEFAULT_OPTS = "--layout=reverse"

  function nyagos.alias.gg()
    local root = NYA.raweval("ghq", "root")
    local result = NYA.evalf('ghq list|fzf --preview="bat %s/{}/README.md --color=always --style=header,grid"', root)
    if #result > 0 then
      NYA.evalf('cd "%s/%s"', root, result)
    end
  end

  function nyagos.alias.gs()
    local result = NYA.evalf "git branch|fzf"
    if #result > 0 then
      nyagos.eval("git switch " .. result)
    end
  end

  function nyagos.alias.gst()
    local result = NYA.evalf "git tag| fzf"
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
    local result = NYA.evalf 'meson wrap list| fzf --preview "meson wrap info {}"'
    if #result > 0 then
      nyagos.exec("meson wrap install " .. result)
    end
  end

  function nyagos.alias.fpkg(args)
    local result = NYA.evalf 'apt list | cut -d "/" -f 1 | fzf --preview "apt-cache show {}"'
    if #result > 0 then
      nyagos.exec("sudo apt install " .. result)
    end
  end

  function nyagos.alias.fapu(args)
    local result = NYA.evalf 'apt-cache pkgnames | fzf --preview "apt-cache show {}"'
    if #result > 0 then
      nyagos.exec("sudo apt uninstall " .. result)
    end
  end

  local NVIM = get_nvim()
  if NVIM then
    nyagos.alias.nvim = NVIM .. " $*"
    nyagos.alias.v = NVIM .. " $*"
  else
    nyagos.alias.v = "nvim $*"
  end

  if NYA.which "exa" then
    nyagos.alias.ls = "exa --color=auto --icons $*"
    nyagos.alias.la = "exa --color=auto --icons -a $*"
    nyagos.alias.ll = "exa --color=auto --icons -al $*"
  elseif NYA.which "lsd" then
    nyagos.alias.ls = "lsd.exe $*"
    nyagos.alias.la = "lsd.exe -a $*"
    nyagos.alias.ll = "lsd.exe -al $*"
  elseif NYA.which "lsd" then
  else
    nyagos.alias.la = "ls -a $*"
    nyagos.alias.ll = "ll -l $*"
  end

  if not NYA.which "tig" then
    nyagos.alias.tig = '"C:/Program Files/Git/usr/bin/tig" $*'
  end

  local BUSYBOX_TOOLS = {
    "cp",
    "mv",
    "rm",
    "mkdir",
    "xz",
    "ln",
    "tr",
  }
  for _, v in ipairs(BUSYBOX_TOOLS) do
    local has, status = NYA.which(v)
    if not has then
      local alt = string.format("~/busybox/%s", v)
      if NYA.which(alt) then
        nyagos.alias[v] = string.format("%s $*", alt)
      end
    end
  end

  function nyagos.alias.pipup(args)
    nyagos.eval "py -m pip install pip --upgerade"
  end

  if not NYA.which "code" then
    nyagos.alias.code = '"%LOCALAPPDATA%\\Programs\\Microsoft Vs Code\\bin\\code" $*'
  end

  function nyagos.alias.print_args(args)
    print(args)
    print(#args, args[0])
    for i, v in ipairs(args) do
      print(i, v)
    end
    print("unpack", unpack(args.rawargs))
  end

  local DEL = system_name == "windows" and ";" or ":"

  function nyagos.alias.path(args)
    local cmd = unpack(args.rawargs)
    if cmd == "list" then
      for _, v in ipairs(STR.split(nyagos.env.PATH, DEL)) do
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

  function nyagos.alias.dot(args)
    local cmd = unpack(args.rawargs)
    local dot_dir = HOME .. "/dotfiles"
    if cmd == "pull" then
      return NYA.batch(dot_dir, {
        "git pull",
        -- doit
      })
    elseif cmd == "push" then
      return NYA.batch(dot_dir, {
        "git add .",
        "git commit -av",
        "git push",
      })
    elseif cmd == "status" then
      return NYA.batch(dot_dir, {
        "git status",
      })
    else
      print("unknown:", cmd)
      return 1
    end
  end
end

function M.setup()
  if COM.get_system() == "windows" then
    -- https://learn.microsoft.com/ja-jp/windows-server/administration/windows-commands/chcp
    if not NYA.evalf("chcp"):match "65001" then
      -- utf-8 mode
      NYA.evalf "chcp 65001"
    end
  end

  setup_path()
  setup_alias()
  -- use "git.lua"
  nyagos.skk {
    user = "~/.go-skk-jisyo", -- ユーザ辞書
    "~/.skk/SKK-JISYO.L", -- システム辞書(ラージ)
    "~/.skk/SKK-JISYO.emoji", -- システム辞書(絵文字)
  }
  require("nya.history").setup()
  require("nya.completion").setup()
  require("nya.zoxide").setup()
  require("nya.dotfiles").setup()
  nyagos.prompt = require("nya.prompt").prompt
end

return M
