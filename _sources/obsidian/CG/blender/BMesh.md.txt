> Blender’s internal mesh editing API

- [Source/Modeling/BMesh/Design - Blender Developer Wiki](https://wiki.blender.org/wiki/Source/Modeling/BMesh/Design)

# from_edit_mesh
- [Blenderでbmeshを操作 | コマンドの達人](https://life-is-command.com/blender-bmesh/)
- [Blender2.8で利用可能なpythonスクリプトを作る その２５（オブジェクトの分離） - MRが楽しい](https://bluebirdofoz.hatenablog.com/entry/2020/05/09/225003)

## selction
```python
import bpy
import bmesh

context = bpy.context

bpy.ops.mesh.primitive_plane_add(
        enter_editmode=True)
ob = context.object
me = ob.data

bm = bmesh.from_edit_mesh(me)
for i, v in enumerate(bm.verts):
    v.select_set(not i)
bm.select_mode |= {'VERT'}
bm.select_flush_mode()
bmesh.update_edit_mesh(me)
```

# from_mesh
`ObjectMode OK`
`readonly ?`
- [blender python bmeshをオブジェクトモードで使う方法 - アストラルプリズム](https://katsumi3.hatenablog.com/entry/2020/01/28/223355)
