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

# Element
## vbox

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
