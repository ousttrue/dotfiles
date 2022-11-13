[Fetching Title#7bn3](https://gitlab.freedesktop.org/xrdesktop/xrdesktop)[[buildtool]]
[[gst-python]]

- [The Meson Build system](https://mesonbuild.com/)
- @2022 [Mesonの使い方メモ - はしくれエンジニアもどきのメモ](https://cartman0.hatenablog.com/entry/2022/03/24/Meson%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9%E3%83%A1%E3%83%A2)
- @2019 [［Meson］Meson for C++の苦闘記 - 地面を見下ろす少年の足蹴にされる私](https://onihusube.hatenablog.com/entry/2019/09/20/023511)
- @2018 [CMakeの代替 (となってほしい)、Mesonチュートリアル - Qiita](https://qiita.com/turenar/items/c727834fbf701beb47ef)

# entry_point

`mesonbuild.mesonmain:main`

# Wrap dependency system
- [Meson WrapDB packages](https://mesonbuild.com/Wrapdb-projects.html)

## cmake subproject
- [meson で cmake プロジェクトを subproject として使う - Qiita](https://qiita.com/syoyo/items/ad965b5127188c356074)

## vscode debugger
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "meson",
            "type": "python",
            "request": "launch",
            "module": "mesonbuild.mesonmain",
            "args": [
                "compile",
                "-C",
                "build"
            ],
            "cwd": "${workspaceFolder}",
            "justMyCode": false
        },
    ]
}
```

## override_dependency

```
subprojects\pango\pango\meson.build:171:6: ERROR: Tried to override dependency 'pango' which has already been resolved or overridden at D:\ghq\github.com\GNOME\gtk\meson.build:391:
```

gtk
```
pango_dep      = dependency('pango', version: pango_req,
                            fallback : ['pango', 'libpango_dep'])

pangocairo_dep = dependency('pangocairo', version: pango_req,
                            fallback : ['pango', 'libpangocairo_dep'])				
```

pango
```meson
libpango_dep = meson.declare_dependency()
meson.override_dependency('pango', libpango_dep)
```



# [[GTK4]]
- [bitWalk's: GTK4 を触ってみた (2) ～ Meson でビルド ～](https://bitwalk.blogspot.com/2020/12/gtk4-2-meson.html)
	