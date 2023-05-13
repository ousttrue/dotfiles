---
aliases: [PhysicallyBasedRendering]
---

[[brdf]]
[[fresnel]]
[[IBL]]
[[ArmorPaint]]
[[radiometry]]

- @2019 [PBRでフォトリアリスティックな床の制作 - Pentacreation BLOG](https://www.pentacreation.com/blog/2019/05/190520.html)

# BRDF
- @2013 [SIGGRAPH 2012 の Disney の物理ベースシェーダの BRDF Explorer 向けのソースコード - OLD hanecci’s blog : 旧 はねっちブログ](https://hanecci.hatenadiary.org/entry/20131115/p2)

# PBR
- [LearnOpenGL - Theory](https://learnopengl.com/PBR/Theory)
- [GitHub - TheEvilBanana/PhysicallyBasedRendering](https://github.com/TheEvilBanana/PhysicallyBasedRendering.git)

https://www.youtube.com/watch?v=j-A0mwsJRmk

- https://github.com/mebiusbox/docs/blob/master/基礎からはじめる物理ベースレンダリング%20フォトリアル編.pdf
- [Physically Based Rendering: From Theory to Implementation](http://www.pbr-book.org/3ed-2018/contents.html)
- [Preface to the Online Edition](http://www.pbr-book.org/3ed-2018/Preface_to_the_Online_Edition.html)

# IBL
[[IBL]]

Physically based rendering
	Be based on the microfacet surface model.
	Be energy conserving.
	Use a physically based BRDF.
	originally explored by Disney

	https://marmoset.co/posts/basic-theory-of-physically-based-rendering/
	https://gist.github.com/galek/53557375251e1a942dfa

[** lesson]
	https://learnopengl.com/PBR/Theory
	[Framebuffers https://learnopengl.com/Advanced-OpenGL/Framebuffers]

[* Normal mapping https://learnopengl.com/Advanced-Lighting/Normal-Mapping]
`tangent space`

code:normal_map.glsl
 uniform sampler2D normalMap;  
 
 void main()
 {           
     // obtain normal from normal map in range [0,1]
     normal = texture(normalMap, fs_in.TexCoords).rgb;
     // transform normal vector to range [-1,1]
     normal = normalize(normal * 2.0 - 1.0);   
   
     [...]
     // proceed with lighting as normal
 }  

[* The microfacet model]


[* Cubemaps https://learnopengl.com/Advanced-OpenGL/Cubemaps] 
DirectionalVector -> RGBA

[* Gamma correction https://learnopengl.com/Advanced-Lighting/Gamma-Correction]
>apply the inverse of the monitor's gamma to the final output color before displaying to the monitor
sRGB 

[* to sRGB]
`GL_SRGB` and `GL_SRGB_ALPHA`

code:gamma.fs
 float gamma = 2.2;
 vec3 diffuseColor = pow(texture(diffuse, texCoords).rgb, vec3(gamma)); 

[* from SRGB to Linear]

code:gamma.fs
  // apply gamma correction
  float gamma = 2.2;
  FragColor.rgb = pow(fragColor.rgb, vec3(1.0/gamma));

[** HDR]
	https://learnopengl.com/Advanced-Lighting/HDR
> to the low dynamic range (LDR) of [0.0, 1.0]. This process of converting HDR values to LDR values is called tone mapping

GL_RGB16F, GL_RGBA16F, GL_RGB32F or GL_RGBA32F

[* Reinhard tone mapping]
code:tone_mapping.glsl
 void main()
 {             
     const float gamma = 2.2;
     vec3 hdrColor = texture(hdrBuffer, TexCoords).rgb;
   
     // reinhard tone mapping
     vec3 mapped = hdrColor / (hdrColor + vec3(1.0));
     // gamma correction 
     mapped = pow(mapped, vec3(1.0 / gamma));
   
     FragColor = vec4(mapped, 1.0);
 }    

code:exposure:glsl
 uniform float exposure;
 
 void main()
 {             
     const float gamma = 2.2;
     vec3 hdrColor = texture(hdrBuffer, TexCoords).rgb;
   
     // Exposure tone mapping
     vec3 mapped = vec3(1.0) - exp(-hdrColor * exposure);
     // Gamma correction 
     mapped = pow(mapped, vec3(1.0 / gamma));
   
     FragColor = vec4(mapped, 1.0);
 }  
