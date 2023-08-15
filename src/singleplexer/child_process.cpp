#include "child_process.h"
#include <assert.h>

Pty::Pty(const COORD &size) {
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

void Pty::Resize(const COORD &size) { ResizePseudoConsole(Console, size); }

void Pty::Close() {
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

HRESULT
ChildProcess::InitializeStartupInfoAttachedToPseudoConsole(HPCON hPC) {

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

ChildProcess::~ChildProcess() {
  if (m_pi.hThread) {
    CloseHandle(m_pi.hThread);
  }
  if (m_pi.hProcess) {
    CloseHandle(m_pi.hProcess);
  }
  DeleteProcThreadAttributeList(m_si.lpAttributeList);
}

std::shared_ptr<ChildProcess> ChildProcess::Launch(const Pty &pty,
                                                   std::string cmd) {

  auto ptr = std::shared_ptr<ChildProcess>(new ChildProcess);
  if (FAILED(ptr->InitializeStartupInfoAttachedToPseudoConsole(pty.Console))) {
    return {};
  }

  // Launch ping to emit some text back via the pipe
  if (!CreateProcessA(NULL,       // No module name - use Command Line
                      cmd.data(), // Command Line
                      NULL,       // Process handle not inheritable
                      NULL,       // Thread handle not inheritable
                      FALSE,      // Inherit handles
                      EXTENDED_STARTUPINFO_PRESENT, // Creation flags
                      NULL,                   // Use parent's environment block
                      NULL,                   // Use parent's starting directory
                      &ptr->m_si.StartupInfo, // Pointer to STARTUPINFO
                      &ptr->m_pi              // Pointer to PROCESS_INFORMATION
                      )) {
    // auto hr = GetLastError();
    return {};
  }

  return ptr;
}

void ChildProcess::Wait(const std::chrono::milliseconds ms) {
  WaitForSingleObject(m_pi.hThread, ms.count());
}

void ChildProcess::Wait() { WaitForSingleObject(m_pi.hThread, INFINITE); }

void ChildProcess::Write(const char *buf, size_t size, void *handle) {
  DWORD written;
  if (!::WriteFile((HANDLE)handle, buf, size, &written, NULL)) {
    return;
  }
  // return written;
}

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
