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

# constraint
## driver
- [スクリプトからドライバーをつける&IK/FK切り替えスイッチの自動セットアップ](https://dskjal.com/blender/add-driver-with-python.html)
- [Adding driver to pose bone constraint through Python - Game Engine / Game Engine Support and Discussion - Blender Artists Community](https://blenderartists.org/t/adding-driver-to-pose-bone-constraint-through-python/570419)
