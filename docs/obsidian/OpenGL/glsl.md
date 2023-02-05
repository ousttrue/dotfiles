[[OpenGL]]

# compile
[Example/GLSL Shader Compile Error Testing - OpenGL Wiki](https://www.khronos.org/opengl/wiki/Example/GLSL_Shader_Compile_Error_Testing)


# version
## 330 core
```c
layout(location = 0) in vec3 vertexPosition_modelspace;
```

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
