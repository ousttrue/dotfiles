#red
[[OpenGL]] [[OpenGL_Text]] [[OpenGL_matrix]]
[[UBO]] [[SSBO]] [[PBO]]

# Version
- [GLSL Versions · mattdesl/lwjgl-basics Wiki · GitHub](https://github.com/mattdesl/lwjgl-basics/wiki/glsl-versions)
- [ホイール欲しい ハンドル欲しい » OpenGL 3.x/4.x のシェーダー GLSL とメモリアクセス命令](https://wlog.flatlib.jp/index.php?virtualpath=item/1637)

|glsl version|OpenGL||
|-|-|-|
|#version 460|4.6||
|#version 430|4.3|[[SSBO]], [[OpenGL_compute_shader]]|
|#version 420|4.2|[[TextureObject]]|
|#version 410|4.1||
|#version 400|4.0||
|#version 330|3.3||
|#version 150|3.2||
|#version 140|3.1|[[UBO]]|
|#version 130|3.0|attribute => in, varying => out|
|#version 120|2.1||
|#version 110|2.0||

## 4.3
- [[OpenGL_compute_shader]]

## 3.1
[[UBO]]

# Windows
`WINGDIAPI` のために先に `#include <Windows.h>`

# Registry
- [GitHub - KhronosGroup/OpenGL-Registry: OpenGL, OpenGL ES, and OpenGL ES-SC API and Extension Registry](https://github.com/KhronosGroup/OpenGL-Registry)

## gl.xml

- registry
	- types
	- enum



[[opengl]] [[spir-v]] [[OpenGLES]]
#red

https://www.khronos.org/opengl/wiki/Type_Qualifier_(GLSL)

# Version
|glsl version|OpenGL||
|-|-|-|
|#version 460|4.6||
|#version 430|4.3|[[SSBO]], [[OpenGL_compute_shader]]|
|#version 420|4.2||
|#version 410|4.1||
|#version 400|4.0||
|#version 330|3.3||
|#version 150|3.2||
|#version 140|3.1|[[UBO]]|
|#version 130|3.0|attribute => in, varying => out, texelFetch|
|#version 120|2.1||
|#version 110|2.0||


- @2017 [OpenGL(GLSL)のvarying,attribute,in,outについて - げぇむぷろぐらみんぐ](http://siguma-sig.hatenablog.com/entry/2017/04/25/203250)
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

>  the qualifiers `attribute` and `varying` are deprecated. Instead, you are supposed to use `in` and `out`.

# language server
- [GitHub - svenstaro/glsl-language-server: Language server implementation for GLSL](https://github.com/svenstaro/glsl-language-server)
