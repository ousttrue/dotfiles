- [GitHub - ArthurSonzogni/FTXUI: C++ Functional Terminal User Interface.](https://github.com/ArthurSonzogni/FTXUI)
- @2022 [Create Graphical Programs in Terminal with FTXUI](https://terminalroot.com/create-graphical-programs-in-terminal-with-ftxui/?utm_source=dlvr.it&utm_medium=twitter)

- [GitHub - ArthurSonzogni/ftxui-starter: A starter project using the FTXUI library](https://github.com/ArthurSonzogni/ftxui-starter)

# Version
## 4.0
`c++17`
- [FTXUI: Main Page](https://arthursonzogni.github.io/FTXUI/#build-cmake)

# Element(dom)
- layout widget

```cpp
screen.Loop(ftxui::Renderer([&] { return document; }));
```

## ToStr / Printt
### ToString
- https://arthursonzogni.github.io/FTXUI/#module-screen

### Print
- [FTXUI: Main Page](https://arthursonzogni.github.io/FTXUI/)

# Component
インタラクション
## Button
## Checkbox/Radiobox
## Slider
## Input
## Menu(Selector)

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

# App
- [GitHub - ArthurSonzogni/json-tui: A JSON terminal UI made in C++](https://github.com/ArthurSonzogni/json-tui)
- [GitHub - ArthurSonzogni/git-tui: Collection of human friendly terminal interface for git.](https://github.com/ArthurSonzogni/git-tui)
- [GitHub - ArthurSonzogni/rgb-tui: Create and get colors code from the terminal using a nice interface.](https://github.com/ArthurSonzogni/rgb-tui)

## filer
- [GitHub - GiuseppeCesarano/just-fast: ⚡ Just Fast is CLI file manager with focus on speed in both execution time and usage.](https://github.com/GiuseppeCesarano/just-fast)
	- 同じ
	- https://github.com/plaam/FileManager-CLI

## browser
- https://github.com/robinlinden/hastur

## text
- [GitHub - YottaYocta/TermME: A markdown note-taking program for the terminal](https://github.com/YottaYocta/TermME)
## callendar
Windowsでも動きそう
- [GitHub - NikolaDucak/clog: A small TUI journaling tool. 📖](https://github.com/NikolaDucak/clog)
	- [GitHub - DusanNikolov-TomTom/clog: A small TUI journaling tool. 📖](https://github.com/DusanNikolov-TomTom/clog)

## top
- [GitHub - adsozuan/riptop](https://github.com/adsozuan/riptop)
- [GitHub - IvarWithoutBones/tuitop: A work-in-progresss TUI task manager for Linux](https://github.com/IvarWithoutBones/tuitop)

## game
- [GitHub - cpp-best-practices/travels: This is an awesome submission to the C++ Best Practices Game Jam](https://github.com/cpp-best-practices/travels)

## player
- [GitHub - v1nns/spectrum at eea444e102fb4bc96cb2c440b061f8199b446c6a](https://github.com/v1nns/spectrum/tree/eea444e102fb4bc96cb2c440b061f8199b446c6a)

## json
- [GitHub - ArthurSonzogni/json-tui: A JSON terminal UI made in C++](https://github.com/ArthurSonzogni/json-tui)
