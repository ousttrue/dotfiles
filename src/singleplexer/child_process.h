#pragma once
#include <chrono>
#include <functional>
#include <memory>
#include <stdint.h>
#include <string>
#include <vector>

struct RowsCols {
  int Rows;
  int Cols;
};

struct Pty {
  struct PtyImpl *m_impl = nullptr;

  Pty(const RowsCols &size);
  Pty(const Pty &) = delete;
  Pty &operator=(const Pty &) = delete;
  ~Pty() { Close(); }
  void Resize(const RowsCols &size);
  void Close();
  void *ReadPipe() const;
  void *WritePipe() const;
};

class ChildProcess {
  struct ChildProcessImpl *m_impl = nullptr;
  ChildProcess();

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
    void *hPipe,
    const std::function<void(const char *buf, uint32_t size)> &callback);
