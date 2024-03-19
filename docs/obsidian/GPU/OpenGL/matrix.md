[[opengl]]
[[ProjectionMatrix]]
[Tutorial 3 : Matrices](http://www.opengl-tutorial.org/beginners-tutorials/tutorial-3-matrices/)

code:glm.cpp
 #include <glm/gtc/matrix_transform.hpp> 
 
 auto m = glm::translation(1, 2, 3);
 
 m[0][3] = 1;
 m[1][3] = 2;
 m[2][3] = 3;
 
 auto mvp = projection * view * model;

code:mvp.glsl
 #version 300 es
 in vec3 vPosition;   
 uniform mat4 ModelMatrix;
 uniform mat4 ViewMatrix;
 uniform mat4 ProjectionMatrix;
 uniform mat4 MVPMatrix;
 void main()                 
 {                           
     //gl_Position = ProjectionMatrix * ViewMatrix * ModelMatrix * vec4(vPosition, 1);  
     gl_Position = MVPMatrix * vec4(vPosition, 1);
 }                           

```
列ベクトル

R|T
-+- => c -s
0|1    s  c
```

```
行ベクトル

R|0
-+- => c s
T|1   -s c
```
