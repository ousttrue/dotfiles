[[rig]]
[[blender]]
[[bpy.types.Bone]]
[[mox_rig]]

- @2020 [【Blender】速攻で歩行サイクルアニメーションをつくる｜yugaki｜note](https://note.com/info_/n/ndccf33cd8975)

# roll

| 部位                                   | X+             | roll |
| -------------------------------------- | -------------- | ---- |
| 胴体(hips-spine-neck-head)             | 前屈           |      |
| 左腕(shoulder-upper-lower)             | 肘の曲がる方向 | +90  |
| 右腕(shoulder-upper-lower)             | 肘の曲がる方向 | -90  |
| 手指(hand-index, middle, ring, little) | 指の曲がる方向 | 180  |
| 左親指                                 | 指の曲がる方向 | -90  |
| 右親指                                 | 指の曲がる方向 | +90  |
| 足(upper-lower-foot                    | 膝の曲がる方向 |      |
| つま先(upper-lower-foot                | 膝の曲がる方向 | 180  |

- `YAxis = head -> tail`
- `Ctrl-R`
- [boneのロール角度を変更する（blender→MMD）-Cobweb of にーしか](http://24ka.blog.fc2.com/blog-entry-1290.html)
- [ボーンのローカル回転軸設定](https://dskjal.com/blender/local-axis-setting.html)
- [【Blender】検証と考察：ボーンの適切な軸方向、回転軸｜yugaki](https://note.com/info_/n/n5b7e732f7e74)

## vec_roll_to_mat3_normalized

```c
void vec_roll_to_mat3_normalized(const float nor[3], const float roll, float r_mat[3][3]);
```

- [blender/source/blender/blenkernel/intern/armature.c at master · dfelinto/blender · GitHub](https://github.com/dfelinto/blender/blob/master/source/blender/blenkernel/intern/armature.c#L2084)

## mat3_to_vec_roll

- [empties_to_bones/empties_to_bones.py at master · artellblender/empties_to_bones · GitHub](https://github.com/artellblender/empties_to_bones/blob/master/empties_to_bones.py#L49)

- [How to calculate the bone direction and roll from matrix and vice versa (glTF importer)? - glTF - Khronos Forums](https://community.khronos.org/t/how-to-calculate-the-bone-direction-and-roll-from-matrix-and-vice-versa-gltf-importer/109473/3)

# customshape

- [【Blender】ボーングループとカスタムシェイプ｜yugaki](https://note.com/info_/n/n43e63ad9fec3)
- [GitHub - BlenderDefender/BoneWidget: Blender addon for easy custom bone shapes](https://github.com/BlenderDefender/boneWidget)
  - [GitHub - waylow/boneWidget: Blender add-on for making bone shape](https://github.com/waylow/boneWidget)
- [GitHub - LesFeesSpeciales/blender-rigging-scripts: Addons to automate rigging tasks in Blender.](https://github.com/LesFeesSpeciales/blender-rigging-scripts/tree/master)

## root

|      |       |                     |
| ---- | ----- | ------------------- |
| root | Root1 | 十字                |
| head | Cube  | size:0.5, slide:0.5 |

# picker

[【Rigi Picker】 Rigify や自分のリグのボーン選択を補助するピッカーアドオン【Blenderアドオン】 - Bookyakuno - BOOTH](https://bookyakuno.booth.pm/items/2385943)

# IK switch

- Limit Location
- [Blender で IK/FK 一致スクリプトを書く](https://dskjal.com/blender/ik-fk-snap.html)
- [Blender で IK-FK 切り替えスイッチ](https://dskjal.com/blender/IK-FK-switch.html)
- [BlenderでIK/FKスイッチを作る方法 | 3DCG school](https://3dcg-school.pro/blender-ik-fk-switching/)
  driver: influence

# constraint

## bone constraint

- @2022 [Blenderボーンコンストレイントを名前基準で一括設定 - Qiita](https://qiita.com/yukimituki11/items/0a9f864271046cdc996e)
- @2021 [【Blender3.0】コンストレイントでアニメーション作業を効率化！！ | CGbox](https://cgbox.jp/2021/12/28/blender-constraint/)

## 足IK

- @2020 [【Blender】シンプルなボーンとリグのつくり方｜yugaki](https://note.com/info_/n/nb0ee9f7d2d0a)
- @2020 [【Blender】改良）シンプルなボーンとリグのつくり方｜yugaki](https://note.com/info_/n/n1e04f3db69e7)
- 膝1cm前進
- target, not connect, parent = root
- poleTarget, not connect, parent = root
- chain2
- pollAngle-90

# specific

## InvertedPelvis

- [骨盤のボーン配置](https://dskjal.com/blender/rigging-pelvis.html)

## reverse foot

- [Blender でリバースフットリグを組む](https://dskjal.com/blender/reverse-foot-rig.html)
- [#08 リバースフットリグで足先を動かそう！ [Blender Rig道] - YouTube](https://www.youtube.com/watch?v=hmjGLL2i3-A&ab_channel=Yonaoshi3D)
- @2020 [＜Blender＞リバースフットリグってなんなんな｜ななっしゅ](https://note.com/nanash_/n/n3fd0d0219543)
- @2018 [アニメーション練習用リグ 配布（Blender 簡易リバースフット付き） | k.m-Z blog](http://flash.zzz.heavy.jp/?eid=585145)
- [エコなリバースフットリグ | 株式会社ヘキサドライブ | HEXADRIVE | ゲーム制作を中心としたコンテンツクリエイト会社](https://hexadrive.jp/hexablog/creative/25546/)
- [【blender】　汎用人型リグ/リバースフット部分の構造セットアップ解説 | TOY-BOX](https://toy-box.link/2019/09/24/post-1536.html)
- [リバースフットリグ　左足だけ設定 | 「Promised 君の空へ」制作中](https://ameblo.jp/promised-kiminosorae/entry-12494496130.html)
- [キャラクターリグ(8) - リバースフット - - メモ帳](http://sakana0147.blog53.fc2.com/blog-entry-864.html)
- [Blenderでビーチサンダルのモデリング | 三次のおやつブログ](https://tonakai1070.com/blender_beach_sandals)

## 指まとめて 曲げる/広げる

- [＜Blender＞トランスフォーム変換と位置制限｜ななっしゅ](https://note.com/nanash_/n/nb1b6e4a02580)
- shape paddle
- rock scale: xz
- constraint
  - copy rotation [rigging - How to rig the fingers - Blender Stack Exchange](https://blender.stackexchange.com/questions/162255/how-to-rig-the-fingers)

## 親指

- [ロボットハンドモデリングの親指の関節問題 | 三次のおやつブログ](https://tonakai1070.com/blender_manipulator_thumb)

## 球体関節

- [＃005「脇」をガン見して球体関節モデリングを研究する - YouTube](https://www.youtube.com/watch?v=RA-v2-SVHiA&ab_channel=onitikuTRAIN)
- [桃プリンと愉快なBlender (@momojiri@pawoo.net) - Pawoo](https://pawoo.net/@momojiri)

## メカ

- [ロボット開発への妄想を具現化　Blenderで作るメカニカルな動きの表現 | Vook(ヴック)](https://vook.vc/n/3854)

## Finger

- [Blender 3.4 Hand & Finger Rig | Tutorial 3 - YouTube](https://www.youtube.com/watch?v=wBfSA1mDATY&ab_channel=MKGraphics)
- [Blender で指のリグ](https://dskjal.com/blender/finger-rig.html)
- [GitHub - Jetpack-Crow/autogrip](https://github.com/Jetpack-Crow/autogrip)

- [ツイート / Twitter](https://twitter.com/Bookyakuno/status/1464862521115176960)
- [2つのリグのみで手の指を動かす【リグの作り方 / Blender】 – 忘却まとめ](https://bookyakuno.com/control-fingers-with-only-two-rigs/)

- [#07 指の自動曲げ伸ばしRig [Blender Rig道] - YouTube](https://www.youtube.com/watch?v=WLdm0b9yMn4&ab_channel=Yonaoshi3D)

# download

- [リギングの参考になる無償配布のリグ付きキャラクタモデル < アニメーションとリギング < 知っておきたい機能 | Blender入門(3.0 / 3.1 / 3.2 / 3.3版)](https://blender3d.biz/knowledge_animationandrigging_distributedfreerigmodels.html)
- [【Blenderフリーリグ】素体モデル『SOTA』 - コマット通販 - BOOTH](https://booth.pm/ja/items/2165393)
- [Blender Animation Rig Lisks /Blenderで使用できるフリーのリグ付きモデルリンク集 | ohweb](https://ohweb.work/blender-animation-rig-lisks/)
- [Red-Nelb Rig Blender 2.8x - CG Cookie | Learn Blender, Online Tutorials and Feedback](https://cgcookie.com/downloads/red-nelb-rig-blender-2-8x?utm_source=blendernation&utm_content=red-nelb-rig-blender-2-8x)
