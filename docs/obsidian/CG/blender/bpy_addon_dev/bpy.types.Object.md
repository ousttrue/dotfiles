[[bpy]] 

[Object(ID) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Object.html#bpy.types.Object)

```python
active = bpy.context.active_object
```

# data block
`ID` タイプ？
```python
obj.data
```

## Mesh
[[bpy.types.Mesh]]

## Armature
[[bpy.types.Armature]]

# active_object
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

# select
```python
bpy.context.selected_objects
```


# custom property
- [Blenderのカスタムプロパティの使い方 - Qiita](https://qiita.com/SaitoTsutomu/items/b6cfd5aeb760d49ea657)