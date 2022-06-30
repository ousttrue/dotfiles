## SSBO
- [モダンな OpenGL で頂点モーフ - SEGA TECH Blog](https://techblog.sega.jp/entry/2016/10/27/140454)

## SSBO: Shader Storage Buffer Object `4.3`

> 書込みが可能
> Functionally speaking, SSBOs can be thought of as a much nicer interface to Buffer Textures when accessed via Image Load Store.

- https://blog.techlab-xe.net/opengl-%E3%81%AE-computeshader/
- https://techblog.sega.jp/entry/2016/10/27/140454
- https://gaz.hateblo.jp/entry/2018/12/28/002720

```glsl
layout (std430, binding = 0) buffer SSBO {
  float data[];
} ssbo;
```

```c++
createBuffer GL_SHADER_STORAGE_BUFFER
bindBufferBase()
```

## SSBO: Shader Storage Buffer Object `4.3`

> 書込みが可能
> Functionally speaking, SSBOs can be thought of as a much nicer interface to Buffer Textures when accessed via Image Load Store.

- https://blog.techlab-xe.net/opengl-%E3%81%AE-computeshader/
- https://techblog.sega.jp/entry/2016/10/27/140454
- https://gaz.hateblo.jp/entry/2018/12/28/002720

```glsl
layout (std430, binding = 0) buffer SSBO {
  float data[];
} ssbo;
```

```c++
createBuffer GL_SHADER_STORAGE_BUFFER
bindBufferBase()
```

