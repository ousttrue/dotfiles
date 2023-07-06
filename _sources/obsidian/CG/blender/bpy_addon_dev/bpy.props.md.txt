- [Property Definitions (bpy.props) — Blender Python API](https://docs.blender.org/api/current/bpy.props.html)

# bool

## boolVector

# int
## intVector

# float
## floatVector

# string

# enum

# pointer

[`bpy.types.PropertyGroup`](https://docs.blender.org/api/current/bpy.types.PropertyGroup.html#bpy.types.PropertyGroup "bpy.types.PropertyGroup") or [`bpy.types.ID`](https://docs.blender.org/api/current/bpy.types.ID.html#bpy.types.ID "bpy.types.ID").
 
```python
class MaterialSettings(bpy.types.PropertyGroup):
    my_int: bpy.props.IntProperty()
    my_float: bpy.props.FloatProperty()
    my_string: bpy.props.StringProperty()

bpy.utils.register_class(MaterialSettings)

bpy.types.Material.my_settings = bpy.props.PointerProperty(type=MaterialSettings)
```

# collection
