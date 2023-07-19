[[hdStorm]]

- [Hydraとは - Cacher Snippet](https://snippets.cacher.io/snippet/cb15c5a82078da9f9470)
シーンを入力(HdSceneDelegate)し、レンダリング(HdRenderDelegate)する。

# HdSceneDelegate
## UsdImagingDelegate

# HdRenderDelegate
## HdStorm
- HdStRenderDelegate

# HdRenderIndex

- [GitHub - dboogert/USD-tests: USD & Hydra - examples & tutorials](https://github.com/dboogert/USD-tests)o

# UsdImagingGLEngine
OpenGL レンダラーを host する interface ?

- [C++でUSDのViewportを作ろう(2) メイン部分を作る | Reincarnation+#Tech](https://fereria.github.io/reincarnation_tech/usd/cpp/viewport_02)

- [GitHub - cpichard/usdtweak: Universal Scene Description standalone editor](https://github.com/cpichard/usdtweak)

はこれを使っている。

- UsdImaging
- Imaging(Hydra)

`TfToken& rendererPluginId` でレンダラーをスイッチする。
`HD_DEFAULT_RENDERER`

HdRendererPluginRegistry.GetDefaultPluginId

```cpp
// id==null で入ってくる
bool UsdImagingGLEngine::SetRendererPlugin(TfToken const &id)

TfToken HdRendererPluginRegistry::GetDefaultPluginId(bool gpuEnabled);
```

# HfPluginRegistory

discover
```cpp
void
HfPluginRegistry::_DiscoverPlugins()
{

TfType::Find<HdRendererPlugin>()
```

```cpp
TfToken 
HdRendererPluginRegistry::GetDefaultPluginId(bool gpuEnabled)
{
    // Get all the available plugins to see if any of them is supported on this
    // platform and use the first one as the default.
    // 
    // Important note, we want to avoid loading plugins as much as possible, 
    // we would prefer to only load plugins when the user asks for them.  So
    // we will only load plugins until we find the first one that works.
    HfPluginDescVector pluginDescriptors;
    GetPluginDescs(&pluginDescriptors); // 👉discover
```

```
```
```cpp
// シングルトンの初期化
    HdRendererPluginRegistry::GetInstance().AddPluginReference(this);

void
HfPluginRegistry::AddPluginReference(HfPluginBase *plugin)

// hdStorm を登録
```

## 登録
型で登録して
```cpp
    HdRendererPluginRegistry::Define<HdTinyRendererPlugin>();
```

## 取得
文字列で取得する
```cpp
    // Get the renderer plugin and create a new render delegate and index.
    const TfToken tinyRendererPluginId("HdTinyRendererPlugin");

    HdRendererPlugin *rendererPlugin = HdRendererPluginRegistry::GetInstance()
        .GetRendererPlugin(tinyRendererPluginId);
    TF_VERIFY(rendererPlugin != nullptr);
```
