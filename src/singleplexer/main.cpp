#include "child_process.h"
#include <vterm.h>

#include "ftxui/component/screen_interactive.hpp" // for ScreenInteractive
#include <ftxui/component/component.hpp>

#include <assert.h>
#include <chrono>
#include <iostream>
#include <memory>
#include <process.h>
#include <thread>

#include <windows.h>

struct Utf8 {
  char8_t b0 = 0;
  char8_t b1 = 0;
  char8_t b2 = 0;
  char8_t b3 = 0;

  const char8_t *begin() const { return &b0; }

  const char8_t *end() const {
    if (b0 == 0) {
      return &b0;
    } else if (b1 == 0) {
      return &b1;
    } else if (b2 == 0) {
      return &b2;
    } else if (b3 == 0) {
      return &b3;
    } else {
      return (&b3) + 1;
    }
  }

  std::u8string_view view() const { return {begin(), end()}; }
};

inline Utf8 to_utf8(char32_t cp) {
  if (cp < 0x80) {
    return {
        (char8_t)cp,
    };
  } else if (cp < 0x800) {
    return {(char8_t)(cp >> 6 | 0x1C0), (char8_t)((cp & 0x3F) | 0x80)};
  } else if (cp < 0x10000) {
    return {
        (char8_t)(cp >> 12 | 0xE0),
        (char8_t)((cp >> 6 & 0x3F) | 0x80),
        (char8_t)((cp & 0x3F) | 0x80),
    };
  } else if (cp < 0x110000) {
    return {
        (char8_t)(cp >> 18 | 0xF0),
        (char8_t)((cp >> 12 & 0x3F) | 0x80),
        (char8_t)((cp >> 6 & 0x3F) | 0x80),
        (char8_t)((cp & 0x3F) | 0x80),
    };
  } else {
    return {0xEF, 0xBF, 0xBD};
  }
}

struct VtContent {
  VTerm *m_vt;
  VTermScreen *m_screen;
  VTermScreenCell m_cell;
  VTermPos m_cursor = {0, 0};
  int m_cursorShape = 0;
  std::shared_ptr<Pty> m_pty;
  std::shared_ptr<ChildProcess> m_child;
  std::thread m_pipeReader;
  std::thread m_processWatcher;
  std::function<void()> m_onDamaged;
  std::function<void()> m_onExit;
  const VTermScreenCallbacks m_callbacks = {
      .damage = screen_damage,
      .moverect = screen_moverect,
      .movecursor = screen_movecursor,
      .settermprop = screen_settermprop,
      .bell = screen_bell,
      .resize = screen_resize,
      .sb_pushline = screen_sb_pushline,
      .sb_popline = screen_sb_popline,
      .sb_clear = screen_sb_clear,
  };
  static int screen_damage(VTermRect rect, void *user) {
    if (auto self = (VtContent *)user) {
      if (self->m_onDamaged) {
        self->m_onDamaged();
      }
    }
    return 0;
  }
  static int screen_moverect(VTermRect dest, VTermRect src, void *user) {
    return 0;
  }
  static int screen_movecursor(VTermPos pos, VTermPos oldpos, int visible,
                               void *user) {
    if (auto self = (VtContent *)user) {
      self->m_cursor = pos;
    }
    return 0;
  }
  static int screen_settermprop(VTermProp prop, VTermValue *val, void *user) {
    if (auto self = (VtContent *)user) {
      if (prop == VTERM_PROP_CURSORSHAPE) {
        self->m_cursorShape = val->number;
      }
    }
    return 0;
  }
  static int screen_bell(void *user) { return 0; }
  static int screen_resize(int rows, int cols, void *user) { return 0; }
  static int screen_sb_pushline(int cols, const VTermScreenCell *cells,
                                void *user) {
    return 0;
  }
  static int screen_sb_popline(int cols, VTermScreenCell *cells, void *user) {
    return 0;
  }
  static int screen_sb_clear(void *user) { return 0; }

