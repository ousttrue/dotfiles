[[blender]]
[[bpy]]
[[bpy.types.Scene]]

- [Collection(ID) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Collection.html#bpy.types.Collection)
- [Blender 2.83 のコレクション・ビューレイヤー操作](https://dskjal.com/blender/how-to-use-collection.html#move-collection)
- [ベテランジェネラリストのBlender基礎レッスン 第5回：Blenderのシーン構成（2）Collection](https://cgworld.jp/regular/202101-ggblender-05.html)

# scene
`scene` は collection の木で構築される
```python
root = bpy.context.scene.collection
```

## collection の親子

```python
collection.children.link(child_collection)
```

# objects
[[bpy.types.Object]]

## empty に対する親子との違い

- empty の親に対する操作は子供に影響しない(可視性など)
- collection に対する操作はメンバーに影響する(可視性など)

## collection に object を入れる
```python
object.parent = collection
# ではなく
collection.objects.link(object)
```

## all_objects
再帰的な列挙

```python
for o in collection.all_objects:
	print(o.data)
```

# instance
- [【Blender】インスタンスを利用したオブジェクトの複製｜yugaki](https://note.com/info_/n/n5417ca687fb8)
