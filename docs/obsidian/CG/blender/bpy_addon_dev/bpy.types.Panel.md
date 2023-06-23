bpy.types.Panel
[[bpy]]

- [Quickstart — Blender Python API](https://docs.blender.org/api/current/info_quickstart.html#example-panel)
- [Panel(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Panel.html)
```python
import bpy


class HelloWorldPanel(bpy.types.Panel):
    bl_idname = "OBJECT_PT_hello_world"
    bl_label = "Hello World"
    bl_space_type = 'PROPERTIES'
    bl_region_type = 'WINDOW'
    bl_context = "object"

    def draw(self, context):
        self.layout.label(text="Hello World")


class SomePanel(bpy.types.Panel): 
     bl_space_type = "VIEW_3D"
     bl_region_type = "UI" # 右上のパネル
     bl_category = "TAB_NAME" # 勝手に決めてよい
     bl_label = "SECTION_NAME" # 開閉するところの名前。勝手に決めてよい

class BodyRatiosPanel(bpy.types.Panel):
     bl_idname = "OBJECT_PT_body_ratios"
     bl_label = "body ratios"
     bl_space_type = "VIEW_3D"
     bl_region_type = "TOOLS"
     bl_category = "Body Ratios"
 
     @classmethod
     def poll(cls, context):
         for o in bpy.data.objects:
             if o.select:
                 return True
         return False
 
     def draw(self, _context):
         self.layout.label(text="Hello World")
```

# Version
## 3.x

## 2.8
- [Blender 2.79 の UI スクリプト集](https://dskjal.com/blender/ui-script.html)
- https://memoteu.hatenablog.com/entry/2019/06/17/132448
- [【Blender 2.8 アドオン開発】006 UI - Panel編 - - めもてう](https://memoteu.hatenablog.com/entry/2019/06/17/132448)

# Panel
- [Dev:Py/Scripts/Cookbook/Code snippets/Interface - BlenderWiki](https://en.blender.org/index.php/Dev:Py/Scripts/Cookbook/Code_snippets/Interface)
- https://blenderartists.org/t/how-to-make-a-value-slider/663324/3

## bl_space_type
- [Space Type Items — Blender Python API](https://docs.blender.org/api/current/bpy_types_enum_items/space_type_items.html#rna-enum-space-type-items)

## bl_region_type
- [Region Type Items — Blender Python API](https://docs.blender.org/api/current/bpy_types_enum_items/region_type_items.html#rna-enum-region-type-items)

## bl_context

## bl_category
