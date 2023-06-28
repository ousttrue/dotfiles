[[rig]]
[[blender]]
[[bpy.types.Bone]]

- @2020 [【Blender】速攻で歩行サイクルアニメーションをつくる｜yugaki｜note](https://note.com/info_/n/ndccf33cd8975)
# create
## bone構築

|部位|X+|roll|
| - |  - |  - |
|胴体(hips-spine-neck-head)|前屈|
|左腕(shoulder-upper-lower)|肘の曲がる方向|+90|
|右腕(shoulder-upper-lower)|肘の曲がる方向|-90|
|手指(hand-index, middle, ring, little)|指の曲がる方向|180|
|左親指|指の曲がる方向|-90|
|右親指|指の曲がる方向|+90|
|足(upper-lower-foot|膝の曲がる方向|
|つま先(upper-lower-foot|膝の曲がる方向|180|

### roll
- `Ctrl-R`
- [boneのロール角度を変更する（blender→MMD）-Cobweb of にーしか](http://24ka.blog.fc2.com/blog-entry-1290.html)
- [ボーンのローカル回転軸設定](https://dskjal.com/blender/local-axis-setting.html)
- [【Blender】検証と考察：ボーンの適切な軸方向、回転軸｜yugaki](https://note.com/info_/n/n5b7e732f7e74)

- `YAxis = head -> tail`

### logic
```c
void vec_roll_to_mat3_normalized(const float nor[3], const float roll, float r_mat[3][3]);
```
- [blender/source/blender/blenkernel/intern/armature.c at master · dfelinto/blender · GitHub](https://github.com/dfelinto/blender/blob/master/source/blender/blenkernel/intern/armature.c#L2084) 

- [empties_to_bones/empties_to_bones.py at master · artellblender/empties_to_bones · GitHub](https://github.com/artellblender/empties_to_bones/blob/master/empties_to_bones.py#L49)

- [How to calculate the bone direction and roll from matrix and vice versa (glTF importer)? - glTF - Khronos Forums](https://community.khronos.org/t/how-to-calculate-the-bone-direction-and-roll-from-matrix-and-vice-versa-gltf-importer/109473/3)

## customshape
- [GitHub - BlenderDefender/BoneWidget: Blender addon for easy custom bone shapes](https://github.com/BlenderDefender/boneWidget)
	- [GitHub - waylow/boneWidget: Blender add-on for making bone shape](https://github.com/waylow/boneWidget)
- [【Blender】ボーングループとカスタムシェイプ｜yugaki](https://note.com/info_/n/n43e63ad9fec3)

|bone|shape||
|-|-|-|
|root|root|replace|
|hips|pyramid|replace|
|spine|||
|chest|chest|replace|


## root
十字Shape

## 足IK
- @2020 [【Blender】シンプルなボーンとリグのつくり方｜yugaki](https://note.com/info_/n/nb0ee9f7d2d0a)

## 指まとめて曲げる
- shape paddle
- rock scale: xz
- constraint
	- copy rotation [rigging - How to rig the fingers - Blender Stack Exchange](https://blender.stackexchange.com/questions/162255/how-to-rig-the-fingers)

# download
- [リギングの参考になる無償配布のリグ付きキャラクタモデル < アニメーションとリギング < 知っておきたい機能 | Blender入門(3.0 / 3.1 / 3.2 / 3.3版)](https://blender3d.biz/knowledge_animationandrigging_distributedfreerigmodels.html)
- [フリーリグ｜株式会社モックス - 3DCGアニメーションを手付けモーションでより魅力的に。](https://mox-motion.com/freerig/)
- [【Blenderフリーリグ】素体モデル『SOTA』 - コマット通販 - BOOTH](https://booth.pm/ja/items/2165393)
- [Blender Animation Rig Lisks /Blenderで使用できるフリーのリグ付きモデルリンク集 | ohweb](https://ohweb.work/blender-animation-rig-lisks/)
- [Red-Nelb Rig Blender 2.8x - CG Cookie | Learn Blender, Online Tutorials and Feedback](https://cgcookie.com/downloads/red-nelb-rig-blender-2-8x?utm_source=blendernation&utm_content=red-nelb-rig-blender-2-8x)

# Finger
- [Blender 3.4 Hand & Finger Rig | Tutorial 3 - YouTube](https://www.youtube.com/watch?v=wBfSA1mDATY&ab_channel=MKGraphics)
- [Blender で指のリグ](https://dskjal.com/blender/finger-rig.html)
- [GitHub - Jetpack-Crow/autogrip](https://github.com/Jetpack-Crow/autogrip)

- [ツイート / Twitter](https://twitter.com/Bookyakuno/status/1464862521115176960)
- [2つのリグのみで手の指を動かす【リグの作り方 / Blender】 – 忘却まとめ](https://bookyakuno.com/control-fingers-with-only-two-rigs/)

- [#07 指の自動曲げ伸ばしRig [Blender Rig道] - YouTube](https://www.youtube.com/watch?v=WLdm0b9yMn4&ab_channel=Yonaoshi3D)

# addon
### Rigify
[[Rigify]]

- [【Blender】シンプルなボーンとリグのつくり方｜yugaki｜note](https://note.com/info_/n/nb0ee9f7d2d0a)
- [[blender] インポートしたVRMをリグ化するスクリプト（説明欄からダウンロードできます） - YouTube](https://www.youtube.com/watch?v=NPmhARRFYDk&ab_channel=%E3%81%8B%E3%82%93%E3%81%9F%E3%81%9F)

構築済
- [Animation Fundamentals Rigs v1.0 - Animation Fundamentals - Blender Studio](https://studio.blender.org/training/animation-fundamentals/5d69ab4dea6789db11ee65d1/)

### autorig
