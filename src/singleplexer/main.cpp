#include "child_process.h"
#include "vt_component.h"
#include <vterm.h>

#include "ftxui/component/screen_interactive.hpp" // for ScreenInteractive

#include <assert.h>
#include <chrono>
#include <iostream>
#include <memory>
#include <process.h>
#include <thread>

#include <windows.h>

std::string Stringify(ftxui::Event event) {
  std::string out;
  for (auto &it : event.input())
    out += " " + std::to_string((unsigned int)it);

  out = "(" + out + " ) -> ";
  if (event.is_character()) {
    out += "Event::Character(\"" + event.character() + "\")";
  } else if (event.is_mouse()) {
    out += "mouse";
    switch (event.mouse().button) {
    case ftxui::Mouse::Left:
      out += "_left";
      break;
    case ftxui::Mouse::Middle:
      out += "_middle";
      break;
    case ftxui::Mouse::Right:
      out += "_right";
      break;
    case ftxui::Mouse::None:
      out += "_none";
      break;
    case ftxui::Mouse::WheelUp:
      out += "_wheel_up";
      break;
    case ftxui::Mouse::WheelDown:
      out += "_wheel_down";
      break;
    }
    switch (event.mouse().motion) {
    case ftxui::Mouse::Pressed:
      out += "_pressed";
      break;
    case ftxui::Mouse::Released:
      out += "_released";
      break;
    }
    if (event.mouse().control)
      out += "_control";
    if (event.mouse().shift)
      out += "_shift";
    if (event.mouse().meta)
      out += "_meta";

    out += "(" + //
           std::to_string(event.mouse().x) + "," +
           std::to_string(event.mouse().y) + ")";
  } else if (event == ftxui::Event::ArrowLeft) {
    out += "Event::ArrowLeft";
  } else if (event == ftxui::Event::ArrowRight) {
    out += "Event::ArrowRight";
  } else if (event == ftxui::Event::ArrowUp) {
    out += "Event::ArrowUp";
  } else if (event == ftxui::Event::ArrowDown) {
    out += "Event::ArrowDown";
  } else if (event == ftxui::Event::ArrowLeftCtrl) {
    out += "Event::ArrowLeftCtrl";
  } else if (event == ftxui::Event ::ArrowRightCtrl) {
    out += "Event::ArrowRightCtrl";
  } else if (event == ftxui::Event::ArrowUpCtrl) {
    out += "Event::ArrowUpCtrl";
  } else if (event == ftxui::Event::ArrowDownCtrl) {
    out += "Event::ArrowDownCtrl";
  } else if (event == ftxui::Event::Backspace) {
    out += "Event::Backspace";
  } else if (event == ftxui::Event::Delete) {
    out += "Event::Delete";
  } else if (event == ftxui::Event::Escape) {
    out += "Event::Escape";
  } else if (event == ftxui::Event::Return) {
    out += "Event::Return";
  } else if (event == ftxui::Event::Tab) {
    out += "Event::Tab";
  } else if (event == ftxui::Event::TabReverse) {
    out += "Event::TabReverse";
  } else if (event == ftxui::Event::F1) {
    out += "Event::F1";
  } else if (event == ftxui::Event::F2) {
    out += "Event::F2";
  } else if (event == ftxui::Event::F3) {
    out += "Event::F3";
  } else if (event == ftxui::Event::F4) {
    out += "Event::F4";
  } else if (event == ftxui::Event::F5) {
    out += "Event::F5";
  } else if (event == ftxui::Event::F6) {
    out += "Event::F6";
  } else if (event == ftxui::Event::F7) {
    out += "Event::F7";
  } else if (event == ftxui::Event::F8) {
    out += "Event::F8";
  } else if (event == ftxui::Event::F9) {
    out += "Event::F9";
  } else if (event == ftxui::Event::F10) {
    out += "Event::F10";
  } else if (event == ftxui::Event::F11) {
    out += "Event::F11";
  } else if (event == ftxui::Event::F12) {
    out += "Event::F12";
  } else if (event == ftxui::Event::Home) {
    out += "Event::Home";
  } else if (event == ftxui::Event::End) {
    out += "Event::End";
  } else if (event == ftxui::Event::PageUp) {
    out += "Event::PageUp";
  } else if (event == ftxui::Event::PageDown) {
    out += "Event::PageDown";
  } else if (event == ftxui::Event::Custom) {
    out += "Custom";
  } else {
    out += "(special)";
  }
  return out;
}

struct Logger : ftxui::ComponentBase {

  std::shared_ptr<VtComponent> m_vt;
  ftxui::Element m_box;

  ftxui::Elements children;
  Logger(const std::shared_ptr<VtComponent> &vt) : m_vt(vt) {
    m_box = vbox(std::move(children));
  }

  ftxui::Box box_;

  ftxui::Element Render() override {
    m_box->SetBox(box_);

    auto &keys = m_vt->m_events;
    auto it = keys.begin();
    auto h = box_.y_max - box_.y_min + 1;
    std::stringstream ss;
    ss << "h:" << h;
    for (int i = 0; i < std::max(0, (int)keys.size() - h); ++i) {
      ++it;
    }

    children.clear();
    // children.push_back(ftxui::text(ss.str()));
    for (; it != keys.end(); ++it) {
      children.push_back(ftxui::text(Stringify(*it)));
    }

    return m_box | reflect(box_);
  }
};

class Grid : public ftxui::ComponentBase {
  std::shared_ptr<VtComponent> m_lt;
  ftxui::Component m_rt;
  std::shared_ptr<Logger> m_lb;
  ftxui::Element m_rb;

public:
  Grid(const std::shared_ptr<VtNode> &node) {
    m_lt = std::make_shared<VtComponent>(node);
    m_rt = ftxui::Renderer(
        [node] { return ftxui::text(node->m_renderer->Status()); });
    m_lb = std::make_shared<Logger>(m_lt);
    m_lt->TakeFocus();

    Add(m_lt);
  }

  ftxui::Element Render() override {
    return ftxui::gridbox({
        {m_lt->Render() | ftxui::border, m_rt->Render() | ftxui::border},
        {m_lb->Render() | ftxui::border, ftxui::text("rb") | ftxui::border},
    });
  }
};

std::shared_ptr<VtNode> CreateNode(ftxui::ScreenInteractive &screen,
                                   const ftxui::Dimensions &dim) {
  auto renderer = std::make_shared<VtRenderer>();
  renderer->m_cmd = "cmd.exe";
  renderer->m_onDamaged = [&screen]() {
    screen.PostEvent(ftxui::Event::Custom);
  };
  renderer->m_onExit = [&screen]() {
    // screen.ExitLoopClosure();
    screen.Exit();
  };
  std::shared_ptr<VtNode> node = std::make_shared<VtNode>(dim);
  node->m_renderer = renderer;
  return node;
}

///  0.5   0.5
/// +-----+------+
/// | vt  |debug | *
/// +-----+------+
/// |input|screen| 12
/// +-----+------+
///
int main() {
  auto screen = ftxui::ScreenInteractive::Fullscreen();

  auto dims = ftxui::Terminal::Size();
  auto node = CreateNode(screen, {dims.dimx / 2, dims.dimy});

  ftxui::Component grid = std::make_shared<Grid>(node);

  // vt
  // TODO: table
  // process:state
  // screen:size
  // cursor:pos

  screen.Loop(grid);
}
