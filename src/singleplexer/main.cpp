#include <vterm.h>

// #include "ftxui/component/captured_mouse.hpp" // for ftxui
#include "ftxui/component/screen_interactive.hpp" // for ScreenInteractive
#include <ftxui/component/component.hpp>
// #include <ftxui/dom/elements.hpp>
// #include <ftxui/screen/screen.hpp>

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

struct Pty {
  HPCON Console = nullptr;
  HANDLE ReadPipe{INVALID_HANDLE_VALUE};
  HANDLE WritePipe{INVALID_HANDLE_VALUE};

  Pty(const COORD &size) {
    HANDLE inPipeRead{INVALID_HANDLE_VALUE};
    if (!CreatePipe(&inPipeRead, &WritePipe, NULL, 0)) {
      assert(false);
      return;
    }

    HANDLE outPipeWrite{INVALID_HANDLE_VALUE};
    if (!CreatePipe(&ReadPipe, &outPipeWrite, NULL, 0)) {
      CloseHandle(inPipeRead);
      CloseHandle(WritePipe);
      assert(false);
      return;
    }

    // Create the Pseudo Console of the required size, attached to the PTY-end
    // of the pipes
    auto hr = CreatePseudoConsole(size, inPipeRead, outPipeWrite, 0, &Console);
    // Note: We can close the handles to the PTY-end of the pipes here
    // because the handles are dup'ed into the ConHost and will be released
    // when the ConPTY is destroyed.
    if (INVALID_HANDLE_VALUE != outPipeWrite) {
      CloseHandle(outPipeWrite);
    }
    if (INVALID_HANDLE_VALUE != inPipeRead) {
      CloseHandle(inPipeRead);
    }
    if (FAILED(hr)) {
      CloseHandle(WritePipe);
      CloseHandle(ReadPipe);
      assert(false);
      return;
    }

    assert(Console);
  }
  Pty(const Pty &) = delete;
  Pty &operator=(const Pty &) = delete;
  ~Pty() { Close(); }

  void Resize(const COORD &size) { ResizePseudoConsole(Console, size); }

  void Close() {
    if (Console) {
      ClosePseudoConsole(Console);
      Console = nullptr;
    }
    if (ReadPipe != INVALID_HANDLE_VALUE) {
      CloseHandle(ReadPipe);
      ReadPipe = INVALID_HANDLE_VALUE;
    }
    if (WritePipe != INVALID_HANDLE_VALUE) {
      CloseHandle(WritePipe);
      WritePipe = INVALID_HANDLE_VALUE;
    }
  }
};

COORD GetConsoleSize() {
  COORD consoleSize{};
  CONSOLE_SCREEN_BUFFER_INFO csbi{};
  HANDLE hConsole{GetStdHandle(STD_OUTPUT_HANDLE)};
  if (GetConsoleScreenBufferInfo(hConsole, &csbi)) {
    consoleSize.X = csbi.srWindow.Right - csbi.srWindow.Left + 1;
    consoleSize.Y = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
  }
  return consoleSize;
}

class ChildProcess {
  STARTUPINFOEXA m_si{};
  PROCESS_INFORMATION m_pi{};
  std::vector<uint8_t> m_attr;

  ChildProcess() { m_si.StartupInfo.cb = sizeof(STARTUPINFOEXA); }

  HRESULT
  InitializeStartupInfoAttachedToPseudoConsole(HPCON hPC) {

    // Get the size of the thread attribute list.
    size_t attrListSize{};
    InitializeProcThreadAttributeList(NULL, 1, 0, &attrListSize);
    m_attr.resize(attrListSize);
    m_si.lpAttributeList =
        reinterpret_cast<LPPROC_THREAD_ATTRIBUTE_LIST>(m_attr.data());

    // Initialize thread attribute list
    if (!InitializeProcThreadAttributeList(m_si.lpAttributeList, 1, 0,
                                           &attrListSize)) {
      auto hr = HRESULT_FROM_WIN32(GetLastError());
      return hr;
    }

    // Set Pseudo Console attribute
    if (!UpdateProcThreadAttribute(m_si.lpAttributeList, 0,
                                   PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE, hPC,
                                   sizeof(HPCON), NULL, NULL)) {
      auto hr = HRESULT_FROM_WIN32(GetLastError());
      return hr;
    }

    return S_OK;
  }

public:
  ~ChildProcess() {
    if (m_pi.hThread) {
      CloseHandle(m_pi.hThread);
    }
    if (m_pi.hProcess) {
      CloseHandle(m_pi.hProcess);
    }
    DeleteProcThreadAttributeList(m_si.lpAttributeList);
  }
  ChildProcess(const ChildProcess &) = delete;
  ChildProcess &operator=(const ChildProcess &) = delete;

