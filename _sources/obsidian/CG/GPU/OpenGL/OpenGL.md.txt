#red
[[OpenGL_Text]] [[matrix]]
[[UBO]] [[SSBO]] [[PBO]]
[[spir-v]] [[OpenGLES]] [[glsl]]

# Engine
- [OpenGL Rendering Engine | OpenGL rendering engine written in pure C++](https://opengl.bassi.li/)

# Version
- [GLSL Versions · mattdesl/lwjgl-basics Wiki · GitHub](https://github.com/mattdesl/lwjgl-basics/wiki/glsl-versions)
- [ホイール欲しい ハンドル欲しい » OpenGL 3.x/4.x のシェーダー GLSL とメモリアクセス命令](https://wlog.flatlib.jp/index.php?virtualpath=item/1637)

|glsl version|OpenGL||
|-|-|-|
|#version 460|4.6||
|#version 430|4.3|[[SSBO]], [[OpenGL_compute_shader]]|
|#version 420|4.2||
|#version 410|4.1||
|#version 400|4.0|[[d3d11]]相当|
|#version 330|3.3||
|#version 150|3.2||
|#version 140|3.1|[[UBO]]|
|#version 130|3.0|attribute => in, varying => out, texelFetch|
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
