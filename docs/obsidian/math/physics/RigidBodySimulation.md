剛体シミュレーション

https://codeberg.org/drummyfish/tinyphysicsengine

- https://github.com/felipeek/raw-physics

- [GitHub - wbierbower/awesome-physics: 🌌 A collaborative list of awesome software for exploring Physics concepts](https://github.com/wbierbower/awesome-physics)

[GitHub - xissburg/edyn: Edyn is a real-time physics engine organized as an ECS.](https://github.com/xissburg/edyn)

- @2013  [剛体シミュレーションをまとめてみる - Qiita](https://qiita.com/edo_m18/items/6051d2d8e422a41d0c13)
	- @2013 [自作2D物理エンジンを作った話 - Qiita](https://qiita.com/edo_m18/items/f7698c5bd262df4f9cf3)
- @2008 [https://cedec.cesa.or.jp/2008/archives/file/pg07.pdf](https://cedec.cesa.or.jp/2008/archives/file/pg07.pdf)

# pipeline
## update velocity / angular velocity
重力など
- 力
- トルク

## CollisionDetection
[[CollisionDetection]]

## ConstraintSolver

## update position / rotation

角速度積分
- [クォータニオンを使った、トラックボール風カメラ制御 - KAYAC engineers' blog](https://techblog.kayac.com/control-camera-using-quaternion)
```
orientation += orientation * (angularVelocity * (0.5 * dt))
```


# Implementations
- [GitHub - DanielChappuis/reactphysics3d: Open source C++ physics engine library in 3D](https://github.com/DanielChappuis/reactphysics3d)

## JoltPhysics
- [Jolt Physics: Jolt Physics Samples](https://jrouwe.github.io/JoltPhysics/md__docs__samples.html)
- [GitHub - jrouwe/JoltPhysics: A multi core friendly rigid body physics and collision detection library suitable for games and VR applications.](https://github.com/jrouwe/JoltPhysics)

## mujoco
- [GitHub - deepmind/mujoco: Multi-Joint dynamics with Contact. A general purpose physics simulator.](https://github.com/deepmind/mujoco)

## ReactPhysics3D
- [GitHub - DanielChappuis/reactphysics3d: Open source C++ physics engine library in 3D](https://github.com/DanielChappuis/reactphysics3d)

## qu3e
- [GitHub - RandyGaul/qu3e: Lightweight and Simple 3D Open Source Physics Engine in C++](https://github.com/RandyGaul/qu3e)

## Chrono
- [GitHub - projectchrono/chrono: High-performance C++ library for multiphysics and multibody dynamics simulations](https://github.com/projectchrono/chrono)

## PositionBased
- [GitHub - jamornsriwasansak/brass-pan: A position-based physics engine](https://github.com/jamornsriwasansak/brass-pan)

- [GitHub - InteractiveComputerGraphics/PositionBasedDynamics: PositionBasedDynamics is a library for the physically-based simulation of rigid bodies, deformable solids and fluids.](https://github.com/InteractiveComputerGraphics/PositionBasedDynamics)

# BulletPhysics系
## BulletPhysics
[[bullet]]
[[easy_physics]]

## PhysicsEffects
[GitHub - erwincoumans/PhysicsEffects](https://github.com/erwincoumans/PhysicsEffects)
- [LT140: PhysicsEffects メモ](http://lt140.blogspot.com/2009/12/physicseffects.html)

## EasyPhysics
- [ゲーム制作者のための物理シミュレーション　剛体編 - インプレスブックス](https://book.impress.co.jp/books/3282)
