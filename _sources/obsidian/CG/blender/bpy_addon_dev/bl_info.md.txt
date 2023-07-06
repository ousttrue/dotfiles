[[bpy]]

`timeline` のところに `info` を表示しておく

# path
- `%APPDATA%/Blender Foundation/Blender/2.79/scripts/addons/ADDON_NAME.py`
- `%APPDATA%/Blender Foundation/Blender/2.79/scripts/addons/ADDON_NAME/__init__.py`

# bl_info

- [Add-on Tutorial — Blender Manual](https://docs.blender.org/manual/en/latest/advanced/scripting/addon_tutorial.html)
- [Process/Addons/Guidelines/metainfo - Blender Developer Wiki](https://wiki.blender.org/wiki/Process/Addons/Guidelines/metainfo)
- @2021 [Blender addonを作ろう｜Kageji](https://note.com/kageji/n/ncbacc5428a55)

```python
bl_info = {
	# 必須
	"name": "addons name",
	"version": (3,0,0),
}
```

## 登録に関する情報
### support
- "TESTING" # TESTING は 3.5 で廃止
- "COMMUNITY": default
- "OFFICIAL"

つまり書かなくて良い。
 
### category
3D View Add Mesh Add Curve Animation Compositing Development Game Engine Import-Export Lighting Material Mesh Node Object Paint Physics Render Rigging Scene Sequencer System Text Editor UV UserInterface

### blender
 `(major, minor, patch)`
```python
(2, 83, 0)
```

## パネルに表示する情報
### description
`text`
自由に書いて良い

### location
`text`
UIのアクセス方法。自由に書いて良い

### author
`text`

### version
`(major, minor, patch)`

### warning
`text`
自由に書いて良い

### wiki_url
`text`

### tracker_url
`text`

# class
## Operator
[[bpy.types.Operator]]

## Panel
[[bpy.types.Panel]]

## Property
[[bpy.types.ProertyGroup]]

# register/unregister
```python
# 作ったクラスを格納
classes = [KJ_Monkey_Panel,KJ_Create_Monkey]

# belnderに登録する関数
def register():
   for cls in classes:
       bpy.utils.register_class(cls)
   # メニュー関数はappendする
   bpy.types.VIEW3D_MT_mesh_add.append(menu_monkey)

# belnderから登録解除する関数
def unregister():
   for cls in classes:
       bpy.utils.unregister_class(cls)
   bpy.types.VIEW3D_MT_mesh_add.remove(menu_monkey)

# pythonファイルを実行するおまじない
if __name__ == "__main__":
   register()
```

## Menu
`メニュー登録も必須！`
[[bpy_menu]]


# tools
## watch
- [Blender 3.5で、addonにTestingを復活させる方法 - Qiita](https://qiita.com/SaitoTsutomu/items/5872c5e0358394360697)
- [Blenderのアドオン作成のメモ - Qiita](https://qiita.com/SaitoTsutomu/items/6b8e6e734c99be6eeb5e)

## Blender Development
debugger ?
- [【Blender】アドオン開発環境構築 | ツクロウヤ](https://www.omusubi-tech.com/?p=422)

# LSP
- [VSCodeでBlenderスクリプト編集環境準備 - Hello World / plɹoM ollǝH](https://dungeonneko.hatenablog.com/entry/2021/04/05/002319)

## fake-bpy-module
- [GitHub - nutti/fake-bpy-module: Fake Blender Python API module collection for the code completion.](https://github.com/nutti/fake-bpy-module)
## fake-bpy
- [4-3. BlenderのAPIをコード補完する | はじめてのBlenderアドオン開発](https://colorful-pico.net/introduction-to-addon-development-in-blender/2.8/html/chapter_04/03_Code_Complete_Blender_API.html)

# reload
- [Python で from import を reload する。 - graphics.hatenablog.com](https://graphics.hatenablog.com/entry/2017/12/03/004714#%E3%81%9D%E3%82%82%E3%81%9D%E3%82%82%E3%81%AA%E3%82%93%E3%81%A7-reload-%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)

```python
if "bpy" in locals():
    import importlib
	# reload してから from import するべし
    importlib.reload(humanoid_parts_properties)  # type: ignore
    importlib.reload(humanoid_parts_panels)  # type: ignore
    importlib.reload(humanoid_parts_search)  # type:ignore

import bpy  # type: ignore
from .humanoid_parts_properties import HumanoidProperties
from .humanoid_parts_panels import HumanoidPartsAssemblePanel
from .humanoid_parts_search import HumanoidPartsSearch
```
