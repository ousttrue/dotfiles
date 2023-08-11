#include <Windows.h>
#include <assert.h>
#include <chrono>
#include <functional>
#include <memory>
#include <process.h>
#include <thread>
#include <vector>

struct Pty {
  HPCON Console;
  HANDLE ReadPipe;
  HANDLE WritePipe;
};

Pty CreatePty(const COORD &size) {
  Pty pty = {0};

  HANDLE inPipeRead{INVALID_HANDLE_VALUE};
  if (!CreatePipe(&inPipeRead, &pty.WritePipe, NULL, 0)) {
    return {};
  }

  HANDLE outPipeWrite{INVALID_HANDLE_VALUE};
  if (!CreatePipe(&pty.ReadPipe, &outPipeWrite, NULL, 0)) {
    CloseHandle(inPipeRead);
    CloseHandle(pty.WritePipe);
    return {};
  }

  // Create the Pseudo Console of the required size, attached to the PTY-end
  // of the pipes
  auto hr =
      CreatePseudoConsole(size, inPipeRead, outPipeWrite, 0, &pty.Console);
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
    CloseHandle(pty.WritePipe);
    CloseHandle(pty.ReadPipe);
    return {};
  }

  assert(pty.Console);
  return pty;
}

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
};

void BeginPipeReadThread(
    HANDLE hPipe,
    const std::function<uint32_t(const char *buf, uint32_t size)> &callback) {

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

int main(int argc, char **argv) {
  // set console mode
  {
    HANDLE hConsole = {GetStdHandle(STD_OUTPUT_HANDLE)};
    // Enable Console VT Processing
    DWORD consoleMode{};
    GetConsoleMode(hConsole, &consoleMode);
    auto hr = SetConsoleMode(hConsole,
                             consoleMode | ENABLE_VIRTUAL_TERMINAL_PROCESSING)
                  ? S_OK
                  : GetLastError();
    if (S_OK != hr) {
      return 1;
    }
  }

  auto size = GetConsoleSize();

  auto pty = CreatePty(size);
  if (!pty.Console) {
    return 2;
  }

  auto callback = [hConsole = GetStdHandle(STD_OUTPUT_HANDLE)](const char *buf,
                                                               uint32_t size) {
    DWORD dwBytesWritten;
    WriteFile(hConsole, buf, size, &dwBytesWritten, NULL);
    return dwBytesWritten;
  };

  std::thread t([hPipe = pty.ReadPipe, callback]() {
    BeginPipeReadThread(hPipe, callback);
  });

  {
    auto szCommand = "ping localhost";
    auto child = ChildProcess::Launch(pty, szCommand);
    if (!child) {
      return 3;
    }

    // Wait up to 10s for ping process to complete
    child->Wait(std::chrono::milliseconds(10 * 1000));
  }

  // Close ConPTY - this will terminate client process if running
  ClosePseudoConsole(pty.Console);

  t.join();

  // Clean-up the pipes
  CloseHandle(pty.ReadPipe);
  CloseHandle(pty.WritePipe);

  return 0;
}
