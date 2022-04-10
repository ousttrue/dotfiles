[[glsl]]

- https://qiita.com/9ballsyndrome/items/7bae4f4cec8d26692d29
- https://wlog.flatlib.jp/index.php?virtualpath=item/1637

# Buffer

## UBO: Uniform Buffer Object

> D3D の ConstantBuffer に相当する

- https://qiita.com/hoboaki/items/b188c4495f4708c19002

`GL_UNIFORM_BUFFER`

## Texture Image Load and Store `4.2`

> Direct3D の UAV に相当する

# ComputeShader

- https://kakashibata.hatenablog.jp/entry/2020/08/31/001306

`GL_COMPUTE_SHADER` を一つだけコンパイルして、アタッチ、リンクする。

use してから dispatch することで起動する。

```c++
GLuseProgram(computeProgram);
GLdispatchCompute(1, 1, 1);
```

- https://www.khronos.org/opengl/wiki/Compute_Shader#Inputs

自身の実行情報を得るには？

```glsl
uint id = gl_GlobalInvocationID.x;
```

## working group

```glsl
layout (local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
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

