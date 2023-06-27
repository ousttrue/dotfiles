[[bpy]]

- [Bone(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Bone.html)
- [Blender Python のボーンアクセスチートシート](https://dskjal.com/blender/bone-script.html)

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

# Axis
- [ボーンのローカル回転軸設定](https://dskjal.com/blender/local-axis-setting.html)
- [【Blender】検証と考察：ボーンの適切な軸方向、回転軸｜yugaki](https://note.com/info_/n/n5b7e732f7e74)

- `YAxis = head -> tail`

## logic
```c
void vec_roll_to_mat3_normalized(const float nor[3], const float roll, float r_mat[3][3]);
```
- [blender/source/blender/blenkernel/intern/armature.c at master · dfelinto/blender · GitHub](https://github.com/dfelinto/blender/blob/master/source/blender/blenkernel/intern/armature.c#L2084) 

- [empties_to_bones/empties_to_bones.py at master · artellblender/empties_to_bones · GitHub](https://github.com/artellblender/empties_to_bones/blob/master/empties_to_bones.py#L49)

- [How to calculate the bone direction and roll from matrix and vice versa (glTF importer)? - glTF - Khronos Forums](https://community.khronos.org/t/how-to-calculate-the-bone-direction-and-roll-from-matrix-and-vice-versa-gltf-importer/109473/3)
