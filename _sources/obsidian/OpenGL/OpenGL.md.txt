[[glsl]]
[[OpenGL_Text]]
[[OpenGL_matrix]]

- https://qiita.com/9ballsyndrome/items/7bae4f4cec8d26692d29
- https://wlog.flatlib.jp/index.php?virtualpath=item/1637

# Buffer
[[UBO]]
[[SSBO]]
[[PBO]]

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



[[glsl]]

- https://qiita.com/9ballsyndrome/items/7bae4f4cec8d26692d29
- https://wlog.flatlib.jp/index.php?virtualpath=item/1637

# Buffer

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

