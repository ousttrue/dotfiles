#include "posix_launch.h"
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
#include <sys/wait.h>

#include <string>
#include <vector>

namespace posix {

bool launch(std::span<std::string_view> args) {
  auto pid = fork();
  if (pid == 0) {
    // Child process
    std::vector<std::string> _buffer;
    for (auto arg : args) {
      _buffer.push_back({arg.begin(), arg.end()});
    }
    std::vector<char *> _args;
    for (auto b : _buffer) {
      _args.push_back(b.data());
    }
    _args.push_back(0);

    if (execvp(_args[0], _args.data()) == -1) {
      perror("xsh");
    }
    exit(EXIT_FAILURE);
  } else if (pid < 0) {
    // Error forking
    return false;
  } else {
    // Parent process
    int status;
    do {
      waitpid(pid, &status, WUNTRACED);
    } while (!WIFEXITED(status) && !WIFSIGNALED(status));
    return true;
  }
}

} // namespace posix
