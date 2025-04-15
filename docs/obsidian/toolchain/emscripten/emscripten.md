- [C/C++ から WebAssembly へのコンパイル - WebAssembly | MDN](https://developer.mozilla.org/ja/docs/WebAssembly/C_to_Wasm)
- [WebAssemblyとEmscriptenに入門した | フューチャー技術ブログ](https://future-architect.github.io/articles/20230517a/)

# version

- https://github.com/emscripten-core/emscripten/blob/main/ChangeLog.md

## 4.0.4 @20250225

- An initial port of SDL3 was added. Use it with -sUSE_SDL=3

## 3.1.64

# build

- https://archlinux.org/packages/extra/x86_64/emscripten/files/

- https://emscripten.org/docs/building_from_source/index.html
- @2023 [emscriptenをビルドする](https://zenn.dev/kokoro/scraps/eeccd52172b1a6)

```sh
> cmake -B llvm-20 -S ./llvm-project-20.src/llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS='lld;clang' -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" -DLLVM_TARGETS_TO_BUILD="host;WebAssembly" -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF -DLIBCXX_ABI_UNSTABLE=OFF
> cmake --build llvm-20 -- -j6
```

https://github.com/emscripten-core/emscripten

```sh
> ./emcc --generate-config                                                                 [History]
```

`.emscripten`

```
LLVM_ROOT = '/home/ousttrue/local/src/build/bin' # directory
BINARYEN_ROOT = '/home/ousttrue/ghq/github.com/WebAssembly/binaryen/build' # directory
NODE_JS = '/usr/local/bin/node' # executable
```

```sh
> ./emcc --check
```

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

# libs

- [emscripten 向け C++ ライブラリのビルド | Junk-Box](https://junk-box.net/toy/2024/01/29/godot-gdextension-%E3%81%AE-web-%E3%82%A8%E3%82%AF%E3%82%B9%E3%83%9D%E3%83%BC%E3%83%88%EF%BC%88%E3%81%9D%E3%81%AE4%EF%BC%89/)
