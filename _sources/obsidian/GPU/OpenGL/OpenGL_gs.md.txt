[LearnOpenGL - Geometry Shader](https://learnopengl.com/Advanced-OpenGL/Geometry-Shader)

VS => GS => FS

```glsl
#version 330 core 
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in VS_OUT { 
    vec2 texCoords;
} gs_in[];
out vec2 TexCoords;

uniform float time;

vec4 explode(vec4 position, vec3 normal) { ... } 

vec3 GetNormal() { ... } 

void main() { 
	vec3 normal = GetNormal();
	gl_Position = explode(gl_in[0].gl_Position, normal);
	TexCoords = gs_in[0].texCoords;
	EmitVertex();
	gl_Position = explode(gl_in[1].gl_Position, normal);
	TexCoords = gs_in[1].texCoords;
	EmitVertex();
	gl_Position = explode(gl_in[2].gl_Position, normal);
	TexCoords = gs_in[2].texCoords;
	EmitVertex();
	EndPrimitive();
}
```
