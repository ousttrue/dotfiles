`Bidirectional Reflectance Distribution Function`

[[IBL]]
[[renderer]]
[[BSDF]] 
[[pbr]]
[[LightProbe]]

- @2021 [基礎からはじめる物理ベースレンダリング](https://zenn.dev/mebiusbox/books/619c81d2fbeafd) 
- @2019 [最近の3DCGで使われる技術や用語をなるべく分かりやすく紹介する - Qiita](https://qiita.com/yoship1639/items/633acdc72f241971d172)

# Version
## 1986
`The Rendering Equation` T.Kajiya

# radiance: 放射輝度
`L(x, ω)`

# その他
```
Q エネルギー
Φ = dQ/dt : raidant flux
Φ/dA = irradiance, radiant exitance, radiosity
Φ/dω = radiant intensity
Φ/dω dA => radiance 👈 これ
```

# Lambert
```c
```

# Specular
## Phong
`Kd+Ks<=1` になるようにする
マテリアルを制限することでできる。

## Fresnel
### Cook-Torrance

## GGX

# Memo

[https://learnopengl.com/PBR/Theory LearnOpenGL - Theory]


bidirectional reflective distribution function

https://disneyanimation.com/publications/physically-based-shading-at-disney/
https://dassaultsystemes-technology.github.io/EnterprisePBRShadingModel/spec-2021x.md.html

[* Lambert]
正規化
http://www.project-asura.com/program/d3d11/d3d11_004.html

[* Blinn-Phong]
https://en.wikipedia.org/wiki/Blinn–Phong_reflection_model
正規化
https://hanecci.hatenadiary.org/entry/20130505/p2

[* Cook-Torrance]
金属の反射
http://asura.iaigiri.com/OpenGL/gl30.html
	Specular: Cook-Torrance

Cook-Torranceの式の D、F、G

[* IBL]
#IBL
[Basic IBL Shaders in HLSL http://technicalartlead.blogspot.com/2017/10/basic-ibl-shaders-in-hlsl.html]
[three.js + キューブマップでお手軽IBL https://qiita.com/kaneta1992/items/df1ae53e352f6813e0cd]

`シェーディングモデル = ディフューズ + スペキュラ`

[リアルタイム物理ベースレンダリング下調べ https://shuichi-h.hatenadiary.org/entry/20150717/1437133075]
[リハビリ http://project-asura.com/blog/archives/3897]
[超雑訳 Real Shading in Unreal Engine 4 http://project-asura.com/blog/archives/3124]


> distribution NDF to sample (Lambertian, GGX, Charlie)

	called the “Charlie” sheen
	ggx
	lambertian

[* NDF]
http://www.reedbeta.com/blog/hows-the-ndf-really-defined/
https://agraphicsguy.wordpress.com/2015/11/01/sampling-microfacet-brdf/

normal distribution function (NDF)
