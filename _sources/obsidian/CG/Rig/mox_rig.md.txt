- [フリーリグ｜株式会社モックス - 3DCGアニメーションを手付けモーションでより魅力的に。](https://mox-motion.com/freerig/)

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
