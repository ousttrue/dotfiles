# Component
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
