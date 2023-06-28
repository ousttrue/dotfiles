[[bpy_addon]]

- VIEW3D_MT_view
- VIEW3D_MT_object
- VIEW3D_MT_mesh_add

```python
def menu_func(self, context):
    for op in OPERATORS:
        self.layout.operator(op.bl_idname)
```
