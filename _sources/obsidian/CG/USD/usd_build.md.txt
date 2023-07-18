[GitHub - PixarAnimationStudios/OpenUSD: Universal Scene Description](https://github.com/PixarAnimationStudios/OpenUSD)

- @2017 [Pixar USD の Windows ビルド方法（2017/9 版） - Qiita](https://qiita.com/takahito-tejima/items/f820e16869ca4343a600)

# dependency
## boost
- [[boost]]

- https://mesonbuild.com/Dependencies.html#boost

### vs2022 対応のためには boost-1.78 が必要
`--toolset=v143`

## TBB
- [[IntelTBB]]
- tbb2019_20190410oss_win.zip

# PXR_STATIC
plugin が動かなくなる？

# Optional dependencies
- [[OpenSubdiv]]
- [[ptex]]

# 構成
plugin の基盤
- usd
	- usd_sdf
		- usd_ar
			- base/usd_plug

各種プラグイン
 - usdGeom
  
# build_scripts/build_usd.py
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
