[raylib | A simple and easy-to-use library to enjoy videogames programming](https://www.raylib.com/)

# template
- @2022 [raylibを試す](https://zenn.dev/slowhand/articles/10628496100c85)
- [GitHub - raysan5/raylib-game-template: A small template to start your raylib game](https://github.com/raysan5/raylib-game-template)

# lua
- [GitHub - TSnake41/raylib-lua: A modern LuaJIT binding for Raylib (also available at https://gitlab.com/TSnake41/raylib-lua)](https://github.com/TSnake41/raylib-lua)

# meson
```meson.build
project('raylib', 'c', version: '4.2.0')

subdir('src/external/glfw')

c = meson.get_compiler('c')
winmm_dep = c.find_library('winmm')

raylib_lib = static_library('raylib', [
'src/rcore.c',
'src/rmodels.c',
'src/rshapes.c',
'src/rtext.c',
'src/rtextures.c',
'src/utils.c',
'src/raudio.c',
# 'src/rglfw.c',
],
c_args: [
'-DPLATFORM_DESKTOP=1',
# '-DBUILD_LIBTYPE_SHARED=1',
],
dependencies: [glfw_dep],
)
raylib_dep = declare_dependency(
  include_directories: include_directories('src'),
  link_with: raylib_lib,
  dependencies: [glfw_dep, winmm_dep],
  compile_args: [
    '-DPLATFORM_DESKTOP=1',
    # '-DUSE_LIBTYPE_SHARED=1',
  ]
  )
```

```src/external/glfw/meson.build
args = [
  '-D_GLFW_WIN32=1'
]
glfw_lib = static_library('glfw', [
'src/context.c',
'src/init.c',
'src/input.c',
'src/monitor.c',
'src/vulkan.c',
'src/window.c',
'src/win32_init.c',
'src/win32_joystick.c',
'src/win32_monitor.c',
'src/win32_time.c',
'src/win32_thread.c',
'src/win32_window.c',
'src/wgl_context.c',
'src/egl_context.c',
'src/osmesa_context.c',
],
c_args: args,
)
glfw_dep = declare_dependency(
  include_directories: include_directories('include'),
  link_with: glfw_lib,
  compile_args: args,
  )
```
