[[vulkan]]
`vulkan SDK に含まれる`

- [GitHub - KhronosGroup/glslang: Khronos-reference front end for GLSL/ESSL, partial front end for HLSL, and a SPIR-V generator.](https://github.com/KhronosGroup/glslang)

- @2022 [【Vulkan】GLSLレイトレーシングシェーダをランタイムコンパイルしてみる](https://zenn.dev/nishiki/articles/8cfbfed52f13cb)
- @2018 [glslangValidatorを使ってシェーダの文法チェックをする(4-Ex1.) - Qiita](https://qiita.com/uechoco@github/items/031f4fe980582ff9234f)
- @2017 [Vulkanでシェーダリフレクション(Shader Reflection)を取得してみる - SEGA TECH Blog](https://techblog.sega.jp/entry/2017/03/27/100000)

# command line

## glslangValidator

```
glslangValidator -G -l -o shaderVS.spv vertexShader.vert
```

# library

## glslang::TShader

# gn

- https://github.com/KhronosGroup/glslang/blob/main/BUILD.gn

# zig

- https://github.com/tiawl/glslang.zig
- https://github.com/tiawl/shaderc.zig

- https://github.com/Games-by-Mason/glslang-zig?tab=readme-ov-file
