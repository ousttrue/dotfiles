## UBO: Uniform Buffer Object
- [Uniform Buffer Object - OpenGL Wiki](https://www.khronos.org/opengl/wiki/Uniform_Buffer_Object)

- [OpenGL 4世代での描画手順 その２ – すらりん日記](https://blog.techlab-xe.net/opengl-4%E4%B8%96%E4%BB%A3%E3%81%A7%E3%81%AE%E6%8F%8F%E7%94%BB%E6%89%8B%E9%A0%86-%E3%81%9D%E3%81%AE%EF%BC%92/)

> D3D の ConstantBuffer に相当する

```c
#version 300 es

layout (location = 0) in vec3 position;
layout (std140) uniform matrix { 
	mat4 mvp; 
} mat;

uniform float scale; 

void main(){ 
	gl_Position = mat.mvp * vec4(position * scale, 1.0); 
}
```

`GL_UNIFORM_BUFFER`

# C
## create

```c
glGenBuffers( 1, &ubo );
```

## upload

```c
// mvpMatrix は 4x4 の行列 gl.bindBuffer(gl.UNIFORM_BUFFER, matrixUBO); gl.bufferData(gl.UNIFORM_BUFFER, mvpMatrix, gl.DYNAMIC_DRAW); gl.bindBuffer(gl.UNIFORM_BUFFER, null);
```

## block index

```c
blockIndex = glGetUniformBlockIndex(shaderProgram, "matrix");
glUniformBlockBinding(shaderProgram, blockIndex, UBO_BINDING_POINT);
```

## bind
```c
glBindBufferBase(GL_UNIFORM_BUFFER, UBO_BINDING_POINT, ubo);
```

# memory layout
## std140
- [ユニフォームブロックのメモリレイアウト @ゲームプログラマの小話[開発:グラフィックス] - Qiita](https://qiita.com/hoboaki/items/b188c4495f4708c19002)
