[[glibmm]]

- [Features - gtkmm - C++ Interfaces for GTK and GNOME](https://www.gtkmm.org/en/index.html)
- [The GTK Project - A free and open-source cross-platform widget toolkit](https://www.gtk.org/docs/language-bindings/cpp)

# GTKMM4
`c++17`
- [Programming with gtkmm 4](https://developer-old.gnome.org/gtkmm-tutorial/unstable/gtkmm-tutorial.html)

- @2022 [How to install GTKMM 4 on Ubuntu 22.04](https://terminalroot.com/how-to-install-gtkmm-4-on-ubuntu-2204/)

# 3
- [GTK+3.0 のC++ 言語版 入門。gtkmmをつかった画面遷移などのサンプル](https://jitaku.work/it/category/gui/gtkmm/)
- [gtkmm 3 入門](http://shopping2.gmobb.jp/htdmnr/www08/cpp/gtkmm01.html)
- [GitHub - gammasoft71/Examples_Gtkmm: Shows how to use Gtkmm controls by programming code (c++17).](https://github.com/gammasoft71/Examples_Gtkmm)
- [GitHub - zrax/gsshvnc: A simple VNC client with built-in SSH tunneling](https://github.com/zrax/gsshvnc)
- [GitHub - synfig/synfig: This is the Official source code repository of the Synfig project](https://github.com/synfig/synfig)


# Hello
```cpp
#include <gtkmm/application.h>
#include <gtkmm/button.h>
#include <gtkmm/window.h>
#include <iostream>

class HelloWorld : public Gtk::Window {

public:
  HelloWorld()

      : m_button(
            "Hello World") // creates a new button with label "Hello World".
  {
    // Sets the margin around the button.
    m_button.set_margin(10);

    // When the button receives the "clicked" signal, it will call the
    // on_button_clicked() method defined below.
    m_button.signal_clicked().connect(
        sigc::mem_fun(*this, &HelloWorld::on_button_clicked));

    // This packs the button into the Window (a container).
    set_child(m_button);
  }
  ~HelloWorld() override {}

protected:
  // Signal handlers:
  void on_button_clicked() { std::cout << "Hello World" << std::endl; }

  // Member widgets:
  Gtk::Button m_button;
};

int main(int argc, char *argv[]) {
  auto app = Gtk::Application::create("org.gtkmm.example");

  // Shows the window and returns when it is closed.
  return app->make_window_and_run<HelloWorld>(argc, argv);
}
```

# Application
- [Synfig – Free and open-source animation software](https://www.synfig.org/)

# Build
