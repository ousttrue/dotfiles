glsl
#opengl

https://github.com/mattdesl/lwjgl-basics/wiki/glsl-versions

	[OpenGL(GLSL)のvarying,attribute,in,outについて http://siguma-sig.hatenablog.com/entry/2017/04/25/203250]

code:version.glsl
	#version 300 es
 #version 400

code:opengl20.glsl
 attribute vec3 position;
 uniform vec4 color;
 varying vec4 vColor;

code:opengl30.glsl
 in vec3 position;
 in vec3 normal;
 in vec4 color;
 uniform mat4 mvpMatrix;
 uniform mat4 mMatrix;
 out vec3 vPosition;
 out vec3 vNormal;
 out vec4 vColor;

>  the qualifiers `attribute` and `varying` are deprecated. Instead, you are supposed to use `in` and `out`.

https://www.khronos.org/opengl/wiki/Type_Qualifier_(GLSL)
