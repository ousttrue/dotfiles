#include "vt_component.h"
#include "child_process.h"
#include "utf8.h"

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

void VtRenderer::RequireRowsCols(int rows, int cols) {
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

void VtRenderer::OnDamage() {
  ++m_count;
  if (m_onDamaged) {
    m_onDamaged();
  }
}

void VtRenderer::OnExit() {
  if (m_onExit) {
    m_onExit();
  }
}

std::string VtRenderer::Status() const {
  std::stringstream ss;
  ss << "rowcols:" << m_rows << ":" << m_cols << "(" << m_count << ")";
  return ss.str();
}

void VtRenderer::Flush() {
  if (!m_vt) {
    return;
  }
  m_vt->Flush();
}

void VtRenderer::RenderPixel(const VTermPos &pos, ftxui::Pixel *pixel) {
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
void VtRenderer::WriteChild(const std::string &str) {
  m_childInput += str;
  if (!m_vt) {
    return;
  }
  m_vt->WriteChild(str);
}

void VtNode::SetBox(ftxui::Box box) {
  ftxui::Node::SetBox(box);
  m_renderer->RequireRowsCols(Height(), Width());
}

void VtNode::Render(ftxui::Screen &screen) {
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

ftxui::Element VtComponent::Render() { return m_node; }

bool VtComponent::OnEvent(ftxui::Event event) {
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
