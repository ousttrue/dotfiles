[[Open3D]]

https://github.com/microsoft/Azure-Kinect-Sensor-SDK

https://learn.microsoft.com/ja-jp/azure/kinect-dk/body-sdk-download

[Azure Kinect DK のドキュメント | Microsoft Docs](https://docs.microsoft.com/ja-jp/azure/Kinect-dk/)
- [GitHub - microsoft/Azure-Kinect-Samples: Samples for Azure Kinect](https://github.com/microsoft/Azure-Kinect-Samples)

# k4a
[Azure-Kinect-Sensor-SDK/usage.md at develop · microsoft/Azure-Kinect-Sensor-SDK · GitHub](https://github.com/microsoft/Azure-Kinect-Sensor-SDK/blob/develop/docs/usage.md)
`C:\Program Files\Azure Kinect SDK v1.4.1`

- [GitHub - microsoft/Azure-Kinect-Sensor-SDK: A cross platform (Linux and Windows) user mode SDK to read data from your Azure Kinect device.](https://github.com/microsoft/Azure-Kinect-Sensor-SDK)

-   深度カメラへのアクセスとモード制御 (パッシブ IR モードに加えて、広視野と狭視野の深度モード)
-   RGB カメラへのアクセスと制御 (露出やホワイト バランスなど)
-   モーション センサー (ジャイロスコープと加速度計) へのアクセス
-   深度カメラと RGB カメラの同期ストリーミング (カメラ間の遅延を設定可能)
-   外部デバイスの同期制御 (デバイス間の遅延オフセットを設定可能)
-   カメラ フレームのメタデータ (画像の解像度やタイムスタンプなど) へのアクセス
-   デバイス較正データへのアクセス

-   デバイスのデータ ストリームを監視したり、さまざまなモードを構成したりするためのビューアー ツール。
-   [[Matroska]] コンテナー形式を使用するセンサー記録ツールと再生リーダー API。
-   Azure Kinect DK ファームウェア更新ツール。

- @2020 [AzureKinect の opencv-kinfu-samples をビルドする - Qiita](https://qiita.com/ousttrue/items/daea793638850965b43f)

# k4abt
-   体のセグメント化を提供します。
-   認識範囲内の体の各部位または全身の解剖学的に正しい骨格を含みます。
-   体ごとに一意の ID を提供します。
-   時間の経過と共に体をトラッキングできます。

[Azure Kinect Body Tracking SDK のダウンロード | Microsoft Docs](https://docs.microsoft.com/ja-jp/azure/kinect-dk/body-sdk-download)

`"C:\Program Files\Azure Kinect Body Tracking SDK\tools\k4abt_simple_3d_viewer.exe"`

- [Azure Kinect Sensor SDK Documentation](https://microsoft.github.io/Azure-Kinect-Body-Tracking/)
- [Azure Kinect のボディ トラッキング結果の取得 | Microsoft Docs](https://docs.microsoft.com/ja-jp/azure/kinect-dk/get-body-tracking-results)
- [ボディ フレームの Azure Kinect DK データへのアクセス | Microsoft Docs](https://docs.microsoft.com/ja-jp/azure/kinect-dk/access-data-body-frame)
	
https://microsoft.github.io/Azure-Kinect-Body-Tracking/release/1.x.x/index.html

https://www.nuget.org/packages/Microsoft.Azure.Kinect.BodyTracking/1.0.1

https://docs.microsoft.com/en-us/azure/kinect-dk/build-first-body-app
https://docs.microsoft.com/en-us/azure/kinect-dk/body-sdk-setup
https://github.com/microsoft/Azure-Kinect-Samples/tree/master/body-tracking-samples

## Unity
- [Azure-Kinect-Samples/README.md at master · microsoft/Azure-Kinect-Samples · GitHub](https://github.com/microsoft/Azure-Kinect-Samples/blob/master/body-tracking-samples/sample_unity_bodytracking/README.md)
```
> nuget.exe restore
> MoveLibraryFiles.bat
```
- @2021 [AzureKinectのBodyTrackingSDKをUnityプロジェクトに導入する方法 | CitronSeason's Blog](https://citronseason.github.io/%E7%A0%94%E7%A9%B6%E3%83%A1%E3%83%A2/unity/2021/10/26/howToImportAzureKinectBodyTrackingSDKtoUnityProject/)
- @2021 [Azure Kinect でピクトグラムになってみた初期設定と手順](https://akihiro-document.azurewebsites.net/post/kinect/pictogram2020withazurekinect/)
```csharp
ProcessingMode = TrackerProcessingMode.Cpu
```
- @2020 [Azure KinectのBodyTracking公式サンプルをUnityで動かしてみる - Qiita](https://qiita.com/drumath2237/items/b92399e71db1074814e3)

### Cuda
### DirectML
### Tensor

# tools
## Viewer
- [Azure Kinect ビューアー | Microsoft Learn](https://learn.microsoft.com/ja-jp/azure/kinect-dk/azure-kinect-viewer#check-device-firmware-version)

# Sample
- [GitHub - UnaNancyOwen/AzureKinectSample: Sample Program for Azure Kinect Sensor SDK and Azure Kinect Body Tracking SDK](https://github.com/UnaNancyOwen/AzureKinectSample)
