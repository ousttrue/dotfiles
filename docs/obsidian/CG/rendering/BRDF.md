bidirectional reflective distribution function

[[fresnel]]

# Version
## 1986
`The Rendering Equation` T.Kajiya

# diffuse と specular
## 拡散BRDF(diffuse)
### Lambert

## 鏡面BRDF(specular)
### Blinn-Phong
https://en.wikipedia.org/wiki/Blinn–Phong_reflection_model
正規化
https://hanecci.hatenadiary.org/entry/20130505/p2

## 拡散と鏡面の両方を扱う
### EnergyConvervation
`Kd+Ks<=1` になるようにする
マテリアルを制限することでできる。

### Cook-Torrance
```c
lambert + cook-torrance
```
金属の反射
http://asura.iaigiri.com/OpenGL/gl30.html

```
fCookTorrance=DFG4(ωo⋅n)(ωi⋅n)
```
D = [[NDF]]
F = [[fresnel]]
G = Geometry

### 鏡面反射を引く
```c
vec3 kS = fresnelSchlick(max(dot(N, V), 0.0), F0); 
vec3 kD = 1.0 - kS;
```

# Metallic
metallic 値 (0 or 1 のどちらかで中間値は取らない。テクスチャからサンプリングする都合上中間値になってしまうことはある)

[glTF™ 2.0 Specification: Appendix B: BRDF Implementation](https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#appendix-b-brdf-implementation)
```
material = mix(dielectric_brdf, metal_brdf, metallic)
         = (1.0 - metallic) * dielectric_brdf + metallic * metal_brdf
```

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
