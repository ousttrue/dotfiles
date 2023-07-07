[[bpy]]

- [Quickstart — Blender Python API](https://docs.blender.org/api/current/info_quickstart.html#example-panel)
- [Panel(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Panel.html)

# Version
## 3.x

## 2.8
- [Blender 2.79 の UI スクリプト集](https://dskjal.com/blender/ui-script.html)
- https://memoteu.hatenablog.com/entry/2019/06/17/132448
- [【Blender 2.8 アドオン開発】006 UI - Panel編 - - めもてう](https://memoteu.hatenablog.com/entry/2019/06/17/132448)

# Panel
- [Dev:Py/Scripts/Cookbook/Code snippets/Interface - BlenderWiki](https://en.blender.org/index.php/Dev:Py/Scripts/Cookbook/Code_snippets/Interface)
- https://blenderartists.org/t/how-to-make-a-value-slider/663324/3

## 場所
### bl_space_type
- [Space Type Items — Blender Python API](https://docs.blender.org/api/current/bpy_types_enum_items/space_type_items.html#rna-enum-space-type-items)

### bl_region_type
- [Region Type Items — Blender Python API](https://docs.blender.org/api/current/bpy_types_enum_items/region_type_items.html#rna-enum-region-type-items)

### bl_category

## 表示
### bl_label
名前

### bl_context
- [python - When declaring a panel, what does the 'bl_context' value need to be? - Blender Stack Exchange](https://blender.stackexchange.com/questions/73145/when-declaring-a-panel-what-does-the-bl-context-value-need-to-be)
- object
- material
- armature_edit

細かく制御したいときは、`def poll` を使う

## code
```python
import bpy

class HelloWorldPanel(bpy.types.Panel):
    bl_idname = "OBJECT_PT_hello_world"
    bl_space_type = 'PROPERTIES'
    bl_region_type = 'WINDOW'
    bl_label = "Hello World"
    bl_context = "object"

    @classmethod
    def poll(cls, context):
        return isinstance(context.active_object.data, bpy.types.Armature)

    def draw(self, context):
        self.layout.label(text="Hello World")
```

# icon
- [blender-icon-list.py · GitHub](https://gist.github.com/eliemichel/251731e6cc711340dfefe90fe7e38ac9)

# layout
- [UILayout(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.UILayout.html)
- [python - How to use template_any_ID() into Ui Layout? - Blender Stack Exchange](https://blender.stackexchange.com/questions/214038/how-to-use-template-any-id-into-ui-layout)
