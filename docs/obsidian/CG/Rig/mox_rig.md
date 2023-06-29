- [フリーリグ｜株式会社モックス - 3DCGアニメーションを手付けモーションでより魅力的に。](https://mox-motion.com/freerig/)

- [MoxRig for Blender2.8 公開｜株式会社モックス](https://mox-motion.com/blog/moxrig-for-blender280/)

- @2021 [自称プロCGアニメーターU｜note](https://note.com/u_tube/)
- @2021 [モモちゃんRig(β) 公開｜株式会社モックス](https://mox-motion.com/blog/momo_rig_information/)
- @2020 [【Blender】速攻で歩行サイクルアニメーションをつくる｜yugaki](https://note.com/info_/n/ndccf33cd8975)
- @2017 https://cgworld.jp/feature/201705-mox-motion02.html

# 構成
`Armature(rig => fk) => Armature(Skeleton => mesh)`
- pose mode にしないと見えない
- 一度にひとつの Armature しか pose mode にできない？

- hips => copy world position + rotation
	- spine => copy world rotation
	- left leg => copy world rotation
	- right leg => copy world rotation

# Rig
- rig_All root
	- LEG IK
		- pole target
		- foot (copy rotation)
	- COG(center of gravity ?) inverted pelvis
		- spine(上半身)
		- hips(下半身)
		- arm ik + copy rotation
		- arm pole

## controller
- tail を(0, 1, 0) に退避
### root/COG
移動 + 回転
### FK
cube(胴体、指)
### IK target
box(leg), cross(hand)
### pole
pyramid

## offsetボーンとIK操作
- layer2 に隠蔽
- CustomShapeの １階層下に world 回転コピー用ボーン(offset)を配置している
	- offse は tail 方向を copy 先と一致させるために配置。head は parent.head と同じ位置。

## 胴体
- inverted pelvis用？
- bone(custom shape) tail not connect
	- bone.offset tail connect

## 腕(upper, lower)
- layer2 に隠蔽
- IK

## 足
- layer2 に隠蔽
- IK
- foot.offset

# 構築手順
- root
- COG
	- tail 40cm
	- connected: False
	- parent: root
	- spine の位置
- pelvis
	- connected: False
	- parent: COG
	- tail: hips.head
- hips:
	- parent: pelvis
	- lock
- spine
	- inherit rotation: false

## LegIK
- add: LegIK.L
	- from: lowerLeg.tail
	- connected: False
	- parent: root
- add: LegPole.L 
	- from: upperLeg.tail
	- connected: False
	- parent: LegIK.L
- LowerLeg.L: constraint: IK
	- target: LegIK.L
	- pole: LegPole.L
	- pole angle: -90
	- chain: 2
- 膝10cm前進
- copy: foot.L
	- connected: False
	- parent: LegIK.L
- Foot.L: constraint: copy rotation

## ArmIK
- copy: hand.L to ArmIK.L
	- connected: False
	- parent: COG
	- roll: 0 ?
- add: ArmPole.L 
	- connected: False
	- parent.ArmIK.L
- LowerArm: constraint: IK 
- Hand: constraint: copy rotation 
