- https://github.com/ocornut/imgui
- @2021 [Using Dear ImGui with modern C++ and STL for creating awesome game dev tools](https://eliasdaler.github.io/using-imgui-with-sfml-pt2/)
- @2019 [An introduction to the Dear ImGui library](https://blog.conan.io/2019/06/26/An-introduction-to-the-Dear-ImGui-library.html)
- @2018 [ImGuiでデバッグツール - 下町のナポレオン](http://hikita12312.hatenablog.com/entry/2018/03/17/100535)
- @2017 [WindowsでOpenGLES --- imgui導入 - 何でもプログラミング](http://any-programming.hatenablog.com/entry/2017/04/26/112929)
- @2017 [c++ - How can I render an OpenGL scene into an ImGui window? - Game Development Stack Exchange](https://gamedev.stackexchange.com/questions/140693/how-can-i-render-an-opengl-scene-into-an-imgui-window)
- @2016 [OpenGLやDirectXなGUIにimguiが最強すぎる - Qiita](https://qiita.com/Ushio/items/446d78c881334919e156)
- @2016 [最強すぎるGUIことImGuiの見た目もイイ感じにする - Qiita](https://qiita.com/izumin5210/items/26eaed69eea2c4318fcd)

# Version
## 1.89.1
## 1.81
## 1.80
table API

## 1.72

## 1.71  20190613
docking https://github.com/ocornut/imgui/issues/2109

# API
```c++
// window
if(ImGui::Begin()){
}
ImGui::End(); // begin が true でも end でも呼ばねばならぬ // Window だけ？

// widgets
if(ImGui::TreeNode()){
	ImGui::EndNode(); // true の時だけ呼ばねばならぬ
}
```

## 入力ハンドリング
- ImGui が消費する
	- ImGui の Widgets が消費する
	- ImGui の RenderTarget に転送する
- ImGui が消費しない

# App
- https://github.com/mahilab/mahi-gui
