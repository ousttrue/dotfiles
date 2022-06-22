Pixar USD 系列の OpenSource

[[OpenSubdiv]]

- [USD Home — Universal Scene Description 22.05 documentation](https://graphics.pixar.com/usd/docs/index.html)
- [USD Tutorials — Universal Scene Description 22.05 documentation](https://graphics.pixar.com/usd/docs/USD-Tutorials.html)
- [あんどうめぐみ@れみりあさんの記事一覧 | Zenn](https://zenn.dev/remiria)
- [Pixar Universal Scene Description (USD) | NVIDIA Developer](https://developer.nvidia.com/usd)
- [Index - Reincarnation+#Tech](https://fereria.github.io/reincarnation_tech/11_Pipeline/)
- [Pixar USD介绍 - 知乎](https://zhuanlan.zhihu.com/p/97710961)

[* 2021]
	https://developer.nvidia.com/usd
	Blender-3.0
	https://developer.blender.org/project/view/118/

[* 2020]
	[USD で usdz データを読むメモ https://qiita.com/syoyo/items/609c050d018e934bc47c]

[* 2019]
	https://renderman.pixar.com/stories/pixars-usd-pipeline
		[PixarのUSDパイプライン http://kai-tei.daa.jp/2019_1211_12128/]
	https://blogs.unity3d.com/2019/03/28/pixars-universal-scene-description-for-unity-out-in-preview/

[* 2017]
	https://www.slideshare.net/takahitotejima/usd-79288174
	https://qiita.com/takahito-tejima/items/f820e16869ca4343a600

[* 2016]
	https://qiita.com/takahito-tejima/items/3c2fa4a4a83aa04b9a0e

[* unity]
https://docs.unity3d.com/Packages/com.unity.formats.usd@1.0/manual/index.html
https://github.com/Unity-Technologies/film-tv-toolbox/tree/master/UsdSamples

[* blender]
https://docs.blender.org/manual/en/latest/files/import_export/usd.html
https://code.blender.org/2019/07/first-steps-with-universal-scene-description/

[* prebuild]
https://developer.nvidia.com/usd `python3.6`

[* sample]
https://github.com/vfxpro99/usd-resources
https://developer.apple.com/augmented-reality/quick-look/
http://graphics.pixar.com/usd/downloads.html
http://graphics.pixar.com/usd/files/SkinningOM.md.html

[* tools]
https://github.com/LumaPictures/usd-qt

code:cube.usda
 #usda 1.0
 
 def Cube "cube"
 {
 }

code:ref.usda
 #usda 1.0
 
 over "refCube" (
     prepend references = @./cube.usda@
 )
 {
 }

code:move.usda
 #usda 1.0
 
 over "refCube" (
     prepend references = @./cube.usda@
 )
 {
     double3 xformOp:translate = (0, 1, 0)
     uniform token[] xformOpOrder = ["xformOp:translate"]
 }
 
 over "refCube2" (
     prepend references = @./cube.usda@
 )
 {
     double3 xformOp:translate = (0, 1, -4)
     uniform token[] xformOpOrder = ["xformOp:translate"]
 }
