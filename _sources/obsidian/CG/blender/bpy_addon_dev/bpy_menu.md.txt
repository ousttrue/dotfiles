[[bl_info]]


```python
class Operator(bpy.types.Operator):
	bl_idname = armature.add_humanoid

def menu_func(self, context):
	self.layout.operator(
		MESH_OT_add_helix.bl_idname, 
		text="Helix", 
		icon='MESH_CUBE')

def register():
    bpy.types.NODE_MT_context_menu.append(draw_menu)

def unregister():
    bpy.types.NODE_MT_context_menu.remove(draw_menu)
```


## menu に追加。
```python
def add_to_menu(menu: str, op):
    def menu_func(self, context):
        if hasattr(op, "bl_icon"):
            self.layout.operator(op.bl_idname, icon=op.bl_icon)
        else:
            self.layout.operator(op.bl_idname)

    getattr(bpy.types, menu).prepend(menu_func)
```

- `VIEW3D_MT_armature_add` (Add - Armature に追加する)
- `VIEW3D_MT_mesh_add`
- `VIEW3D_MT_view`
- `VIEW3D_MT_object`

## submenu
- [[Blender] プラグインでサブメニューを作成する方法 - Qiita](https://qiita.com/nutti/items/3f75f34adab99a805a35)


# MENU
- [Menu(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Menu.html) 
```python
import bpy

class BasicMenu(bpy.types.Menu):
    bl_idname = "OBJECT_MT_select_test"
    bl_label = "Select"

    def draw(self, context):
        layout = self.layout

        layout.operator("object.select_all", text="Select/Deselect All").action = 'TOGGLE'
        layout.operator("object.select_all", text="Inverse").action = 'INVERT'
        layout.operator("object.select_random", text="Random")```
