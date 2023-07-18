[[ptex]]
[[IGES]]
[[libigl]]

- 通常の三角形メッシュじゃなくて、四角形メッシュが欲しい。
- クリース情報を記録したい。

- [OpenSubdiv Overview](https://graphics.pixar.com/opensubdiv/overview.html)
- [GitHub - PixarAnimationStudios/OpenSubdiv: An Open-Source subdivision surface library.](https://github.com/PixarAnimationStudios/OpenSubdiv)

- @2019 [OpenSubdiv で mesh smooth のメモ - Qiita](https://qiita.com/syoyo/items/8f7ceed1f339a531b342)
- @2020 [自前で Catmull-Clark, Loop subdivision surface を C++11 実装するための事前調査メモ - Qiita](https://qiita.com/syoyo/items/66d6e2a6bffe0a99f307)

# MinimumBuild
- OpenGL ローダーのせいでビルドしずらい w
- あと osd_stringify

# API
## Sdc
サブディビジョンコア
[Sdc Overview](http://takahito-tejima.github.io/OpenSubdivJpDoc/sdc_overview.html)

## Vtr
ベクトル化トポロジ表現
`internal`
[Vtr Overview](http://takahito-tejima.github.io/OpenSubdivJpDoc/vtr_overview.html)

## Far
特徴適応型表現
[Far Overview](http://takahito-tejima.github.io/OpenSubdivJpDoc/far_overview.html)

## Osd
OpenSubdiv クロスプラットフォーム
[Osd Overview](http://takahito-tejima.github.io/OpenSubdivJpDoc/osd_overview.html)

## hbr(legacy)
`3.0` で deprecated ?
- [Using Hbr](https://graphics.pixar.com/opensubdiv/docs/using_osd_hbr.html)

# blender
- [Subdivision Surface Modifier — Blender Manual](https://docs.blender.org/manual/en/latest/modeling/modifiers/generate/subdivision_surface.html)
- fbx export では subsurf できる
