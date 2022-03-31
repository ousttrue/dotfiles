PyBullet
#python #bulletphysics #URDF

https://pybullet.org/
	https://pybullet.org/Bullet/BulletFull/

	forward dynamics simulation
 inverse dynamics computation
 forward and inverse kinematics

https://github.com/erwincoumans/pybullet_robots

[* build]
$ .\premake4.exe vs2010
CMakeの方は全部入りではない。

[* python module]
> pip install pybullet

code:.py
 import pybullet as p
 physicsClient = p.connect(p.GUI)

	DIRECT: local
	GUI: local with GUI
	SHARED_MEMORY

[* sample]
`bullet3/examples/pybullet/examples`

[* GUI, GUI_SERVER]
	b3CreateInProcessPhysicsServerAndConnect

	class PhysicsClient

[* SHARED_MEMORY]
server
	App_SharedMemoryPhysics
 App_SharedMemoryPhysics_GUI

client
	App_SharedMemoryPhysics_VR

[* UDP]
enet library
	App_PhysicsServerUDP 
	App_PhysicsServerSharedMemoryBridgeUDP

[* TCP]
clsocket 
	App_PhysicsServerTCP
		`Starting TCP server using port 6667`
	App_PhysicsServerSharedMemoryBridgeTCP

[* GRPC ]

[pybulletをインストールする https://qiita.com/saketosakana/items/6fc4e9400034cea5b81d]
[pybulletインストールメモ https://demura.net/misc/15615.html] 
[Pybulletでマルチシミュレーションを行う https://gokids.hatenablog.com/entry/2018/10/18/184419]

[* vrbullet]
https://docs.google.com/document/d/1I4m0Letbkw4je5uIBxuCfhBcllnwKojJAyYSTjHbrH8/edit#
`build_visual_studio_vr_pybullet_double.bat`

[* impl]
`class PhysicsServerExample`　
	SharedMemoryCommon `SHARED_MEMORY` isConnected, wantsTermination setSharedMemoryKey
		CommonExampleInterface

code:empty_server.cpp
 // GUIの無い空のサーバー
   {
     DummyGUIHelper noGfx;
     CommonExampleOptions options(&noGfx);
     auto example =
         (SharedMemoryCommon *)PhysicsServerCreateFuncBullet2(options); // internal class PhysicsServerExample
     example->initPhysics();
     while (example->isConnected()) {
       if (example->wantsTermination()) {
         break;
       }
       example->stepSimulation(1.f / 60.f);
     }
     example->exitPhysics();
     delete example;
   }

createCollisionShape/createVisualShape

humanoidMotionCapture.py

PhysicsServerSharedMemory


physics
#PyBullet

https://book.impress.co.jp/books/3282


http://www.natural-science.or.jp/article/20130922210408.php

[* mujoco]
https://github.com/openai/mujoco-py
