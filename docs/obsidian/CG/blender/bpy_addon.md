[[blender]]
[[modeling]]

# bl_info

[Process/Addons/Guidelines/metainfo - Blender Developer Wiki](https://wiki.blender.org/wiki/Process/Addons/Guidelines/metainfo)

```python
bl_info = {
     "name": "addons name",
     "author": "suggypop",
     "version": (0, 0, 1),
     "blender": (2, 83, 0),
     "location": "3D View",
     "description": "アドオンの説明",
     "warning": "これはサンプルのアドオンです",
     "support": "TESTING",
     "wiki_url": "",
     "tracker_url": "",
     "category": "Object"
}
```

# fake-bpy-module
- [GitHub - nutti/fake-bpy-module: Fake Blender Python API module collection for the code completion.](https://github.com/nutti/fake-bpy-module)

# folder
- `INSTALL_DIR\2.80\scripts\addons`
- `%USERPROFILE%\AppData\Roaming\Blender Foundation\Blender\2.79\scripts\addons`

# Operator

```python
class MESH_OT_InsetStraightSkeleton(bpy.types.Operator):
    bl_idname = "mesh.insetstraightskeleton"
    bl_label = "Inset Straight Skeleton"
    bl_description = "Make an inset inside selection using straight skeleton algorithm"
    bl_options = {'UNDO', 'REGISTER', 'GRAB_CURSOR', 'BLOCKING'}
```

# パネル
```python
class HelloWorldPanel(bpy.types.Panel):
	# `[A-Z][A-Z0-9_]*_{Separator}_[A-Za-z0-9_]+`
    bl_idname = "OBJECT_PT_hello_world"
```

# サブパネル

```python
class OBJ_PT_import_transform(bpy.types.Panel):
    bl_parent_id = "FILE_PT_operator" # sub panel
    bl_space_type = 'FILE_BROWSER'
    bl_region_type = 'TOOL_PROPS'
    bl_label = "Transform"
```

# Exporter
```python
class ExportOBJ(bpy.types.Operator, ExportHelper):
    """Save a Wavefront OBJ File""" 
    bl_idname = "export_scene.obj" # 命名規則は？
    bl_label = 'Export OBJ'
    bl_options = {'PRESET'}
```

# Importer
```python
class ImportOBJ(bpy.types.Operator, ImportHelper):
    """Load a Wavefront OBJ File"""
    bl_idname = "import_scene.obj"
    bl_label = "Import OBJ"
    bl_options = {'PRESET', 'UNDO'}
```


# register_class
 `bpy.utils.register_class(cls)`
 `bpy.utils.register_class(cls)`

# addons

- [TexTools](http://renderhjs.net/textools/blender/)
- [GitHub - samytichadou/Auto_Reload_Blender_addon: Handy automatic reload for Image Textures](https://github.com/samytichadou/Auto_Reload_Blender_addon)
- [Blender Add-on : Pose Library Thumbnails [ver2.0.4~]](https://gumroad.com/l/spmxY)
- [「Sorcar」Blenderでプロシージャルモデリング出来るノードエディター - 3DCG最新情報サイト MODELING HAPPY](https://modelinghappy.com/archives/28623)

AddOn紹介
[https://www.youtube.com/watch?v=SC5qpe0Emmg]
