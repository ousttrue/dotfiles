brdf
#renderer #BSDF #pbr

[https://qiita.com/yoship1639/items/633acdc72f241971d172 最近の3DCGで使われる技術や用語をなるべく分かりやすく紹介する - Qiita]

code:.c
 m = metallic; // 材質の金属度(0~1)
 color = 0; // 色の合計
 
 for (ライトの数) {
     color += 拡散BRDF() * (1 - m);
     color += 鏡面BRDF() * m;
 }
 
 return color;

[https://zenn.dev/mebiusbox/books/619c81d2fbeafd 基礎からはじめる物理ベースレンダリング]
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