  static std::shared_ptr<ChildProcess> Launch(const Pty &pty, std::string cmd) {

    auto ptr = std::shared_ptr<ChildProcess>(new ChildProcess);
    if (FAILED(
            ptr->InitializeStartupInfoAttachedToPseudoConsole(pty.Console))) {
      return {};
    }

    // Launch ping to emit some text back via the pipe
    if (!CreateProcessA(NULL,       // No module name - use Command Line
                        cmd.data(), // Command Line
                        NULL,       // Process handle not inheritable
                        NULL,       // Thread handle not inheritable
                        FALSE,      // Inherit handles
                        EXTENDED_STARTUPINFO_PRESENT, // Creation flags
                        NULL, // Use parent's environment block
                        NULL, // Use parent's starting directory
                        &ptr->m_si.StartupInfo, // Pointer to STARTUPINFO
                        &ptr->m_pi // Pointer to PROCESS_INFORMATION
                        )) {
      // auto hr = GetLastError();
      return {};
    }

    return ptr;
  }

  void Wait(const std::chrono::milliseconds ms) {
    WaitForSingleObject(m_pi.hThread, ms.count());
  }

  void Wait() { WaitForSingleObject(m_pi.hThread, INFINITE); }

  static void Write(const char *buf, size_t size, void *handle) {
    DWORD written;
    if (!::WriteFile((HANDLE)handle, buf, size, &written, NULL)) {
      return;
    }
    // return written;
  }
};

void PipeReader(
    HANDLE hPipe,
    const std::function<void(const char *buf, uint32_t size)> &callback) {

  const DWORD BUFF_SIZE{512};
  char szBuffer[BUFF_SIZE]{};
  while (true) {
    // Read from the pipe
    DWORD dwBytesRead{};
    auto fRead = ReadFile(hPipe, szBuffer, BUFF_SIZE, &dwBytesRead, NULL);
    if (fRead && dwBytesRead >= 0) {
      callback(szBuffer, dwBytesRead);
    } else {
      break;
    }
  }

  return;
}

struct VtContent {
  VTerm *m_vt;
  VTermScreen *m_screen;
  VTermScreenCell m_cell;
  std::shared_ptr<Pty> m_pty;
  std::shared_ptr<ChildProcess> m_child;
  std::thread m_pipeReader;
  std::function<void()> m_onDamaged;
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
    return 0;
  }
  static int screen_settermprop(VTermProp prop, VTermValue *val, void *user) {
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
    m_pipeReader = std::thread(
        [pipe = m_pty->ReadPipe, callback]() { PipeReader(pipe, callback); });
    m_child = ChildProcess::Launch(*m_pty, cmd);

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
    m_child->Wait();
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

  void Flush() { vterm_screen_flush_damage(m_screen); }

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
  int m_count = 0;

  void RequireRowsCols(int rows, int cols) {
    if (rows && cols) {
      if (!m_vt) {
        m_vt = std::make_shared<VtContent>(rows, cols, m_cmd);
        m_vt->m_onDamaged = [=]() { OnDamage(); };
      } else {
        m_vt->Resize(rows, cols);
      }
    }
    m_rows = rows;
    m_cols = cols;
  }

  int OnDamage() {
    ++m_count;
    if (m_onDamaged) {
      m_onDamaged();
    }
    return 1;
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
  }
};

struct VtComponent : ftxui::ComponentBase {
  std::shared_ptr<VtNode> m_node;
  std::string m_event;

  bool Focusable() const override { return true; }

  VtComponent(const std::shared_ptr<VtNode> &node) : m_node(node) {}

  ftxui::Element Render() override { return m_node; }

  bool OnEvent(ftxui::Event event) override {
    if (event.is_mouse()) {
      return false;
    }

    m_event += "e";
    if (event == ftxui::Event::Return) {
      m_node->m_renderer->WriteChild("\r\n");
      return true;
    }

    m_node->m_renderer->WriteChild(event.input());
    return true;
  }
};

int main() {
  auto screen = ftxui::ScreenInteractive::Fullscreen();

  auto renderer = std::make_shared<VtRenderer>();
  renderer->m_cmd = "cmd.exe";
  renderer->m_onDamaged = [&screen]() {
    screen.PostEvent(ftxui::Event::Custom);
  };
  std::shared_ptr<VtNode> node = std::make_shared<VtNode>();
  node->m_renderer = renderer;

  auto vt = std::make_shared<VtComponent>(node);
  ftxui::Component middle = vt;

  // pty / process
  auto left = ftxui::Renderer(
      [vt] { return ftxui::text(vt->m_node->m_renderer->m_childInput); });

  // vt
  auto right = ftxui::Renderer(
      [vt] { return ftxui::text(vt->m_node->m_renderer->Status()); });

  auto top = ftxui::Renderer([vt] { return ftxui::text(vt->m_event); });

  // logger(event)
  auto bottom =
      ftxui::Renderer([] { return ftxui::text("bottom") | ftxui::center; });

  int left_size = 20;
  int right_size = 20;
  int top_size = 10;
  int bottom_size = 10;

  auto container = middle;
  container = ftxui::ResizableSplitLeft(left, container, &left_size);
  container = ftxui::ResizableSplitRight(right, container, &right_size);
  container = ftxui::ResizableSplitTop(top, container, &top_size);
  container = ftxui::ResizableSplitBottom(bottom, container, &bottom_size);

  auto component = ftxui::Renderer(
      container, [&] { return container->Render() | ftxui::border; });
  middle->TakeFocus();

  screen.Loop(component);
}
