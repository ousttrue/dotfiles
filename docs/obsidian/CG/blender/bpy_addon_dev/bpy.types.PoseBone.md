[[bpy.types.Bone]]
[[blender_rig]]

[PoseBone(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.PoseBone.html#bpy.types.PoseBone)

```python
bones = o.pose.bones
```

# lock_rotation

```python
import bpy

print('### start ###')

obj = bpy.context.active_object

for b in obj.pose.bones:
    if b.bone.select:
        #b.lock_rotation[1]=True
        #b.lock_rotation[2]=True
        print(b.name, [l for l in b.lock_rotation])
```
