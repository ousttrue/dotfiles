---
aliases: [sRGB, gamma]
---

[* Gamma correction https://learnopengl.com/Advanced-Lighting/Gamma-Correction]
>apply the inverse of the monitor's gamma to the final output color before displaying to the monitor
sRGB 

# to sRGB
`GL_SRGB` and `GL_SRGB_ALPHA`

code:gamma.fs
 float gamma = 2.2;
 vec3 diffuseColor = pow(texture(diffuse, texCoords).rgb, vec3(gamma)); 

# from SRGB to Linear

code:gamma.fs
  // apply gamma correction
  float gamma = 2.2;
  FragColor.rgb = pow(fragColor.rgb, vec3(1.0/gamma));


## HDR
[[HDR]]
