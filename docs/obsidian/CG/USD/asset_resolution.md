[[usd]]
[[usd_plug]]

`ar`
[Universal Scene Description: Ar: Asset Resolution](https://openusd.org/dev/api/ar_page_front.html)

https://wiki.aswf.io/display/WGUSD/USD+Projects+and+Resources#USDProjectsandResources-AssetResolvers

- [Asset Resolution | Multiverse](https://j-cube.jp/solutions/multiverse/docs/setup/asset-resolver.html)


# resolver
- [GitHub - LumaPictures/usd-uri-resolver: Pluggable URI ArResolver for USD](https://github.com/LumaPictures/usd-uri-resolver)

_uriResolvers

# plugin load

## get

```cpp
auto stage = pxr::UsdStage::CreateInMemory();

CreateInMemory("tmp.usda", load);

SdfFileFormat::FindByExtension("usda");

return ArGetResolver().GetExtension(assetPath);
```

## register

```cpp
ArGetResolver()

void
PlugRegistry::GetAllDerivedTypes(TfType base, std::set<TfType> *result)
{
    PlugPlugin::_RegisterAllPlugins();
    base.GetAllDerivedTypes(result);
}
```

