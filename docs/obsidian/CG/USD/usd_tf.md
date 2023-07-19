[[usd]]

# TfToken
文字列トークン？。
プラグインの識別など？

# TfType
[Universal Scene Description: TfType Class Reference](https://openusd.org/dev/api/class_tf_type.html)

```cpp
    /// Returns the plug-in for the given type, or a null pointer if there is no
    /// registered plug-in.
    PLUG_API
    PlugPluginPtr GetPluginForType(TfType t) const;
```

```cpp
class HdRendererPlugin : public HfPluginBase {

TfType::Find<HdRendererPlugin>()
```


```
void
TfType::SetFactory(std::unique_ptr<FactoryBase> factory) const
```
