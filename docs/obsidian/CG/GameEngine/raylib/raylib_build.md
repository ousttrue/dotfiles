```sh
cmake -G Ninja -S . -B build -DBUILD_EXAMPLES=ON
```

# cmake

- [GitHub - raysan5/raylib-game-template: A small template to start your raylib game](https://github.com/raysan5/raylib-game-template)

# meson

- https://gitea.com/simdax/raylib

少し修正が必要。動いた。

```diff
index 65b85cd..6a48539 100644
--- a/subprojects/modules/scene.h
+++ b/subprojects/modules/scene.h
@@ -6,7 +6,7 @@
 struct SceneInterface {
     virtual void UpdateScene() = 0;

-    template <class... Ts, class C, size_t... Is>
+    template <class... Ts, class C>
     constexpr void Do(std::tuple<Ts...>& tuple, C&& Callback)
     {
         std::apply([&](Ts&... vals) {
diff --git a/subprojects/modules/watch/meson.build b/subprojects/modules/watch/meson.build
index 7e0d0cb..3424d5e 100644
--- a/subprojects/modules/watch/meson.build
+++ b/subprojects/modules/watch/meson.build
@@ -1,6 +1,6 @@
 project('watch', 'cpp', version
 : '0.1', default_options
-: [ 'warning_level=3', 'cpp_std=c++17' ])
+: [ 'warning_level=3', 'cpp_std=c++latest' ])

 watch_lib = library('watch_lib', ['lib.cpp'])
 watch_dep = declare_dependency (
```
