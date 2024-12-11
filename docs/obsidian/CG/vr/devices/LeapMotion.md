---
aliases:
  - UltraLeap
---

[[XR_EXT_hand_tracking]]
[[MotionCapture]]

- [Download Ultraleap's Hand Tracking Software — Ultraleap for Developers](https://developer.leapmotion.com/tracking-software-download)
- [Tracking API - Ultraleap documentation](https://docs.ultraleap.com/tracking-api/)

- @2019 [LeapMotion SDK スタートアップ (C API / v4) - Qiita](https://qiita.com/moccos/items/0aa986714df58fb837d0)
- @2015 [連載：C++で始めるLeap Motion開発 ―― タッチUIの先のカタチ ―― - Build Insider](https://www.buildinsider.net/small/leapmotioncpp)[]

# Version

https://developer.leapmotion.com/releases/

| version   | websocket | 3di |
| --------- | --------- | --- |
| 4(orion)  | ok        | x   |
| 5(gemini) | x         | ok  |

## 5.7.2 Gemini

gemini ?

## 4.0 Orion

    4.4
    4.3.4

# hardware

## controller2

- [11年ぶりの新型 ハンドトラッキング用デバイス「Leap Motion Controller 2」が発表 - Mogura VR News](https://www.moguravr.com/leap-motion-controller-2-announcements/)

## 3di

## leapmotion

`@2012`

# websocket daemon

`ws://localhost:6437`

- @2022 [バニラな JavaScript や p5.js で Leap Motion の情報を取得する（leap.js ではなく WebSocket を利用） - Qiita](https://qiita.com/youtoy/items/efc4da1feee26186f565)
- @2013 [LeapMotionのモーション情報をJavaScriptで取得する仕組み - Intelligent Technology's Technical Blog](https://iti.hatenablog.jp/entry/2013/11/28/172240)
- [GitHub - leapmotion/leapjs: JavaScript client for the Leap Motion Controller](https://github.com/leapmotion/leapjs)

## aframe

- [GitHub - openleap/aframe-leap-hands: A-Frame VR component for Leap Motion.](https://github.com/openleap/aframe-leap-hands)

## server

- https://gist.github.com/jselstad/6c6cbbb558e0b1858baab185eb764960

# dev

- [Leap Motion C API: LeapC Guide](https://developer.leapmotion.com/documentation/v4/index.html)
- [Leap Motion C API: 3D Drawing Example](https://developer.leapmotion.com/documentation/v4/glut-example.html)

https://developer.leapmotion.com/documentation/v4/index.html
[LeapMotionでPythonを使ってジェスチャーで家電を操作する https://vaaaaaanquish.hatenablog.com/entry/2018/09/23/222002]
https://github.com/leapmotion

[* unity]
Leap_Motion_Core_Assets_4.4.0.unitypackage
[LeapMotionで3Dモデルの手を動かす https://qiita.com/Ichitar0/items/c455a92d149fe6f0ebfd]
[LeapMotion Orionでキャラクターの手を動かす https://qiita.com/afjk/items/e2c9617e937528feba6e]
https://qiita.com/shiftsphere/items/5cf757a59e95b5c1359b
https://qiita.com/BobZombie/items/3c4234e23afd8b8c05d1
https://atl-hiroo.recruit-tech.co.jp/2018/01/unity_leap-motion/

## 3

- [Leap Motion Release Notes — Leap Motion C++ SDK v3.2 Beta documentation](https://developer-archive.leapmotion.com/documentation/cpp/supplements/SDK_Release_Notes.html)
- [GitHub - leapmotion/LeapC-samples: The LeapSDK LeapC samples configured to build under Visual Studio 2017](https://github.com/leapmotion/LeapC-samples)
- [Leap Motion C API: Using LeapC](https://developer-archive.leapmotion.com/documentation/LeapC/a00024.html)

## 2

- @2015 [これは快適！ Leap Motion v2で格段に良くなったSkeletal Tracking機能 - Build Insider](https://www.buildinsider.net/small/leapmotionupdate/201507)

# OpenXR

[[openxr_api_layer]]

- [Ultraleap releases OpenXR integration | Ultraleap](https://www.ultraleap.com/company/news/developer/openxr-integration/)
- [Ultraleap OpenXR Hand Tracking API Layer - Ultraleap documentation](https://docs.ultraleap.com/openxr/)

- [GitHub - ultraleap/OpenXRHandTracking: OpenXR API layer enabling XR_EXT_hand_tracking support using Ultraleap tracking](https://github.com/ultraleap/OpenXRHandTracking)

## Unity

- [OpenXR with Unity - Ultraleap documentation](https://docs.ultraleap.com/unity-api/OpenXR%20with%20Unity/index.html)
- [OpenXR hand tracking in Unity - Ultraleap documentation](https://docs.ultraleap.com/ultralab/openxr-hand-tracking-in-unity)
- [Ultraleap Plugin for Unity — Ultraleap for Developers](https://developer.leapmotion.com/unity)

# BVH

- [GitHub - seanschneeweiss/RoSeMotion: Hand Motion Capture from a 3D Leap Motion Controller for a Musculoskeletal Dynamic Simulation implemented in Python](https://github.com/seanschneeweiss/RoSeMotion)

# LEAP_CONNECTION_MESSAGE

```c++
void serviceMessageLoop(){
	LEAP_CONNECTION_MESSAGE msg;
	while(_isRunning){
		unsigned int timeout = 1000;
		auto result = LeapPollConnection(connectionHandle, timeout, &msg);
		//Handle message
	}
}
```

@2019 `v4` [LeapMotion SDK スタートアップ (C API / v4) - Qiita](https://qiita.com/moccos/items/0aa986714df58fb837d0)

# types

`LeapC.h`

```c
struct LEAP_FRAME_HEADER {
	void* reserved;
	int64_t frame_id;
	int64_t timestamp;
}
```

## LEAP_TRACKING_EVENT

```c
struct LEAP_TRACKING_EVENT {
	LEAP_FRAME_HEADER info;
	int64_t tracking_frame_id;
	uint32_t nHands;
	LEAP_HAND* pHands;
	float framerate;
};
```

## LEAP_HAND

```c
enum eLeapHandType {
  eLeapHandType_Left,
  eLeapHandType_Right
};

struct LEAP_HAND
{
	uint32_t id;
	eLeapHandType type;

	LEAP_DIGIT thumb;
	LEAP_DIGIT index;
	LEAP_DIGIT middle;
	LEAP_DIGIT ring;
	LEAP_DIGIT pinky;
	LEAP_BONE arm;
	LEAP_PALM palm;
};
```

## LEAP_DIGIT

指

```c
struct LEAP_DIGIT
{
	LEAP_BONE metacarpal;
	LEAP_BONE proximal;
	LEAP_BONE intermediate;
	LEAP_BONE distal;
};
```

## LEAP_BONE

```c
struct LEAP_BONE
{
	LEAP_VECTOR prev_joint;
	LEAP_VECTOR next_joint;
	float width;
	LEAP_QUATERNION rotation;
};

struct LEAP_VECTOR
{
	float x;
	float y;
	float z;
};
```

## LEAP_PALM

```c
struct LEAP_PALM
{
	LEAP_VECTOR position;
	LEAP_VECTOR stabilized_position;
	LEAP_VECTOR velocity;
	LEAP_VECTOR normal;
	float width;
	LEAP_VECTOR direction;
	LEAP_QUATERNION orientation;
};
```

# eLeapEventType

## Connection

## ConnectionLost

## Device

## DeviceFailure

## DeviceLost

## Tracking

=> `LEAP_TRACKING_EVENT`

[[LeapMotion|UltraLeap]]

- @2022 [Ultraleap 3Diを試してみた | 1→10 lab / ワンテンラボ](https://labs.1-10.com/2022/05/ultraleap-3di%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F/)
- @2022 [【比較動画あり】「UltraLeap 3Di」と「Leap Motion Controller」をVTuberが比較レビュー。より便利になった使い心地をチェック！ - MoguLive](https://www.moguravr.com/ultraleap-3di-leap-motion-controller-comparative-review/)
- @2022 [Ultraleap 3Diを試してみた | 1→10 lab / ワンテンラボ](https://labs.1-10.com/2022/05/ultraleap-3di%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F/)
- @2022 [Leap Motion最新モデル「Ultraleap 3Di -ステレオハンドトラッキングカメラ-」がAmazonにて販売開始 | V-Tuber ZERO](https://vtub0.com/news/48851)
