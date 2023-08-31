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

  function nyagos.alias.toolchain(args)
    local cmd, name = unpack(args.rawargs)
    if cmd == "list" then
      for k, v in pairs(M.toolchains) do
        print(k)
      end
    elseif cmd == "load" then
      local toolchain = M.toolchains[name]
      print [[# zig.ini
[binaries]
c = ['zig', 'cc']
cpp = ['zig', 'c++']
ar = ['zig', 'ar']
dlltool = ['zig', 'dlltool']
lib = ['zig', 'lib']
ranlib = ['zig', 'ranlib']

# meson setup builddir --native-file zig.ini --prefix %USERPROFILE%/build/zig --buildtype=release

# require patch to meson
#
# https://github.com/mesonbuild/meson/pull/11918
#
# edit: lib/site-packages/mesonbuild/linkers/detect.py 
# +  elif o.startswith('zig ld '):
# +      linker = LLVMDynamicLinker(compiler, 
# +               for_machine, comp_class.LINKER_PREFIX, override, version=v)
]]
    end
  end
end

return M
