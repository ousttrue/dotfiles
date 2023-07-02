[[blender]]
[[bpy]]

- [Collection(ID) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Collection.html#bpy.types.Collection)

```python
root = bpy.data.scenes[0].collection
```

- [Blender 2.83 のコレクション・ビューレイヤー操作](https://dskjal.com/blender/how-to-use-collection.html#move-collection)
- [ベテランジェネラリストのBlender基礎レッスン 第5回：Blenderのシーン構成（2）Collection](https://cgworld.jp/regular/202101-ggblender-05.html)

# all_objects
[[bpy.types.Object]]

```python
for o in collection.all_objects:
	print(o.data)
```


# instance
- [【Blender】インスタンスを利用したオブジェクトの複製｜yugaki](https://note.com/info_/n/n5417ca687fb8)
