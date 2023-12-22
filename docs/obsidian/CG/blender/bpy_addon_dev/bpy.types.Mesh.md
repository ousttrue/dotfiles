[[bpy]]

```python
mesh_obj: bpy.types.Object
	mesh: bpy.types.Mesh = mesh_obj.data
		vertex: bpy.types.MeshVertex = mesh.vertices[0]
	group: bpy.types.VertexGroup = mesh_obj.groups[0]
```

- [Mesh(ID) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Mesh.html)
	- [MeshVertex(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.MeshVertex.html)
- [VertexGroup(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.VertexGroup.html#bpy.types.VertexGroup)

# Mesh
## from_pydata
- [Blender PythonのMeshデータアクセスのチートシート - Qiita](https://qiita.com/kenyoshi17/items/b93bbba6451e3c6017e5)

## separate
- [Mesh Operators — Blender Python API](https://docs.blender.org/api/current/bpy.ops.mesh.html)

実行後は、`context.selected_objects` で分割された Object にアクセスできるぽい
- [scripting - Scritping: rename while using bpy.ops.mesh.separate(type='MATERIAL') - Blender Stack Exchange](https://blender.stackexchange.com/questions/42385/scritping-rename-while-using-bpy-ops-mesh-separatetype-material)

## BMesh
[[BMesh]]

# Vertex
## selection
- [How do I select specific vertices in blender using python script? - Blender Stack Exchange](https://blender.stackexchange.com/questions/43127/how-do-i-select-specific-vertices-in-blender-using-python-script)

```python
bpy.ops.object.mode_set(mode = 'OBJECT')
obj = bpy.context.active_object
bpy.ops.object.mode_set(mode = 'EDIT') 
bpy.ops.mesh.select_mode(type="VERT")
bpy.ops.mesh.select_all(action = 'DESELECT')
bpy.ops.object.mode_set(mode = 'OBJECT')
obj.data.vertices[0].select = True # only object mode
bpy.ops.object.mode_set(mode = 'EDIT') 
```

## Shapekey
- [Blenderでシェイプキー名一覧を取得・一覧から空のシェイプキーを作成 - Qiita](https://qiita.com/yukimituki11/items/e40d4d5f7cc21e2b7c4b)
## VertexGroup
- [頂点グループを調べる｜Hajime Saito](https://note.com/replicorn/n/n8f7f3ec49d65)
- [Blenderで利用可能なpythonスクリプトを作る その２０（頂点グループの追加と削除） - MRが楽しい](https://bluebirdofoz.hatenablog.com/entry/2019/07/02/091942)

# Polygon
## MeshPolygon
- [MeshPolygon(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.MeshPolygon.html)

## FaceMap
- [Blender のフェイスマップとは何か](https://dskjal.com/blender/face-map-proposal.html)
- [Zen Sets for Blender - Vertex Groups and Face Maps (v2.0) - YouTube](https://www.youtube.com/watch?v=xg14N_pLcIU&ab_channel=SergeyTyapkin)

