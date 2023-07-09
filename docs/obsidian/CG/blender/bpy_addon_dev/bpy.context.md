[[bpy]]

[Context Access (bpy.context) — Blender Python API](https://docs.blender.org/api/latest/bpy.context.html)
[Context(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Context.html)

# Object
[[bpy.types.Object]]

## active
`readonly`
`view_layer.objects.active` へのショートカットか？
```python
object = bpy.context.active_object
```

### mode
- [【Blender】【Python】bpy.ops.object.mode_set が context is incorrect で失敗する - ゲーム作りが大好きな人のブログ](https://toofu0.hatenablog.com/entry/2020/10/10/033418)
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
 
## selected
```python
object = bpy.context.selected_objects
```

# ViewLayer
`writable`
```python
bpy.context.view_layer.objects.active = None
```
