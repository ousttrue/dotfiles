[[FTXUI]]

Component のツリーはイベントを伝搬する。
`Renderer` の第１引数に `子Component` を指定できる。

# hello

[[ftxui_screen]]

## Renderer

描画のみ。OnEvent が無い

```cpp
#include <ftxui/component/component.hpp>
#include <ftxui/component/screen_interactive.hpp>

int main() {

  auto screen = ftxui::ScreenInteractive::Fullscreen();

  auto component = ftxui::Renderer([]() { return ftxui::text("hello"); });

  auto event_component = CatchEvent(component, [&](ftxui::Event event) {
    if (event == ftxui::Event::Character('q') ||
        event == ftxui::Event::Escape) {
      screen.ExitLoopClosure()();
      return true;
    }

    return false;
  });

  screen.Loop(event_component);

  return 0;
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

# widgets

## Button

## Checkbox/Radiobox

## Slider

## Input

## ftxui::ComponentBase

[FTXUI: include/ftxui/component/component_base.hpp Source File](https://arthursonzogni.github.io/FTXUI/component__base_8hpp_source.html)
OnEvent でイベントハンドリングできる

```cpp
	    ftxui::Element Render() override;
    bool OnEvent(ftxui::Event) override;
```

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

# ContainerBase: ComponentBase

navigation(select 制御)がある

## Container

```c++
  auto composition = Container::Horizontal({leftpane, rightpane});
```

## container item

```c++
ftxui::Component Custom(const std::string &label) {
  return ftxui::Renderer([label](bool focused) {
    auto e = ftxui::text(label);
    if (focused) {
      e = e | ftxui::inverted;
    }
    return e;
  });
}
```

## Menu(Selector)

- entry は `std::string` `std::span<T>` + transform にしたい

## collabsible

[FTXUI: examples/component/collapsible.cpp](https://arthursonzogni.github.io/FTXUI/examples_2component_2collapsible_8cpp-example.html)

# ScreenInteractive

loop で component を Rendering する。

## ScreenInteractive::Loop

```cpp
void ScreenInteractive::Loop(Component component) {  // NOLINT
  class Loop loop(this, std::move(component));
  loop.Run();
}
```

## ScreenInteractive::Fullscreen

- https://arthursonzogni.github.io/FTXUI/examples_2component_2resizable_split_8cpp-example.html

## ScreenInteractive::FitComponent

- button
- composition

## ScreenInteractive::TerminalOutput

- maybe
