project('lua', 'c', version: '5.1.5')

lua_args = ['-DLUA_USE_LINUX']

lua_inc = include_directories('src')

lua_lib = shared_library('lua', [
'src/lapi.c',
'src/lcode.c',
'src/ldebug.c',
'src/ldo.c',
'src/ldump.c',
'src/lfunc.c',
'src/lgc.c',
'src/llex.c',
'src/lmem.c',
'src/lobject.c',
'src/lopcodes.c',
'src/lparser.c',
'src/lstate.c',
'src/lstring.c',
'src/ltable.c',
'src/ltm.c',
'src/lundump.c',
'src/lvm.c',
'src/lzio.c',
#
'src/lauxlib.c',
'src/lbaselib.c',
'src/ldblib.c',
'src/liolib.c',
'src/lmathlib.c',
'src/loslib.c',
'src/ltablib.c',
'src/lstrlib.c',
'src/loadlib.c',
'src/linit.c',
],
c_args: lua_args,
install: true,
)

lua_dep = declare_dependency(
  include_directories: lua_inc,
  link_with: lua_lib,
  compile_args: lua_args,
  )

readline_dep = dependency('readline')
executable('lua', 'src/lua.c', install: true,
  dependencies: [lua_dep, readline_dep],
)

