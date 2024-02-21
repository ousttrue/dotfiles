```cpp
#include <ftxui/dom/elements.hpp>

void Print(const ftxui::Elment &document)
{
	auto screen = ftxui::Screen::Create(
		// Width
		ftxui::Dimension::Full(),       
		// Height
		ftxui::Dimension::Fit(document) 
	);
	
	ftxui::Render(screen, document);
	screen.Print();
}
```

# ftxui::Node

## Text

```cpp
class Text : public Node {
 public:
  explicit Text(std::string text) : text_(std::move(text)) {}

  void ComputeRequirement() override {
    requirement_.min_x = string_width(text_);
    requirement_.min_y = 1;
  }

  void Render(Screen& screen) override {
    int x = box_.x_min;
    const int y = box_.y_min;
    if (y > box_.y_max) {
      return;
    }
    for (const auto& cell : Utf8ToGlyphs(text_)) {
      if (x > box_.x_max) {
        return;
      }
      if (cell == "\n") {
        continue;
      }
      screen.PixelAt(x, y).character = cell;
      ++x;
    }
  }

 private:
  std::string text_;
};
```

# ftxui::Render

`Element => Screen`
`Node::Render(Screen)`

# ftxui::Element

```cpp
using Element = std::shared_ptr<Node>;
using Elements = std::vector<Element>;
```

## hbox / vbox

```cpp
// Define the document
document = vbox({
  text("The window") | bold | color(Color::Blue),
  gauge(0.5)
  text("The footer")
});
```

## border
```cpp
// Add a border, by calling the `ftxui::border` decorator function.
document = border(document);
 
// Add another border, using the pipe operator.
document = document | border.
 
// Add another border, using the |= operator.
document |= border
```

# Render to Screen
`one time`
```cpp
auto screen = screen::create(
	// width
	dimension::full(),
	// height
	dimension::fit(document)
);
ftxui::Render(screen, document);
```

## ToString
- https://arthursonzogni.github.io/FTXUI/#module-screen
```cpp
screen.ToString();
```

## Print
- [FTXUI: Main Page](https://arthursonzogni.github.io/FTXUI/)
```cpp
screen.Print();
```

# Renderer
=> [[ftxui_component]]
## Loop
```cpp
screen.Loop(ftxui::Renderer([&] { return document; }));
```
