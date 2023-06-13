- @2022 [Index - Reincarnation+#Tech](https://fereria.github.io/reincarnation_tech/11_Pipeline/)
- @2020 [USD で usdz データを読むメモ - Qiita](https://qiita.com/syoyo/items/609c050d018e934bc47c)
- @2019 [Pixar's RenderMan | Stories | Pixar's USD Pipeline](https://renderman.pixar.com/stories/pixars-usd-pipeline)
- @2017 [ピクサー USD 入門 新たなコンテンツパイプラインを構築する](https://www.slideshare.net/takahitotejima/usd-79288174)
- @2017 [Pixar USD の Windows ビルド方法（2017/9 版） - Qiita](https://qiita.com/takahito-tejima/items/f820e16869ca4343a600)
- @2016 [USD (ユニバーサルシーンディスクリプション） - Qiita](https://qiita.com/takahito-tejima/items/3c2fa4a4a83aa04b9a0e)

# Version
## 23.05

# sample
https://github.com/vfxpro99/usd-resources
https://developer.apple.com/augmented-reality/quick-look/
http://graphics.pixar.com/usd/downloads.html
http://graphics.pixar.com/usd/files/SkinningOM.md.html

# apps
https://github.com/LumaPictures/usd-qt

## Blender-3.0
https://developer.blender.org/project/view/118/
- @2021 [あんどうめぐみ@れみりあさんの記事一覧 | Zenn](https://zenn.dev/remiria)
https://docs.blender.org/manual/en/latest/files/import_export/usd.html
https://code.blender.org/2019/07/first-steps-with-universal-scene-description/

## unity
- @2019 _[Pixar's Universal Scene Description for Unity out in Preview | Unity Blog](https://blogs.unity3d.com/2019/03/28/pixars-universal-scene-description-for-unity-out-in-preview/)
https://github.com/Unity-Technologies/film-tv-toolbox/tree/master/UsdSamples
https://docs.unity3d.com/Packages/com.unity.formats.usd@1.0/manual/index.html

## omniverse
prebuilt USD 22.11, Python 3.7
- [Pixar Universal Scene Description (USD) | NVIDIA Developer](https://developer.nvidia.com/usd)
- https://developer.nvidia.com/usd `python3.6`

# build
## build_scripts/build_usd.py
```.vscode/launch.json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "build_usd.py",
            "type": "python",
            "request": "launch",
            "program": "${workspaceFolder}/build_scripts/build_usd.py",
            "console": "integratedTerminal",
            "cwd": "${workspaceFolder}",
            "args": [
                "D:/pixar_usd",
                "--dry_run",
                "--no-python",
                "--no-examples",
                "--no-tools",
                "--no-tutorials",
                "--no-imaging",
            ],
            "justMyCode": true
        }
    ]
}
```

## vs2022 対応のためには boost-1.78 が必要
`--toolset=v143`

## dependencies
[[OpenSubdiv]]
[[ptex]]
