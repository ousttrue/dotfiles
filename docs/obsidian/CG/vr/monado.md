[Monado - Open Source XR Platform](https://monado.dev/)
- [Monado / Monado · GitLab](https://gitlab.freedesktop.org/monado/monado)

- [Installation for Linux | OpenXR](https://dochavez.github.io/Documenting-with-Docusaurus-V2.-/docs/monado)
- [Monado - Getting Started](https://monado.freedesktop.org/getting-started.html)
- [Monado / Demos / openxr-simple-example · GitLab](https://gitlab.freedesktop.org/monado/demos/openxr-simple-example)

depends
* glslang
* eigen
* openhmd
	* HIDAPI

cmake -DCMAKE_BUILD_TYPE=Release

> Nvidia + DirectMode + Vulkan + Rift-S を動作させることができたのだが、
> レンダリング結果の右目と左目がずれていた。
> トラッキングは方向だけ動いていたぽい？

# RuntimeDetection
[Monado - Getting Started](https://monado.freedesktop.org/getting-started.html#selecting-the-monado-runtime-for-openxr-applications)

`/usr/share/openxr/1/openxr_monado.json`

`XRT_FEATURE_OPENXR` に依存。
`XRT_FEATURE_COMPOSITOR_MAIN`

## system
```
sudo mkdir -p /etc/xdg/openxr/1/
sudo ln -s /usr/share/openxr/1/openxr_monado.json /etc/xdg/openxr/1/active_runtime.json
```

## user local
```
mkdir -p ~/.config/openxr/1
ln -s /usr/share/openxr/1/openxr_monado.json ~/.config/openxr/1/active_runtime.json
```

## environment variable
```
XR_RUNTIME_JSON=/usr/share/openxr/1/openxr_monado.json
```

## 動かーん
[[VK_KHR_display]]
[Hello! Any advice for getting Oculus CV1 to work? (#136) · Issues · Monado / Monado · GitLab](https://gitlab.freedesktop.org/monado/monado/-/issues/136)

# HandTracking
- [Collabora announce 'Mercury' hand-tracking for open source XR runtime Monado | GamingOnLinux](https://www.gamingonlinux.com/2023/02/collabora-mercury-hand-tracking-open-source-xr-runtime-monado/)