  VtContent(int rows, int cols, const std::string &cmd)
      : m_vt(vterm_new(rows, cols)) {
    // child process
    m_pty = std::make_shared<Pty>(COORD{
        .X = (SHORT)cols,
        .Y = (SHORT)rows,
    });
    auto callback = [=](const char *buf, uint32_t size) {
      vterm_input_write(m_vt, buf, size);
    };
    m_pipeReader =
        std::thread([pipe = m_pty->ReadPipe, callback, self = this]() {
          PipeReader(pipe, callback);
          // onexit
          if (self->m_onExit) {
            self->m_onExit();
          }
        });

    m_child = ChildProcess::Launch(*m_pty, cmd);

    m_processWatcher = std::thread([=]() {
      m_child->Wait();
      m_pty->Close();
    });

    // vterm
    m_vt = vterm_new(rows, cols);
    vterm_set_utf8(m_vt, true);
    m_screen = vterm_obtain_screen(m_vt);
    vterm_screen_reset(m_screen, true);

    vterm_output_set_callback(m_vt, ChildProcess::Write,
                              (void *)m_pty->WritePipe);
    vterm_screen_set_callbacks(m_screen, &m_callbacks, this);
  }

  ~VtContent() {
    m_pty = {};
    m_processWatcher.join();
    m_pipeReader.join();
    vterm_free(m_vt);
  }

  std::tuple<int, int> RowsCols() const {
    int rows, cols;
    vterm_get_size(m_vt, &rows, &cols);
    return {rows, cols};
  }

  void Resize(int rows, int cols) {
    auto [h, w] = RowsCols();
    if (rows == h && w == cols) {
      return;
    }
    m_pty->Resize(COORD{
        .X = (SHORT)cols,
        .Y = (SHORT)rows,
    });
    vterm_set_size(m_vt, rows, cols);
    vterm_screen_reset(m_screen, true);
  }

  void Flush() {
    vterm_screen_flush_damage(m_screen);
    vterm_state_get_cursorpos(vterm_obtain_state(m_vt), &m_cursor);
  }

  VTermScreenCell *Cell(const VTermPos &pos) {
    vterm_screen_get_cell(m_screen, pos, &m_cell);
    return &m_cell;
  }

  void WriteChild(const std::string &str) {
    ChildProcess::Write(str.c_str(), str.size(), m_pty->WritePipe);
  }
};

struct VtRenderer {
  std::shared_ptr<VtContent> m_vt;
  std::string m_cmd;
  int m_rows = 0;
  int m_cols = 0;
  std::function<void()> m_onDamaged;
  std::function<void()> m_onExit;
  int m_count = 0;

  void RequireRowsCols(int rows, int cols) {
    if (rows && cols) {
      if (!m_vt) {
        m_vt = std::make_shared<VtContent>(rows, cols, m_cmd);
        m_vt->m_onDamaged = [=]() { OnDamage(); };
        m_vt->m_onExit = [=]() { OnExit(); };
      } else {
        m_vt->Resize(rows, cols);
      }
    }
    m_rows = rows;
    m_cols = cols;
  }

  void OnDamage() {
    ++m_count;
    if (m_onDamaged) {
      m_onDamaged();
    }
  }

  void OnExit() {
    if (m_onExit) {
      m_onExit();
    }
  }

  std::string Status() const {
    std::stringstream ss;
    ss << "rowcols:" << m_rows << ":" << m_cols << "(" << m_count << ")";
    return ss.str();
  }

  void Flush() {
    if (!m_vt) {
      return;
    }
    m_vt->Flush();
  }

  void RenderPixel(const VTermPos &pos, ftxui::Pixel *pixel) {
    if (!m_vt) {
      return;
    }
    auto &dst = pixel->character;

    auto cell = m_vt->Cell(pos);
    if (cell->width == 0 || cell->chars[0] == 0) {
      dst = " ";
      return;
    }

    dst.clear();
    for (int i = 0; i < cell->width; ++i) {
      auto utf8 = to_utf8(cell->chars[i]);
      dst.append(utf8.begin(), utf8.end());
    }
  }

  std::string m_childInput;
  void WriteChild(const std::string &str) {
    m_childInput += str;
    if (!m_vt) {
      return;
    }
    m_vt->WriteChild(str);
  }
};

struct VtNode : ftxui::Node {
  std::shared_ptr<VtRenderer> m_renderer;

  int Width() const { return box_.x_max - box_.x_min + 1; }
  int Height() const { return box_.y_max - box_.y_min + 1; }

