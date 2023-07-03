[[bpy]]

- [Armature(ID) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Armature.html#bpy.types.Armature)

```python
for bone in a.bones:
	print(bone)
```
[[bpy.types.Bone]]

# POSE mode

```python
@contextlib.contextmanager
def enter_pose(obj: bpy.types.Object):
    bpy.context.view_layer.objects.active = obj
    if bpy.context.mode == 'POSE':
        yield
    else:
        bpy.ops.object.posemode_toggle()
        try:
            yield
        finally:
            bpy.context.view_layer.objects.active = obj
            bpy.ops.object.posemode_toggle()        
                
```

# Snap
カーソルによるハックでできる。
バグ仕様みたいな。
- [rigging - Snapping Bones to Bones (In Other Armature) - Blender Stack Exchange](https://blender.stackexchange.com/questions/194024/snapping-bones-to-bones-in-other-armature)
