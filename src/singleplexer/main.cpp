#include <vterm.h>

#include <ftxui/dom/elements.hpp>
#include <ftxui/screen/screen.hpp>

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

struct VtNode : ftxui::Node {
  VTerm *m_vt;
  VTermScreen *m_screen;
  VtNode(VTerm *vt) : m_vt(vt) {
    vterm_set_utf8(m_vt, true);

    m_screen = vterm_obtain_screen(vt);
    vterm_screen_reset(m_screen, true);

    int row, col;
    vterm_get_size(m_vt, &row, &col);
    requirement_.min_x = col;
    requirement_.min_y = row;
  }

  int Width() const { return box_.x_max - box_.x_min + 1; }
  int Height() const { return box_.y_max - box_.y_min + 1; }

  void SetBox(ftxui::Box box) override {
    ftxui::Node::SetBox(box);
    vterm_set_size(m_vt, Height(), Width());
    vterm_screen_reset(m_screen, false);
  }

  void Render(ftxui::Screen &screen) override {
    int x = box_.x_min;
    const int y = box_.y_min;
    if (y > box_.y_max) {
      return;
    }

    // for (const auto &cell : Utf8ToGlyphs(text_)) {
    //   if (x > box_.x_max) {
    //     return;
    //   }
    //   screen.PixelAt(x, y).character = cell;
    //   ++x;
    // }
    //
    vterm_screen_flush_damage(m_screen);
    int rows, cols;
    vterm_get_size(m_vt, &rows, &cols);
    for (int y = 0; y < rows; ++y) {
      for (int x = 0; x < cols; ++x) {
        VTermScreenCell cell;
        vterm_screen_get_cell(m_screen, {y, x}, &cell);

        wchar_t ch = cell.chars[0];
        if (ch > 0 && ch < 128) {
          if (ch != ' ') {
            auto a = 0;
          }
        }

        auto &dst = screen.PixelAt(x + 1, y + 1).character;
        dst.clear();
        for (int i = 0; i < cell.width; ++i) {
          if (cell.chars[i] == 0) {
            dst = " ";
            break;
          }
          auto utf8 = to_utf8(cell.chars[i]);
          dst.append(utf8.begin(), utf8.end());
        }
      }
    }
  }
};

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
}

int main(void) {
  const auto rows = 30;
  const auto cols = 60;

  auto vt = vterm_new(rows, cols);
  std::shared_ptr<VtNode> node = std::make_shared<VtNode>(vt);

  ftxui::Element document = node | ftxui::border;
  auto screen = ftxui::Screen::Create(ftxui::Dimension::Full(),       // Width
                                      ftxui::Dimension::Fit(document) // Height
  );

  {
    Pty pty({
        .X = (SHORT)node->Width(),
        .Y = (SHORT)node->Height(),
    });

    auto callback = [vt](const char *buf, uint32_t size) {
      vterm_input_write(vt, buf, size);
    };
    std::thread t(
        [pipe = pty.ReadPipe, callback]() { PipeReader(pipe, callback); });

    {
      auto p = ChildProcess::Launch(pty, "lsd.exe");
      p->Wait();
    }

    pty.Close();

    t.join();
  }

  ftxui::Render(screen, document);
  screen.Print();

  return EXIT_SUCCESS;
}
