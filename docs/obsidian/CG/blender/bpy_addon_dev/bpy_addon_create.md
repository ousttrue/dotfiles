[[bpy]]

- [Add-on Tutorial — Blender Manual](https://docs.blender.org/manual/en/latest/advanced/scripting/addon_tutorial.html)

`%APPDATA%/Blender Foundation/Blender/3.5/scripts/addons/hoge.py`

or

`%APPDATA%/Blender Foundation/Blender/3.5/scripts/addons/hoge/__init__.py`

# articles
- @2021 [Blender addonを作ろう｜Kageji](https://note.com/kageji/n/ncbacc5428a55)

# structure
## bl_info
```python
{
    "name": "HumanPose",
    "blender": (3, 5, 0),
    "category": "Object",
}
```

## operator
## menu
## panel

## register/unregister
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

# tools
## watch
- [Blender 3.5で、addonにTestingを復活させる方法 - Qiita](https://qiita.com/SaitoTsutomu/items/5872c5e0358394360697)
- [Blenderのアドオン作成のメモ - Qiita](https://qiita.com/SaitoTsutomu/items/6b8e6e734c99be6eeb5e)

## Blender Development
debugger ?
- [【Blender】アドオン開発環境構築 | ツクロウヤ](https://www.omusubi-tech.com/?p=422)

## fake-bpy
- [4-3. BlenderのAPIをコード補完する | はじめてのBlenderアドオン開発](https://colorful-pico.net/introduction-to-addon-development-in-blender/2.8/html/chapter_04/03_Code_Complete_Blender_API.html)
