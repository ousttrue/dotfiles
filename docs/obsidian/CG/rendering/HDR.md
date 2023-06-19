---
aliases: [tonemapping]
---
[[ColorSpace]]
[[IBL]]

# HDRI素材
## texture download
- https://cgbeginner.net/hdri-footage/

## 作成
- https://cycles.wiki.fc2.com/wiki/IBL%20用%20HDRI%20の作り方

## sphere map
- [GitHub - markpmlim/LightProbes2](https://github.com/markpmlim/LightProbes2)

## equirerectanglar
- [High-Resolution Light Probe Image Gallery](https://vgl.ict.usc.edu/Data/HighResProbes/)

# Reinhard tone mapping

```c
// code:tone_mapping.glsl
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
```
`

```c
// code:exposure:glsl
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
```
