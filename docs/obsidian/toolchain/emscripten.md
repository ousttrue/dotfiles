[[wasm]]

- [C/C++ から WebAssembly へのコンパイル - WebAssembly | MDN](https://developer.mozilla.org/ja/docs/WebAssembly/C_to_Wasm)
- [WebAssemblyとEmscriptenに入門した | フューチャー技術ブログ](https://future-architect.github.io/articles/20230517a/)

# meson
[[meson]]
## cross-file
[meson/cross/wasm.txt at master · mesonbuild/meson · GitHub](https://github.com/mesonbuild/meson/blob/master/cross/wasm.txt)
```toml
[binaries]
c = 'emcc'
cpp = 'em++'
ar = 'emar'

[built-in options]
c_args = []
c_link_args = ['-sEXPORT_ALL=1']
cpp_args = []
cpp_link_args = ['-sEXPORT_ALL=1']
default_library = 'static'

[host_machine]
system = 'emscripten'
cpu_family = 'wasm32'
cpu = 'wasm32'
endian = 'little'
```

```meson
project('hello', 'cpp')

executable(
    'hello',
    ['main.cpp'],
    install: true,
    name_suffix: 'html',
)
```

# OpenGL
window platform と webgl2

## GLFW3 ?
`-sUSE_GLFW=3`
[emscripten glfw3 or webgl sample · GitHub](https://gist.github.com/ousttrue/0f3a11d5d28e365b129fe08f18f4e141)
`imgui/examples/example_glfw_opengl3/main.cpp` などを見ると良い。

## SDL2 ?
`-sUSE_SDL=2`
- [GitHub - erik-larsen/emscripten-sdl2-ogles2: C++/SDL2/OpenGLES2 samples running in the browser via Emscripten](https://github.com/erik-larsen/emscripten-sdl2-ogles2/tree/master)
- [GitHub - redblobgames/helloworld-sdl2-opengl-emscripten: Basic program that uses SDL2+OpenGL, compiling both locally and via emscripten](https://github.com/redblobgames/helloworld-sdl2-opengl-emscripten)

## glew ?

## imgui ?
