[[bpy]]

- [Bone(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Bone.html)

```python
def get_roots(a):
    for bone in a.bones:
        if not bone.parent: # parent
            yield bone
          
def traverse(b, indent=''):
    print(f'{indent}{b}')
    for child in b.children: # children
        traverse(child, indent + '  ')
                
o = get_armature()
a = o.data
for root in get_roots(a):
    traverse(root)
```
