[[bpy]]

[Context Access (bpy.context) — Blender Python API](https://docs.blender.org/api/latest/bpy.context.html)
[Context(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Context.html)

```python
import bpy
scene = bpy.context.scene
```

# Screen ? Context
https://docs.blender.org/api/latest/bpy.context.html#screen-context
[[bpy.types.Scene]]

## active object
```python
object = bpy.context.active_object
```

[[bpy.types.Object]]

- [【Blender】【Python】bpy.ops.object.mode_set が context is incorrect で失敗する - ゲーム作りが大好きな人のブログ](https://toofu0.hatenablog.com/entry/2020/10/10/033418)

## selected objects
```python
object = bpy.context.selected_objects
```
