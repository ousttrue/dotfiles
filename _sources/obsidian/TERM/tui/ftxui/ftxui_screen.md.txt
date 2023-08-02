```cpp
#include <ftxui/screen/screen.hpp>
#include <iostream>
 
int main(void) {
  using namespace ftxui;
  auto screen = Screen::Create(
	  Dimension::Fixed(32), 
	  Dimension::Fixed(10));
 
  auto& pixel = screen.PixelAt(9,9);
  pixel.character = U'A';
  pixel.bold = true;
  pixel.foreground_color = Color::Blue;
 
  std::cout << screen.ToString();
  return EXIT_SUCCESS;
}
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
