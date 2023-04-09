[[OpenXR]]

[Chapter 7. Spaces](https://registry.khronos.org/OpenXR/specs/1.0/html/xrspec.html#spaces)

# 7.1 Reference Spaces
- [XrSpace](https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#spaces)
- `xrCreateReferenceSpace`
```c
typedef enum XrReferenceSpaceType {
  XR_REFERENCE_SPACE_TYPE_VIEW = 1,
  XR_REFERENCE_SPACE_TYPE_LOCAL = 2,
  XR_REFERENCE_SPACE_TYPE_STAGE = 3,
  // Provided by XR_MSFT_unbounded_reference_space
  XR_REFERENCE_SPACE_TYPE_UNBOUNDED_MSFT = 1000038000,
  // Provided by XR_VARJO_foveated_rendering
  XR_REFERENCE_SPACE_TYPE_COMBINED_EYE_VARJO = 1000121000,
  XR_REFERENCE_SPACE_TYPE_MAX_ENUM = 0x7FFFFFFF
} XrReferenceSpaceType;
```

- `xrLocateSpace`

## View
- HUD
- xrLocateViews

## Local
`XR_REFERENCE_SPACE_TYPE_LOCAL`
`XrEventDataReferenceSpaceChangePending`

- 初期位置を原点
- `seated-scale`
- 床はわからない
`XR_REFERENCE_SPACE_TYPE_UNBOUNDED_MSFT`
`XR_REFERENCE_SPACE_TYPE_LOCAL`

## Stage
`XR_REFERENCE_SPACE_TYPE_STAGE`
`XrEventDataReferenceSpaceChangePending`

ユーザーが定義した床の高さの四角形の空間。
- [xrGetReferenceSpaceBoundsRect](https://registry.khronos.org/OpenXR/specs/1.0/html/xrspec.html#xrGetReferenceSpaceBoundsRect)
- **standing-scale** content (no bounds) 
- **room-scale** content (with bounds)

## AppSpace (Stage か Local)

## tracking state
- XR_SPACE_LOCATION_POSITION_VALID_BIT
- XR_VIEW_STATE_POSITION_VALID_BIT
- XR_SPACE_LOCATION_POSITION_TRACKED_BIT
- XR_VIEW_STATE_POSITION_TRACKED_BIT 
if TRACKED_BIT == 0 tracking is lost. use inferred last position.

## recenter
- [OpenXR cookbook - Mixed Reality | Microsoft Learn](https://learn.microsoft.com/en-us/windows/mixed-reality/develop/native/openxr-cookbook)

# 7.2 ActionSpace
controller?
- `xrCreateActionSpace`

# Quest SDK
## SpatialAnchors
- `v35` [空間アンカーを使うには](https://framesynthesis.jp/tech/unity/oculusquest/#%E7%A9%BA%E9%96%93%E3%82%A2%E3%83%B3%E3%82%AB%E3%83%BC%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AB%E3%81%AF)
- [Spatial Anchors Overview](https://developer.oculus.com/documentation/native/android/openxr-lsa-overview/)
- xrSamples/XrSpatialAnchor
-   XR_FB_spatial_entity
-   XR_FB_spatial_entity_storage
-   XR_FB_spatial_entity_query
-   XR_FB_spatial_entity_container

## Scene
- @2022 `v40`[【Meta Quest 2】最新アプデでMRセットアップ機能が実装 新しいコンテンツが増える？ - MoguLive](https://www.moguravr.com/meta-quest-2-9/)

- xrSample/XrSceneModel
- [OpenXR Scene Overview](https://developer.oculus.com/documentation/native/android/openxr-scene-overview/)
- [XR_FB_scene](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_scene&e=AT3BlXnZRaCRe3CYW1HdeKPUir-iED7cVDTAHr6XyLkO37MChTgxY1YrEI7GFnRp17TK4YdZtwvxQm8P4u9abNA9LZPRsf8jKfnIgHGZb1RYPTl0aOvKq-7awsGtsHnUClFcQTbONNOj1wlX721aYOppizfRCy3s0sIO8Q).

## PassThrough
- [パススルー機能を使うには](https://framesynthesis.jp/tech/unity/oculusquest/#%E3%83%91%E3%82%B9%E3%82%B9%E3%83%AB%E3%83%BC%E6%A9%9F%E8%83%BD%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AB%E3%81%AF)
- xrSamples/XrPassthrough
- [XR_FB_passthrough](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_passthrough&e=AT2UPomIZ9jR7kOdzmMWnGa_G0B-j_Wc6QXVBwNoPRG85qJJ1YKV9kYP1IXaRsRfJgGbEWLpqdVusNU7_-X9tTCbSLGeFpBYwTm1MLD8qCV2xvIrqDNqqBEyoJaMqtPRZSjAxsITjSnDCmk5wA6i9IWoJmPSievmJrOYqw) 
- [XR_FB_triangle_mesh](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_triangle_mesh&e=AT2UPomIZ9jR7kOdzmMWnGa_G0B-j_Wc6QXVBwNoPRG85qJJ1YKV9kYP1IXaRsRfJgGbEWLpqdVusNU7_-X9tTCbSLGeFpBYwTm1MLD8qCV2xvIrqDNqqBEyoJaMqtPRZSjAxsITjSnDCmk5wA6i9IWoJmPSievmJrOYqw).



- [Meta Quest の Mixed Reality 機能 | Knowledge Swimmer メモ](https://knowledge-swimmer.com/meta-quest-mr-scene)

- [Immersed](https://www.oculus.com/experiences/quest/2849273531812512/?locale=ja_JP)
