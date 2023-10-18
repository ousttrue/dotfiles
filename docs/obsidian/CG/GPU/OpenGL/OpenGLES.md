---
aliases: [EGL]
---
#red

[[OpenGL]] [[vulkan]] [[WebGPU]]

- [OpenGL ES  |  Android デベロッパー  |  Android Developers](https://developer.android.com/guide/topics/graphics/opengl?hl=ja)

# Version
|glsl|OpenGLES||
|-|-|-|
|#version 320 es|GLES3.2|2015|
|#version 310 es|GLES3.1|2014|
|#version 300 es|GLES3.0 WebGL2.0|2012|
|#version 100 es|GLES2.0 WebGL1.0|2007|

## 3.2

## 3.1
- [[Android]] api level 21

## 3.0
- [[Android]] api level 18
- [[webgl]]

```c
#version 300 es
in vec3 position;
in vec3 normal;
in vec4 color;
uniform mat4 mvpMatrix;
uniform mat4 mMatrix;
out vec3 vPosition;
out vec3 vNormal;
out vec4 vColor;
```

## 2.0
- [[Android]] api level 8
