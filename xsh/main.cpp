///
/// experimental XSH
///
#include "posix_launch.h"
#include <array>
#include <functional>
#include <iostream>
#include <span>
#include <unordered_map>
#include <vector>
// chdir
#include <unistd.h>

using Args = std::span<std::string_view>;
using CommandFunc = std::function<bool(Args args)>;
struct Cmd {
  std::string Name;
  CommandFunc Command;
};

class Readline {
  std::string m_buffer;

public:
  std::string_view getline(const std::string &prompt) {
    // show prompt
    printf("%s", prompt.c_str());

    // readline
    m_buffer.clear();
    while (1) {
      auto c = getchar();
      if (c == EOF || c == '\n') {
        break;
      }
      m_buffer.push_back(c);
    }
    return m_buffer;
  }
};

class Splitter {
  std::vector<std::string_view> m_tokens;

public:
  Args Split(std::string_view line) {
    m_tokens.clear();

    size_t pos = 0;
    while (pos < line.size()) {
      size_t begin = 0;
      size_t end = 0;

      // begin
      for (; pos < line.size(); ++pos) {
        if (!std::isspace(line[pos])) {
          begin = pos;
          break;
        }
      }

      // end
      for (; pos < line.size(); ++pos) {
        if (std::isspace(line[pos])) {
          end = pos;
          break;
        }
      }
      if (end == 0) {
        end = pos;
      }

      // token
      std::string_view token{line.data() + begin, line.data() + end};
      // std::cout << pos << ", " << begin << ", " << end << ", " << '"' <<
      // token
      //           << '"' << std::endl;
      if (begin < end) {
        m_tokens.push_back({line.data() + begin, line.data() + end});
      }
    }

    return m_tokens;
  }
};

class Dispatcher {
  std::vector<Cmd> m_builtins = {{"exit", [](Args args) { return false; }}};

public:
  Dispatcher() {}

  void add_builtin(std::string_view name, const CommandFunc &callback) {
    m_builtins.push_back(Cmd{{name.begin(), name.end()}, callback});
  }

  void show_help() const {
    printf("builtin commands:\n");
    for (auto &cmd : m_builtins) {
      printf("  %s\n", cmd.Name.c_str());
    }
  }

  bool dispatch(Args args) {
    if (args.empty()) {
      return true;
    }

    for (auto cmd : m_builtins) {
      if (cmd.Name == args[0]) {
        // builtin command
        return cmd.Command(args);
      }
    }

    return posix::launch(args);
  }
};

int main(int argc, char **argv) {
  Readline readline;
  Splitter splitter;
  Dispatcher dispatcher;

  // cd
  dispatcher.add_builtin("cd", [](Args args) {
    if (args.size() < 2) {
      fprintf(stderr, "xsh: expected argument to \"cd\"\n");
    } else {
      std::string dir = {args[1].begin(), args[2].end()};
      if (chdir(dir.c_str()) != 0) {
        perror("xsh");
      }
    }
    return true;
  });

  // help
  dispatcher.add_builtin("help", [&dispatcher](Args args) {
    dispatcher.show_help();
    return true;
  });

  while (true) {
    auto line = readline.getline("> ");
    auto tokens = splitter.Split(line);
    if (!dispatcher.dispatch(tokens)) {
      break;
    }
  }
  return 0;
}
