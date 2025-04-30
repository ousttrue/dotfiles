[[OpenGLES]]

- libEGL.dll
- libGLESv2.dll

- [GitHub - rinkowei/OpenGLES_Examples: The implementation of real-time rendering technologies based on Google Angle(OpenGL ES 3.1) and SDL2](https://github.com/rinkowei/OpenGLES_Examples)

## Win32

- @2017 [WindowsでOpenGLES --- ANGLE準備 - 何でもプログラミング](https://any-programming.hatenablog.com/entry/2017/04/20/005616)

```c++
#include <EGL\egl.h>
#pragma comment(lib, "libEGL.lib")

#include <GLES3\gl3.h>
#pragma comment(lib, "libGLESv2.lib")
```

## GLFW

- [GitHub - name-era/GLESoverVulkan](https://github.com/name-era/GLESoverVulkan)
- [ANGLEを使ってOpenGL ES をVulkanに変換して動かす - メモ](https://name-era.hatenablog.com/entry/angle)

`GLFW_ANGLE_PLATFORM_TYPE`
`GLFW_INCLUDE_ES2`
