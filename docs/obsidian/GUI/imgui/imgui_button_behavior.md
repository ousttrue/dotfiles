```cpp

    //
    // render to renderTarget
    //
    if (ImGui::Begin("debug")) {
      auto pos = ImGui::GetCursorScreenPos();
      auto size = ImGui::GetContentRegionAvail();

      if (auto texture = begin_fbo(size.x, size.y, debugCamera.ClearColor)) {
        ImGui::ImageButton((void *)(int64_t)texture, size, {0, 1}, {1, 0}, 0,
                           {1, 1, 1, 1}, {1, 1, 1, 1});
        ImGui::ButtonBehavior(ImGui::GetCurrentContext()->LastItemData.Rect,
                              ImGui::GetCurrentContext()->LastItemData.ID,
                              nullptr, nullptr,
                              ImGuiButtonFlags_MouseButtonMiddle |
                                  ImGuiButtonFlags_MouseButtonRight);

        auto focus = rectray::ViewportFocus::None;
        if (ImGui::IsItemActive()) {
          focus = rectray::ViewportFocus::Active;
        } else if (ImGui::IsItemHovered()) {
          focus = rectray::ViewportFocus::Hover;
        }

        rectray::ViewportState viewport{
            .Focus = focus,
            .ViewportX = pos.x,
            .ViewportY = pos.y,
            .ViewportWidth = size.x,
            .ViewportHeight = size.y,
            .MouseX = io.MousePos.x - pos.x,
            .MouseY = io.MousePos.y - pos.y,
            .MouseDeltaX = io.MouseDelta.x,
            .MouseDeltaY = io.MouseDelta.y,
            .MouseLeftDown = io.MouseDown[0],
            .MouseRightDown = io.MouseDown[1],
            .MouseMiddleDown = io.MouseDown[2],
            .MouseWheel = io.MouseWheel,
        };

        debugCamera.Render(viewport, ImGui::GetWindowDrawList(), &scene,
                           &mainCamera.Gui);

        end_fbo();
      }
    }
    ImGui::End();
```
