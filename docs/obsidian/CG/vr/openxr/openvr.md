# steamvr (openvr)

https://github.com/ValveSoftware/openvr
https://github.com/ValveSoftware/openvr/wiki/API-Documentation
https://github.com/OpenVR-Advanced-Settings/OpenVR-AdvancedSettings
https://github.com/gpsnmeajp/EasyOpenVRUtil/wiki/接続デバイス管理
https://github.com/elvissteinjr/DesktopPlus

# repos

- https://github.com/ousttrue/VRExperiment
- https://github.com/ousttrue/ExtraTracker

- https://github.com/terminal29/Simple-OpenVR-Driver-Tutorial
- https://github.com/alvr-org/ALVR
- https://github.com/schellingb/PseudoVive

# version

## 1.11.11

- https://github.com/ValveSoftware/openvr/releases/tag/v1.11.11

## 1.9.16

- https://github.com/ValveSoftware/openvr/commit/39205f6b281a6131d1373d0217c1ab9ed19735ea

## 0.9.16

- https://github.com/ValveSoftware/openvr/commit/c174bafe1e3d150ff44d23209f89e312bda93189

# config

`%STEAM%\steamapps\common\SteamVR\resources\settings\steamvr.vrsettings`

- [steamvr.vrsettingsのメモ書き - Ρの日本語練習ブログ](https://ugokutennp.hatenablog.com/entry/2022/02/10/222621)
- [Oculus Quest＋ALVR＋BaseStation2.0+Tracker2018 で、フルトラ化（BaseStation2.0+Tracker2018セットアップ）｜かせー](https://note.com/kasei_s/n/n10e12d021e2a)

## DriverManifest

- https://github.com/ValveSoftware/openvr/wiki/DriverManifest

## NoHeadset

- https://github.com/username223/SteamVRNoHeadset
- https://www.reddit.com/r/Vive/comments/6uo053/how_to_use_steamvr_tracked_devices_without_a_hmd/
- [HTC Vive TrackerをUnityでHMDレスで使いたい時に出るエラーを回避する - しゃの](https://syan0.hatenadiary.org/entry/20180316/1521199910)

## nulldevice の有効化

`%STEAM%\steamapps\common\SteamVR\drivers\null\resources\settings\default.vrsettings`

```json
{
  "driver_null": {
    "enable": true
  }
}
```

# driver

`msvc` でビルドするべし。`zig` は動かない？

- [Virtual Motion Trackerを作ったときのノウハウ #VR - Qiita](https://qiita.com/gpsnmeajp/items/9c41654e6c89c6b9702f)
- https://github.com/ousttrue/OpenVR-InputEmulator

# openvr.h

INIT
vrserver.exe(SteamVR) に接続する。
無ければ起動する。
Shutdownはvrserver.exeの停止でアプリはやらなくてよい

```cpp
 /** enum values to pass in to VR_Init to identify whether the application will
 * draw a 3D scene. */
 enum EVRApplicationType
 {
 	VRApplication_Other = 0,		// Some other kind of application that isn't covered by the other entries
 	VRApplication_Scene	= 1,		// Application will submit 3D frames
 	VRApplication_Overlay = 2,		// Application only interacts with overlays
 	VRApplication_Background = 3,	// Application should not start SteamVR if it's not already running, and should not
 									// keep it running if everything else quits.
 	VRApplication_Utility = 4,		// Init should not try to load any drivers. The application needs access to utility
 									// interfaces (like IVRSettings and IVRApplications) but not hardware.
 	VRApplication_VRMonitor = 5,	// Reserved for vrmonitor
 	VRApplication_SteamWatchdog = 6,// Reserved for Steam
 	VRApplication_Bootstrapper = 7, // rese	rved for vrstartup
 	VRApplication_WebHelper = 8,	// reserved for vrwebhelper

 	VRApplication_Max
 };

	// Loading the SteamVR Runtime
	vr::EVRInitError eError = vr::VRInitError_None;
	auto vr = vr::VR_Init(&eError, vr::VRApplication_Scene);
```

    VRApplication_Scene
    ApplicationType_Overlay: overlays or the dashboard.
    VRApplication_Background. 既存のServerに接続する。起動しない

# unity

## openvr_api.cs

https://qiita.com/gpsnmeajp/items/923c7210a5967a27a5f4

## CVRSystem

https://github.com/ValveSoftware/openvr/wiki/IVRSystem_Overview
[HTC Vive向けにアプリケーションを開発する〜コントローラでインタラクション編〜 http://vr-lab.voyagegroup.com/entry/2016/10/13/003204]

## GetDeviceToAbsoluteTrackingPose

http://shop-0761.hatenablog.com/entry/2018/01/08/034418

# Overlay

[ダッシュボードオーバーレイ（OpenVR overlay）を作りimguiとDirectXで描いてみる](https://qiita.com/ondorela/items/bf4bebf747f90ebf52d8)

## IVRVirtualDisplay

https://github.com/ValveSoftware/virtual_display

- https://github.com/ibrahimduran/openvr

HMDの最終画像を得る。Wirelessヘッドセットへの転送など

## IVRCompositor

openvr mirrorwindow

`vr::IVRCompositor::ShowMirrorWindow`
`vr::IVRCompositor::CloseMirrorWindow`

```cpp
/** Opens a shared D3D11 texture with the undistorted composited image for each eye. Use ReleaseMirrorTextureD3D11 when finished
_ instead of calling Release on the resource itself. _/
virtual vr::EVRCompositorError GetMirrorTextureD3D11( vr::EVREye eEye, void \*pD3D11DeviceOrResource, void **ppD3D11ShaderResourceView ) = 0;
virtual void ReleaseMirrorTextureD3D11( void \*pD3D11ShaderResourceView ) = 0;
```