  void SetBox(ftxui::Box box) override {
    ftxui::Node::SetBox(box);
    m_renderer->RequireRowsCols(Height(), Width());
  }

  void Render(ftxui::Screen &screen) override {
    m_renderer->Flush();
    int row = 0;
    for (int y = box_.y_min; y <= box_.y_max; ++y, ++row) {
      int col = 0;
      for (int x = box_.x_min; x <= box_.x_max; ++x, ++col) {
        auto &pixel = screen.PixelAt(x, y);
        m_renderer->RenderPixel({row, col}, &pixel);
      }
    }

    ftxui::Screen::Cursor cursor{
        box_.x_min + m_renderer->m_vt->m_cursor.col,
        box_.y_min + m_renderer->m_vt->m_cursor.row,
    };
    switch (m_renderer->m_vt->m_cursorShape) {
    case VTERM_PROP_CURSORSHAPE_BLOCK:
      cursor.shape = ftxui::Screen::Cursor::Shape::Block;
      break;
    case VTERM_PROP_CURSORSHAPE_UNDERLINE:
      cursor.shape = ftxui::Screen::Cursor::Shape::Underline;
      break;
    case VTERM_PROP_CURSORSHAPE_BAR_LEFT:
      cursor.shape = ftxui::Screen::Cursor::Shape::Bar;
      break;
    }
    screen.SetCursor(cursor);
  }
};

struct VtComponent : ftxui::ComponentBase {
  std::shared_ptr<VtNode> m_node;
  std::list<ftxui::Event> m_events;

  bool Focusable() const override { return true; }

  VtComponent(const std::shared_ptr<VtNode> &node) : m_node(node) {}

  ftxui::Element Render() override { return m_node; }

  bool OnEvent(ftxui::Event event) override {
    if (event.is_mouse()) {
      return false;
    }

    if (event != ftxui::Event::Custom) {
      m_events.push_back(event);
      while (m_events.size() > 100) {
        m_events.pop_front();
      }
    }

    if (event == ftxui::Event::Return) {
      m_node->m_renderer->WriteChild("\r\n");
      return true;
    }

    m_node->m_renderer->WriteChild(event.input());
    return true;
  }
};

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

  Logger(const std::shared_ptr<VtComponent> &vt) : m_vt(vt) {}

  ftxui::Box box_;

  ftxui::Element Render() override {
    ftxui::Elements children;
    auto &keys = m_vt->m_events;
    auto it = keys.begin();
    auto h = box_.y_max - box_.y_min + 1;
    std::stringstream ss;
    ss << "h:" << h;
    for (int i = 0; i < std::max(0, (int)keys.size() - h); ++i) {
      ++it;
    }
    // children.push_back(ftxui::text(ss.str()));
    for (; it != keys.end(); ++it) {
      children.push_back(ftxui::text(Stringify(*it)));
    }
    return vbox(std::move(children)) | reflect(box_);
  }
};

int main() {
  auto screen = ftxui::ScreenInteractive::Fullscreen();

  auto renderer = std::make_shared<VtRenderer>();
  renderer->m_cmd = "cmd.exe";
  renderer->m_onDamaged = [&screen]() {
    screen.PostEvent(ftxui::Event::Custom);
  };
  renderer->m_onExit = [&screen]() {
    // screen.ExitLoopClosure();
    screen.Exit();
  };
  std::shared_ptr<VtNode> node = std::make_shared<VtNode>();
  node->m_renderer = renderer;

  auto vt = std::make_shared<VtComponent>(node);
  ftxui::Component middle = vt;

  // vt
  // TODO: table
  // process:state
  // screen:size
  // cursor:pos
  auto right = ftxui::Renderer(
      [vt] { return ftxui::text(vt->m_node->m_renderer->Status()); });

  // logger(event)
  auto bottom = std::make_shared<Logger>(vt);

  int right_size = 20;
  int bottom_size = 10;

  auto container = middle;
  container = ftxui::ResizableSplitRight(right, container, &right_size);
  container = ftxui::ResizableSplitBottom(bottom, container, &bottom_size);

  auto component = ftxui::Renderer(
      container, [&] { return container->Render() | ftxui::border; });
  middle->TakeFocus();

  screen.Loop(component);
}
