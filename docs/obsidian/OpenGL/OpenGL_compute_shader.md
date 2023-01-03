[[OpenGL]] `4.3`

- [OpenGL の ComputeShader – すらりん日記](https://blog.techlab-xe.net/opengl-%E3%81%AE-computeshader/)
- @2020 [OpenGL Compute Shader を実行するだけのコード - かかしのアウトプット練習](https://kakashibata.hatenablog.jp/entry/2020/08/31/001306)
- [WebGLのCompute shaderを試してみた - Qiita](https://qiita.com/9ballsyndrome/items/7bae4f4cec8d26692d29)
- [OpenGL Compute Shader を実行するだけのコード - かかしのアウトプット練習](https://kakashibata.hatenablog.jp/entry/2020/08/31/001306)
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
