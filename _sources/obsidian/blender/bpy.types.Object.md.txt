[[bpy]] 

[Object(ID) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Object.html#bpy.types.Object)

```python
active = bpy.context.active_object
```

# data block
## Mesh
[[bpy.types.Mesh]]

# mode
context.mode は active_object の mode

```python
 import bpy
 #現在のモード取得
 bpy.context.mode

 # アクティブオブジェクトを設定する
 bpy.context.view_layer.objects.active = obj
 #オブジェクトモードに変更
 bpy.ops.object.mode_set('OBJECT',toggle=False)
 ```

 # pose
[[bpy.types.Pose]]

```python
o = bpy.context.active_object
pose = o.pose

for b in pose.bones:
	print(b)
```
