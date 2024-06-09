- https://github.com/ocornut/imgui
- @2021 [Using Dear ImGui with modern C++ and STL for creating awesome game dev tools](https://eliasdaler.github.io/using-imgui-with-sfml-pt2/)
- @2019 [An introduction to the Dear ImGui library](https://blog.conan.io/2019/06/26/An-introduction-to-the-Dear-ImGui-library.html)
- @2018 [ImGui でデバッグツール - 下町のナポレオン](http://hikita12312.hatenablog.com/entry/2018/03/17/100535)
- @2017 [Windows で OpenGLES --- imgui 導入 - 何でもプログラミング](http://any-programming.hatenablog.com/entry/2017/04/26/112929)
- @2017 [c++ - How can I render an OpenGL scene into an ImGui window? - Game Development Stack Exchange](https://gamedev.stackexchange.com/questions/140693/how-can-i-render-an-opengl-scene-into-an-imgui-window)
- @2016 [OpenGL や DirectX な GUI に imgui が最強すぎる - Qiita](https://qiita.com/Ushio/items/446d78c881334919e156)
- @2016 [最強すぎる GUI こと ImGui の見た目もイイ感じにする - Qiita](https://qiita.com/izumin5210/items/26eaed69eea2c4318fcd)

- https://github.com/onurae/core-nodes

# Version

## 1.90.8

## 1.89.1

## 1.87

`input queue trickling`

- [new inputs](https://github.com/ocornut/imgui/wiki#inputs)

### glfw

```cpp
// Pass in translated ASCII characters for text input.
// - with glfw you can get those from the callback set in glfwSetCharCallback()
// - on Windows you can get those using ToAscii+keyboard state, or via the WM_CHAR message
// FIXME: Should in theory be called "AddCharacterEvent()" to be consistent with new API
void ImGuiIO::AddInputCharacter(unsigned int c)
{
    ImGuiContext& g = *GImGui;
    IM_ASSERT(&g.IO == this && "Can only add events to current context.");
    if (c == 0 || !AppAcceptingEvents)
        return;

    ImGuiInputEvent e;
    e.Type = ImGuiInputEventType_Text;
    e.Source = ImGuiInputSource_Keyboard;
    e.Text.Char = c;
    g.InputEventsQueue.push_back(e);
}
```

# Input

## 1.81

## 1.80

table API

## 1.72

## 1.71 20190613

docking https://github.com/ocornut/imgui/issues/2109

# Repos

わいの

- [GitHub - ousttrue/d3d11_samples: D3D11 sample](https://github.com/ousttrue/d3d11_samples)

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

### ImGui が消費する

`io.WantCaptureMouse`

- ImGui の Widgets が消費する
  `window, item のテスト`
- ImGui の RenderTarget に転送する

### ImGui が消費しない

`!io.WantCaptureMouse`

- background の 3D シーンに送る

# App

- https://github.com/mahilab/mahi-gui

# Timeline

- [TimeLine tracker. How reduce his code for ImGui · Issue #1014 · ocornut/imgui · GitHub](https://github.com/ocornut/imgui/issues/1014)
