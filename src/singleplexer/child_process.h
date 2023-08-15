#pragma once
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#include <chrono>
#include <functional>
#include <memory>
#include <stdint.h>
#include <string>
#include <vector>

struct Pty {
  HPCON Console = nullptr;
  HANDLE ReadPipe{INVALID_HANDLE_VALUE};
  HANDLE WritePipe{INVALID_HANDLE_VALUE};

  Pty(const COORD &size);
  Pty(const Pty &) = delete;
  Pty &operator=(const Pty &) = delete;
  ~Pty() { Close(); }
  void Resize(const COORD &size);
  void Close();
};

class ChildProcess {
  STARTUPINFOEXA m_si{};
  PROCESS_INFORMATION m_pi{};
  std::vector<uint8_t> m_attr;

  ChildProcess() { m_si.StartupInfo.cb = sizeof(STARTUPINFOEXA); }

  HRESULT
  InitializeStartupInfoAttachedToPseudoConsole(HPCON hPC);

public:
  ~ChildProcess();
  ChildProcess(const ChildProcess &) = delete;
  ChildProcess &operator=(const ChildProcess &) = delete;

  static std::shared_ptr<ChildProcess> Launch(const Pty &pty, std::string cmd);

  void Wait(const std::chrono::milliseconds ms);

  void Wait();

  static void Write(const char *buf, size_t size, void *handle);
};

void PipeReader(
    HANDLE hPipe,
    const std::function<void(const char *buf, uint32_t size)> &callback);
