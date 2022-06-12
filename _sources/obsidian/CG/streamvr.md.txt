[SteamVRで自作のデバイスやソフトを簡単にトラッカーとして認識させる方法(バーチャルモーショントラッカー) - Qiita](https://qiita.com/gpsnmeajp/items/29adc31f30e531fe8023)

steamvr
#unity #openvr

	https://developer.valvesoftware.com/wiki/SteamVR/Environments
	https://steamcommunity.com/app/250820/discussions/

設定
`C:/Steam/steamapps/common/SteamVR/resources/settings/default.vrsettings`

[** 2.0]
OpenVRのUnityWrapper + The Lab の Interaction system
	https://valvesoftware.github.io/steamvr_unity_plugin/articles/Interaction-System.html
	https://www.slideshare.net/shohashimoto4/steamvr-plugin-20
	https://steamcommunity.com/games/250820/announcements/detail/1696059027982397407

	[SteamVR2.0のInteractionシステムが超便利だから使ってみよう https://qiita.com/ZeniZeni/items/7ee19ee2725305188cc3]
	[SteamVR Plugin 2.0 セットアップ・サンプルシーンを動かすまでの備忘録 https://qiita.com/kyourikey/items/5967018e613b2fd49a1f]
	https://github.com/ValveSoftware/steamvr_unity_plugin

[** 1.0]
2回インストールしたらなおった
`TypeLoadException: Could not load type 'System.Action' from assembly`

	SteamVR_Controller.cs
	[Unity SteamVR Pluginのソースを読む Part2 https://kazumalab.hatenablog.com/entry/2017/07/04/065540]

[** 実装]
[*  openvr_api.cs]
	[SteamVR(HTC Vive) Unity插件深度分析（二） http://gad.qq.com/article/detail/27050]

[* COpenVRContext]


#openvr #steamvr

https://github.com/ValveSoftware/steamvr_unity_plugin

`openvr.h` の Unity ラッパー
	https://github.com/ValveSoftware/openvr/blob/master/headers/openvr_api.cs `1.9.16` openvr.h と同じ
	https://github.com/ValveSoftware/steamvr_unity_plugin/tree/master/Assets/SteamVR/Plugins `OpenVR SDK 1.8.19`
	https://github.com/ValveSoftware/openvr/tree/master/samples/unity_teleport_sample/Assets/Plugins `OpenVR SDK 0.9.2
