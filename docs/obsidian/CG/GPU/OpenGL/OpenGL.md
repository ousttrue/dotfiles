#red
[[OpenGL_Text]] [[matrix]]
[[UBO]] [[SSBO]] [[PBO]]
[[spir-v]] [[OpenGLES]] [[glsl]]

# Setup
1. Triangle
1. 2D Camera
1. 3D Projection
1. MouseWheel
1. MouseSfhit
1. YawPitch
1. EuclideanTransfrom

# Engine
- [OpenGL Rendering Engine | OpenGL rendering engine written in pure C++](https://opengl.bassi.li/)

# Version
- [GLSL Versions · mattdesl/lwjgl-basics Wiki · GitHub](https://github.com/mattdesl/lwjgl-basics/wiki/glsl-versions)
- [ホイール欲しい ハンドル欲しい » OpenGL 3.x/4.x のシェーダー GLSL とメモリアクセス命令](https://wlog.flatlib.jp/index.php?virtualpath=item/1637)

|glsl version|OpenGL| |
|-|-|-|
|460|4.6||
|430|4.3|[[SSBO]], [[OpenGL_compute_shader]]|
|420|4.2||
|410|4.1||
|400|4.0|[[d3d11]]相当|
|330|3.3||
|150|3.2||
|140|3.1|[[UBO]]|
|130|3.0|attribute => in, varying => out, texelFetch|
|120|2.1||
|110|2.0||

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
