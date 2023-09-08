local PROMPT = require "nya.prompt"

local M = {
  env = {
    "LUA_HOME",
    "XDG_XONFIG_HOME",
  },
  downloads = {
    ["~/.skk/SKK-JISYO.L"] = "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L",
    ["~/.skk/SKK-JISYO.emoji"] = "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.emoji",
    -- font: HackgenNerd
    -- zig
    -- fzf
    -- busybox64
  },
  toolchains = {
    -- zapcc
    zig = {
      desc = "zig-0.11: clang-16",
      toolchain = "C:/zig",
      prefix = "~/build/zig",
      pkg_config_path = "{prefix}/lib/pkgconfig",
    },
    ["llvm-mingw-ucrt"] = "clang-mingw for ucrt",
    msvc19 = "vc2022",
    -- source "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC/Auxiliary/Build/vcvars64.bat"
    ["msys2-mingw64"] = "gcc for vcrt",
    ["msys2-ucrt64"] = "gcc for ucrt",
  },
  builds = {
    ["pkgconf"] = "github.com/pkgconf/pkgconf",
    -- ~/build/{TOOLCHAIN}
    --
    -- pkgconfig
    --   glib2
    --   chafa
    --   gtk4
    --   gstreamer
    -- nvim
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
    if cmd == "download" then
      for k, v in pairs(M.downloads) do
        if NYA.is_exists(k) then
          nyagos.write(ES.format("%s: <green>OK<default>\n", k))
        else
          nyagos.write(ES.format("%s <red>=><default> %s\n", k, v))
        end
      end
    end
  end

  --   function nyagos.alias.toolchain(args)
  --     local cmd, name = unpack(args.rawargs)
  --     if cmd == "list" then
  --       for k, v in pairs(M.toolchains) do
  --         print(k)
  --       end
  --     elseif cmd == "load" then
  --       local toolchain = M.toolchains[name]
  --       print [[# zig.ini
  -- [binaries]
  -- c = ['zig', 'cc']
  -- cpp = ['zig', 'c++']
  -- ar = ['zig', 'ar']
  -- dlltool = ['zig', 'dlltool']
  -- lib = ['zig', 'lib']
  -- ranlib = ['zig', 'ranlib']
  --
  -- # meson setup builddir --native-file zig.ini --prefix %USERPROFILE%/build/zig --buildtype=release
  --
  -- # require patch to meson
  -- #
  -- # https://github.com/mesonbuild/meson/pull/11918
  -- #
  -- # edit: lib/site-packages/mesonbuild/linkers/detect.py
  -- # +  elif o.startswith('zig ld '):
  -- # +      linker = LLVMDynamicLinker(compiler,
  -- # +               for_machine, comp_class.LINKER_PREFIX, override, version=v)
  -- ]]
  --     end
  --   end

  -- function nyagos.alias.toolchain()
  --   -- llvm + windows SDK
  --   local kits = "C:/Program Files (x86)/Windows Kits/10"
  --   local version = "10.0.22621.0"
  --   nyagos.env.WindowsSdkVersion = version
  --   nyagos.env.UCRTVersion = version
  --   nyagos.env.UCRTContentRoot = kits
  --   nyagos.env.UniversalCRTSdkDir = kits .. "/"
  --   nyagos.env.LIB = STR.join(";", {
  --     kits .. "lib/" .. version .. "/ucrt/x64",
  --     kits .. "lib/" .. version .. "/um/x64",
  --   })
  --   nyagos.env.INCLUDE = kits .. "/include/" .. version .. "/ucrt"
  --   -- nyagos.env.CMAKE_C_FLAGS = STR.join(" ", {
  --   --   string.format('-I"%s"', kits .. "/include/" .. version .. "/ucrt"),
  --   --   string.format('-I"%s"', kits .. "/include/" .. version .. "/shared"),
  --   --   string.format('-I"%s"', kits .. "/include/" .. version .. "/um"),
  --   -- })
  -- end

  function nyagos.alias.toolchain(args)
    local cmd = unpack(args.rawargs)
    if cmd == "vc" then
      PROMPT.title = " "
      nyagos.exec 'source "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC/Auxiliary/Build/vcvars64.bat"'
    elseif cmd == "llvm" then
      PROMPT.title = "🐉"
      nyagos.envadd("PATH", "D:\\llvm-mingw-20230614-ucrt-x86_64\\bin")
    elseif cmd == "zig" then
      PROMPT.title = "⚡"
      nyagos.envadd("PATH", "C:\\Python310\\lib\\site-packages\\ziglang")
    else
      print "unknown"
      return 1
    end
  end
end

return M
