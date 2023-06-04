[[blender]]

- [Base Meshes - Stylized Character Workflow - Blender Studio](https://studio.blender.org/training/stylized-character-workflow/base-meshes/)
- [Stylized Character Workflow - Blender Studio](https://studio.blender.org/training/stylized-character-workflow/)


# Metallic
[[fresnel]]

## BRDF
`Bidirectional Reflectance Distribution Function`

[glTF™ 2.0 Specification: Appendix B: BRDF Implementation](https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#appendix-b-brdf-implementation)
```
material = mix(dielectric_brdf, metal_brdf, metallic)
         = (1.0 - metallic) * dielectric_brdf + metallic * metal_brdf
```

### 拡散BRDF(diffuse: lambert)
### 鏡面BRDF(specular: fresnel)

## Conductive, Metal(金属、導体)
鋼、銅、金、すなわち金属

```
# 全部 specular
metal_brdf =
  conductor_fresnel(
    f0 = baseColor,
    bsdf = specular_brdf(
      α = roughness ^ 2))
```

## Dielectric(非金属、誘電体、絶縁体、非導体?)
ガラス、プラスチック、木材、セラミック、革など
```
# diffuse + Specular
dielectric_brdf =
  fresnel_mix(
    ior = 1.5,
    base = diffuse_brdf(
      color = baseColor),
    layer = specular_brdf(
      α = roughness ^ 2))
```

