[[rig]]

# CustomShape
- [GitHub - waylow/boneWidget: Blender add-on for making bone shape](https://github.com/waylow/boneWidget)

# Finger
- [Blender 3.4 Hand & Finger Rig | Tutorial 3 - YouTube](https://www.youtube.com/watch?v=wBfSA1mDATY&ab_channel=MKGraphics)
- [Blender で指のリグ](https://dskjal.com/blender/finger-rig.html)
- [GitHub - Jetpack-Crow/autogrip](https://github.com/Jetpack-Crow/autogrip)

- [ツイート / Twitter](https://twitter.com/Bookyakuno/status/1464862521115176960)
- [2つのリグのみで手の指を動かす【リグの作り方 / Blender】 – 忘却まとめ](https://bookyakuno.com/control-fingers-with-only-two-rigs/)

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
