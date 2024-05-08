[[OpenGL]]

https://www.khronos.org/opengl/wiki/Type_Qualifier_(GLSL)

- [The Book of Shaders](https://thebookofshaders.com/?lan=jp)
- @2014 [GLSLが使いにくい件について - syghの新フラグメント置き場](https://sygh.hatenadiary.jp/entry/2014/07/11/003515)

# Version

- @2017 [OpenGL(GLSL)のvarying,attribute,in,outについて - げぇむぷろぐらみんぐ](http://siguma-sig.hatenablog.com/entry/2017/04/25/203250)

## 460

`#version 460 core`

## 450

`vulkan` ?

- @2019 [初めてのVulkanプログラミング step5 vertex シェーダーの作成。 - Qiita](https://qiita.com/tositada_nakada/items/aa34959f2640b22cd489)
- [Vulkanで3Dグラフィックスを描くには　GLSLの例で見るシェーダの扱い方 - ログミーTech](https://logmi.jp/tech/articles/326278)

## 440

## 400

[[UBO]]

- @2014 [OpenGL 4世代での描画手順 その２ – すらりん日記](https://blog.techlab-xe.net/opengl-4%E4%B8%96%E4%BB%A3%E3%81%A7%E3%81%AE%E6%8F%8F%E7%94%BB%E6%89%8B%E9%A0%86-%E3%81%9D%E3%81%AE%EF%BC%92/)

## 330

`layout (location = 0) `

## 310 es

```c
#version 310 es
precision highp float;
in vec3 VertexPos;
in vec3 VertexColor;

out vec3 PSVertexColor;

uniform mat4 ModelViewProjection;

void main() {
   gl_Position = ModelViewProjection * vec4(VertexPos, 1.0);
   PSVertexColor = VertexColor;
}
```

```c
#version 310 es
precision highp float;
in vec3 PSVertexColor;
out vec4 FragColor;

void main() {
   FragColor = vec4(PSVertexColor, 1);
}
```

## 140

- @2014 [ホイール欲しい ハンドル欲しい » OpenGL ES 3.1 は OpenGL 4.x 相当で ComputeShader に対応](https://www.flatlib.jp/index.php?virtualpath=item/1687)
- @2013 [ホイール欲しい ハンドル欲しい » OpenGL 3.x/4.x のシェーダー GLSL とメモリアクセス命令](https://www.flatlib.jp/index.php?virtualpath=item/1637)

## 130

`deprecated` attribute => in
`deprecated` varying => out

## l20

```c
attribute vec3 position;
uniform vec4 color;
varying vec4 vColor;
```

> the qualifiers `attribute` and `varying` are deprecated. Instead, you are supposed to use `in` and `out`.## 330 core

```c
layout(location = 0) in vec3 vertexPosition_modelspace;
```

## glfw

```cpp
glfwWindowHint(GLFW_CLIENT_API, GLFW_OPENGL_ES_API);
glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
```

## diff

```cpp
glCreateBuffers => glGenBuffers
glCreateVertexArrays => glGenVertexArrays
```

- [GLFW: Getting started](https://www.glfw.org/docs/latest/quick_guide.html#quick_example)

```c
#version 110
attribute vec3 vPos;
attribute vec3 vCol;
varying vec3 color;

uniform mat4 MVP;

void main()
{
    gl_Position = MVP * vec4(vPos, 1.0);
    color = vCol;
}
```

# Extensions

## gl_VertexIndex

# compile

[Example/GLSL Shader Compile Error Testing - OpenGL Wiki](https://www.khronos.org/opengl/wiki/Example/GLSL_Shader_Compile_Error_Testing)

# language server

- [GitHub - svenstaro/glsl-language-server: Language server implementation for GLSL](https://github.com/svenstaro/glsl-language-server)
