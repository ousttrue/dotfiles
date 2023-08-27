-- https://github.com/nyaosorg/nyagos/blob/master/docs/07-LuaFunctions_ja.md
local M = {}

local NYA = require "my_nyagos"
local STR = require "common.string"

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

  local NVIM = ""
  if nyagos.env.USERPROFILE then
    if nyagos.access(nyagos.env.USERPROFILE .. "/local/bin/nvim.exe", 4) then
      NVIM = nyagos.env.USERPROFILE .. "/local/bin/nvim.exe"
    elseif nyagos.access(nyagos.env.PROGRAMFILES .. "/Neovim/bin/nvim.exe", 4) then
      NVIM = nyagos.env.PROGRAMFILES .. "/Neovim/bin/nvim.exe"
    elseif nyagos.access(nyagos.env.LOCALAPPDATA .. "/Programs/Neovim/bin/nvim.exe", 4) then
      NVIM = nyagos.env.LOCALAPPDATA .. "/Programs/Neovim/bin/nvim.exe"
    end
  else
    NVIM = "nvim"
  end

  function nyagos.alias.nvim(args)
    return nyagos.rawexec(NVIM, unpack(args.rawargs))
  end
  function nyagos.alias.v(args)
    return nyagos.rawexec(NVIM, unpack(args.rawargs))
  end

  -- function nyagos.alias.ls(args)
  --   return NYA.raweval("lsd.exe", unpack(args.rawargs))
  -- end
  -- function nyagos.alias.la(args)
  --   return NYA.raweval("lsd.exe", "-a", unpack(args.rawargs))
  -- end
  -- function nyagos.alias.ll(args)
  --   return NYA.raweval("lsd.exe", "-al", unpack(args.rawargs))
  -- end

  local function search_history(this, is_prev)
    -- カーソル位置が一番左の場合は通常のnext/prev
    if this.pos == 1 then
      if is_prev == true then
        this:call "PREVIOUS_HISTORY"
      else
        this:call "NEXT_HISTORY"
      end
      this:call "BEGINNING_OF_LINE"
      return nil
    end

    -- 検索キーワード
    local search_string = this.text:sub(1, this.pos - 1)

    -- 重複を除いたhistoryリストの取得
    local history_uniq = {}
    local is_duplicated = false
    local hist_len = nyagos.gethistory()
    for i = 1, hist_len do
      local history
      -- 新しい履歴がリスト後ろに残るよう末尾からサーチ
      history = nyagos.gethistory(hist_len - i)
      for i, e in ipairs(history_uniq) do
        if history == e or history == search_string then
          is_duplicated = true
        end
      end
      if is_duplicated == false then
        if is_prev == true then
          table.insert(history_uniq, history)
        else
          table.insert(history_uniq, 1, history)
        end
      end
      is_duplicated = false
    end

    -- 入力と完全一致する履歴を探す
    -- 完全一致する履歴を起点にすることで
    -- (見かけ上)インクリメンタルな検索にする
    local hist_pos = 0
    for i, e in ipairs(history_uniq) do
      if e == this.text then
        hist_pos = i
        break
      end
    end

    -- 前方一致する履歴を探す
    local matched_string = nil
    for i = hist_pos + 1, #history_uniq do
      if history_uniq[i]:match("^" .. search_string .. ".*") then
        matched_string = history_uniq[i]
        break
      end
    end

    -- 見つかった履歴を出力
    -- 見つからなければ、検索キーワードを出力
    this:call "KILL_WHOLE_LINE"
    if matched_string ~= nil then
      this:insert(matched_string)
    else
      this:insert(search_string)
    end
    this:call "BEGINNING_OF_LINE"
    for i = 1, this.pos - 1 do
      this:call "FORWARD_CHAR"
    end
  end

  nyagos.bindkey("C_N", function(this)
    search_history(this, false)
  end)

  nyagos.bindkey("C_P", function(this)
    search_history(this, true)
  end)

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
  nyagos.envadd("PATH", "~/go/bin")
  nyagos.envadd("PATH", "~/.cargo/bin")
  nyagos.envadd("PATH", "~/local/bin")
  -- nyagos.envadd("PATH", "~/.local/share/aquaproj-aqua/bat")

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
end

return M
