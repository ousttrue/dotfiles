Imabe Based Light
[[Lighting]]
[[HDR]]
[[BRDF]]

- @2019 [物理ベースにのっとったImage Based Lightingを実装してみた | NKTK-WEBLOG](https://blog.nktk-tech.com/2019-03-31-02/)
http://technicalartlead.blogspot.com/2017/10/basic-ibl-shaders-in-hlsl.html
https://qiita.com/kaneta1992/items/df1ae53e352f6813e0cd
https://shuichi-h.hatenadiary.org/entry/20150717/1437133075]
http://project-asura.com/blog/archives/3897
http://project-asura.com/blog/archives/3124

https://learnopengl.com/Advanced-OpenGL/Cubemaps
DirectionalVector -> RGBA

# pre-filter (前処理)
- @2001 [An Efficient Representation for Irradiance Environment Maps](http://graphics.stanford.edu/papers/envmap/)
[[SphericalHarmonicFunction]]

## Lambert IBL + Irradiance map
[LearnOpenGL - Diffuse irradiance](https://learnopengl.com/PBR/IBL/Diffuse-irradiance)
> irradiance map

```c
vec3 irradiance = texture(irradianceMap, N).rgb;
```

## Specular IBL
[LearnOpenGL - Specular IBL](https://learnopengl.com/PBR/IBL/Specular-IBL)

> Epic Games' split sum approximation

### pre-filtered environment map 
cubemap

ラフネス値の違いをMipMapで表現
> the specular part consists of several mip-map levels corresponding to different roughness values of the modeled material

### BRDF_2D_LUT(LookUpTable) 
2D
```c
vec2(NdotV, roughness)
```

### GGX

## Tool
- [IBLBaker — The Kreature Experiment](http://www.derkreature.com/iblbaker)
	- [GitHub - derkreature/IBLBaker: Light probe generation and BRDF authoring for physically based shading.](https://github.com/derkreature/IBLBaker)
- [GitHub - KhronosGroup/glTF-IBL-Sampler: Sampler to create the glTF sample environments](https://github.com/KhronosGroup/glTF-IBL-Sampler)
	- https://github.com/ux3d/glTF-Sample-Environments

# LightProbe
[[LightProbe]]

# Planar reflections
used to capture reflections by rendering the scene mirrored by a plane. This technique works only for flat surfaces such as building floors, roads and water.
    
# Screen space reflection
used to capture reflections based on the rendered scene (using the previous frame for instance) by ray-marching in the depth buffer. SSR gives great result but can be very expensive.
