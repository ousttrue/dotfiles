[Source/Modeling/BMesh/Design - Blender Developer Wiki](https://wiki.blender.org/wiki/Source/Modeling/BMesh/Design)

> Blender’s internal mesh editing API

- [Blender の python スクリプトの Tips](https://dskjal.com/blender/python-script-tips.html)

- @2022 [blender python で、meshの縁のedgeを選択 - end0tknr&#39;s kipple - web写経開発](https://end0tknr.hateblo.jp/entry/20221021/1666298016)
- @2022 [blender python で いろいろ処理 - end0tknr&#39;s kipple - web写経開発](https://end0tknr.hateblo.jp/entry/20221021/1666297830)
- @2021 [Blenderのメッシュ調査](https://zenn.dev/hzuika/scraps/f15bf5a13a07bc)

- @2012 [扉の先の無限の世界　　～Blender 2.5 & 2.6 で作る3DCG～ BMeshの使い方](http://silverspirecg.blog119.fc2.com/blog-entry-66.html)
- @2012 [扉の先の無限の世界　　～Blender 2.5 & 2.6 で作る3DCG～ BMesh概要](http://silverspirecg.blog119.fc2.com/blog-entry-65.html)

# cycles

## the Disk Cycle
## the Radial Cycle
## the Loop Cycle

# impl

- https://github.com/tkchanat/manifold

## Unity

- https://github.com/eliemichel/BMeshUnity
- https://github.com/CodeSmile-0000011110110111/GMesh

## jMonkeyEngine

- https://github.com/FennelFetish/jBMesh

## js

- https://github.com/sketchpunklabs/bmesh

# py

https://docs.blender.org/api/blender2.8/bmesh.ops.html

## crease

- https://blender.stackexchange.com/questions/275841/how-to-change-value-of-edge-crease-via-python-script

##  from_edit_mesh

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
