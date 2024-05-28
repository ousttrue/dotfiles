[[rig]]

- @2022 [Inverse Kinematics(IK)について - SEGA TECH Blog](https://techblog.sega.jp/entry/sega_inverse_kinematics202210)
- @2020 [UE4.26 Control Rig における IK ノードまとめ - ほげたつブログ](https://hogetatu.hatenablog.com/entry/2020/12/03/000009)

[[FullBodyIK]]

InverseKinematics
[Inverse Kinematicsを用いたキャラクターの姿勢操作](https://zenn.dev/fukazaemon/articles/1eef820cfebad6)

# CCD-IK

link(chain)の末端が effector.
`effector` 位置が `target` 位置に近くなる回転を求める。

| app | target     | effector                         | link                             |
| --- | ---------- | -------------------------------- | -------------------------------- |
| pmd | 2:IK       | 4:IK影響下(ik_target_bone_index) | 6:IK接続先(ik_parent_bone_index) |
| pmx | 0x0020: IK |                                  | link                             |

# ヤコビアン

- [ヤコビ行列を使ったIKについて: メモブログ](http://sssiii.seesaa.net/article/383489955.html)

- [GitHub - atulr/InverseKinematics: Inverse Kinematics solver using Jacobian inverse](https://github.com/atulr/InverseKinematics)
- [GitHub - jesse-y/Jacobian-Transpose-IK-Solver: An inverse kinematics solver using the Jacobian Transpose matrix with Denavit-Hartenberg representation for the kinematic chain.](https://github.com/jesse-y/Jacobian-Transpose-IK-Solver)
- [GitHub - myindrata/Pseudo-Inverse-Jacobian-Inverse-Kinematics](https://github.com/myindrata/Pseudo-Inverse-Jacobian-Inverse-Kinematics)
- [GitHub - agh372/3D-Inverse-Kinematics: C++ OpenGL application implementing Inverse Kinematics on a linkage of 3 joints and 9 degrees of freedom using Jacobian Transpose method](https://github.com/agh372/3D-Inverse-Kinematics)
- [Site Unreachable](https://cnc-selfbuild.blogspot.com/2021/04/ik.html)
