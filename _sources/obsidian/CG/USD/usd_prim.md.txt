- [UsdGeomImageable 完全に理解した - Qiita](https://qiita.com/takahito-tejima/items/54eccf9b93d6e386186e)

`root`
```python
stage = Usd.Stage.CreateNew('HelloWorld.usda')
```

# UsdGeom
## Xform
いわゆる `empty` のこと？
- [Xform](https://www.sidefx.com/ja/docs/houdini/nodes/lop/createxform.html)
- [Documents_USD/doc/usd_prim_transform.md at master · ft-lab/Documents_USD · GitHub](https://github.com/ft-lab/Documents_USD/blob/master/doc/usd_prim_transform.md)
- [Documents_USD/doc/usd_prim_transform.md at master · ft-lab/Documents_USD · GitHub](https://github.com/ft-lab/Documents_USD/blob/master/doc/usd_prim_transform.md)

```python
xformPrim = UsdGeom.Xform.Define(stage, '/hello')
```


## Sphere
```python
spherePrim = UsdGeom.Sphere.Define(stage, '/hello/world')
```

## Cube
