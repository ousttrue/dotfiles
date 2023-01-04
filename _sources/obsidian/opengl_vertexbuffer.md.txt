[[OpenGL]]

# VGO

# Attribute

## float2, float3, float4

```glsl
in vec2 i_Pos;
```

```c++
glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, 0);
```

## uchar3

```glsl
in vec3 i_Rgb;
```

```c++
glVertexAttribPointer(0, 3, GL_UNSIGNED_BYTEG, GL_TRUE, 0, 0);
```
