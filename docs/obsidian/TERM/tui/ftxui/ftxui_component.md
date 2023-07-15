```cpp
#include <ftxui/dom/component.hpp>
```

## Button

## Checkbox/Radiobox

## Slider

## Input

## Menu(Selector)
- entry は `std::string` `std::span<T>` + transform にしたい

## Renderer
描画のみ。OnEvent が無い
```cpp
Component Renderer(std::function<Element()> render) {
  class Impl : public ComponentBase {
   public:
    explicit Impl(std::function<Element()> render)
        : render_(std::move(render)) {}
    Element Render() override { return render_(); }
    std::function<Element()> render_;
  };

  return Make<Impl>(std::move(render));
}
```

```cpp
  auto renderer = Renderer(component, [&] {
    return vbox({
               text("Hello " + first_name + " " + last_name),
               separator(),
               hbox(text(" First name : "), input_first_name->Render()),
               hbox(text(" Last name  : "), input_last_name->Render()),
               hbox(text(" Password   : "), input_password->Render()),
           }) |
           border;
  });
```

## ftxui::ComponentBase
[FTXUI: include/ftxui/component/component_base.hpp Source File](https://arthursonzogni.github.io/FTXUI/component__base_8hpp_source.html)
OnEventでイベントハンドリングできる
```cpp
	    ftxui::Element Render() override;
    bool OnEvent(ftxui::Event) override;
```

# ScreenInteractive
loop で component を Rendering する。
## ScreenInteractive::Fullscreen
- https://arthursonzogni.github.io/FTXUI/examples_2component_2resizable_split_8cpp-example.html

## ScreenInteractive::FitComponent
- button
- composition

## ScreenInteractive::TerminalOutput
- maybe

# Splitter

```cpp
#include "ftxui/component/component.hpp"
#include "ftxui/component/screen_interactive.hpp" // for ScreenInteractive

class Splitter : public ftxui::ComponentBase {

  int m_left_size = 20;

  ftxui::Component m_center =
      ftxui::Renderer([] { return ftxui::text("center") | ftxui::center; });
  ftxui::Component m_left =
      ftxui::Renderer([] { return ftxui::text("left") | ftxui::center; });
  ftxui::Component container =
      ResizableSplitLeft(m_left, m_center, &m_left_size);

public:
  std::function<void()> OnQuit;

  ftxui::Element Render() override { return container->Render(); }
  bool OnEvent(ftxui::Event event) override {
    if (event == ftxui::Event::Character('q')) {
      if (OnQuit) {
        OnQuit();
      }
    }

    if (event == ftxui::Event::ArrowLeft ||
        event == ftxui::Event::Character('h')) {
      m_left_size = std::max(2, m_left_size - 1);
      return true;
    }

    if (event == ftxui::Event::ArrowRight ||
        event == ftxui::Event::Character('l')) {
      m_left_size = std::min(ftxui::Terminal::Size().dimx - 3, m_left_size + 1);
      return true;
    }

    return false;
  }
};

int main() {
  auto component = ftxui::Make<Splitter>();
  auto screen = ftxui::ScreenInteractive::Fullscreen();
  component->OnQuit = screen.ExitLoopClosure();
  screen.Loop(component);
}
```
