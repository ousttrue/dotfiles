[[bpy]]

- [Collection(ID) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Collection.html#bpy.types.Collection)

```python
root = bpy.data.scenes[0].collection
```

# all_objects
[[bpy.types.Object]]

```python
for o in collection.all_objects:
	print(o.data)
```

