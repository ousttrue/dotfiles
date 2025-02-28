https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_materials_mtoon-1.0/README.ja.md

- @2018 [VRMフォーマットで使われるMToonシェーダーのキャラクターセットアップ #Unity - Qiita](https://qiita.com/neon-izm/items/445dcd4510f87ee506b2)

# Lighting

- https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_materials_mtoon-1.0/README.ja.md#lighting

- LitColor(RGB)
- ShadeColor(RGB)

```lua
function linearstep( a: Number, b: Number, t: Number ): Number
  return saturate( ( t - a ) / ( b - a ) )
end function

let shading: Number = dot( N, L )
shading = shading + shadingShiftFactor
shading = shading + texture( shadingShiftTexture, uv ) * shadingShiftTexture.scale
shading = linearstep( -1.0 + shadingToonyFactor, 1.0 - shadingToonyFactor, shading )

let baseColorTerm: ColorRGB = baseColorFactor.rgb * texture( baseColorTexture, uv ).rgb
let shadeColorTerm: ColorRGB = shadeColorFactor.rgb * texture( shadeMultiplyTexture, uv ).rgb

let color: ColorRGB = lerp( shadeColorTerm, baseColorTerm, shading )
color = color * lightColor
```

## Global Illumination

- https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_materials_mtoon-1.0/README.ja.md#global-illumination

## Uv Animation

- https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_materials_mtoon-1.0/README.ja.md#uv-animation
