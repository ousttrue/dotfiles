[[bpy_addon]]

- VIEW3D_MT_view
- VIEW3D_MT_object
- VIEW3D_MT_mesh_add


```python
def draw_menu(self, context):
    layout = self.layout
    layout.separator()
    layout.operator("node.duplicate_move", text="My new context menu item")

def register():
    bpy.types.NODE_MT_context_menu.append(draw_menu)

def unregister():
    bpy.types.NODE_MT_context_menu.remove(draw_menu)
```
