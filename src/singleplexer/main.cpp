#include <ftxui/dom/elements.hpp>
#include <ftxui/screen/screen.hpp>

#include <iostream>
#include <memory>
#include <process.h>
#include <windows.h>

class ChildProcess {

  HANDLE m_readPipe;
  HANDLE m_writePipe;

  ChildProcess() {}

  HRESULT CreatePseudoConsoleAndPipes(HPCON *phPC, HANDLE *phPipeIn,
                                      HANDLE *phPipeOut) {

    auto ptr = std::shared_ptr<ChildProcess>(new ChildProcess);

    // Create the pipes to which the ConPTY will connect
    HANDLE hPipePTYIn{INVALID_HANDLE_VALUE};
    HANDLE hPipePTYOut{INVALID_HANDLE_VALUE};
    if (CreatePipe(&hPipePTYIn, ptr->m_writePipe, NULL, 0) &&
        CreatePipe(ptr->m_readPipe, &hPipePTYOut, NULL, 0)) {
      // Determine required size of Pseudo Console
      // COORD consoleSize{};
      // CONSOLE_SCREEN_BUFFER_INFO csbi{};
      // HANDLE hConsole{GetStdHandle(STD_OUTPUT_HANDLE)};
      // if (GetConsoleScreenBufferInfo(hConsole, &csbi)) {
      //   consoleSize.X = csbi.srWindow.Right - csbi.srWindow.Left + 1;
      //   consoleSize.Y = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
      // }

      // Create the Pseudo Console of the required size, attached to the PTY-end
      // of the pipes
      hr = CreatePseudoConsole(consoleSize, hPipePTYIn, hPipePTYOut, 0, phPC);

      // Note: We can close the handles to the PTY-end of the pipes here
      // because the handles are dup'ed into the ConHost and will be released
      // when the ConPTY is destroyed.
      if (INVALID_HANDLE_VALUE != hPipePTYOut)
        CloseHandle(hPipePTYOut);
      if (INVALID_HANDLE_VALUE != hPipePTYIn)
        CloseHandle(hPipePTYIn);
    } else {
      return {};
    }
  }

public:
  static std::shared_ptr<ChildProcess> Create(const char *cmd) { return {}; }
};

int main(void) {

  auto p = ChildProcess::Create("lsd.exe");

  // Define the document
  auto document = ftxui::hbox({
      ftxui::text("left") | ftxui::border,
      ftxui::text("middle") | ftxui::border | ftxui::flex,
      ftxui::text("right") | ftxui::border,
  });

  auto screen = ftxui::Screen::Create(ftxui::Dimension::Full(),       // Width
                                      ftxui::Dimension::Fit(document) // Height
  );
  ftxui::Render(screen, document);
  screen.Print();

  return EXIT_SUCCESS;
}
