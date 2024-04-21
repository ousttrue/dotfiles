#include "ipty.h"
#include <Windows.h>

DWORD g_fdwSaveOldMode = 0;
HANDLE g_hStdin;

int enableRawMode(AtExitFunc atExit) {
  g_hStdin = GetStdHandle(STD_INPUT_HANDLE);

  if (!GetConsoleMode(g_hStdin, &g_fdwSaveOldMode)) {
    // ErrorExit("GetConsoleMode");
    return false;
  }

  auto fdwMode = ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT;
  if (!SetConsoleMode(g_hStdin, fdwMode)) {
    // ErrorExit("SetConsoleMode");
    return false;
  }

  return true;
}

void disableRawMode() { SetConsoleMode(g_hStdin, g_fdwSaveOldMode); }

bool getWindowSize(int *rows, int *cols) {
  CONSOLE_SCREEN_BUFFER_INFO csbi;
  if (GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi) == 0) {
    return false;
  }

  *cols = csbi.srWindow.Right - csbi.srWindow.Left + 1;
  *rows = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
  return true;
}

std::vector<int> getInput() {

  INPUT_RECORD irInBuf[128];
  DWORD cNumRead;
  if (!ReadConsoleInput(g_hStdin,     // input buffer handle
                        irInBuf,      // buffer to read into
                        128,          // size of read buffer
                        &cNumRead)) { // number of records read
    return {};
    // ErrorExit("ReadConsoleInput");
  }

  // Dispatch the events to the appropriate handler.
  std::vector<int> buf;
  for (int i = 0; i < cNumRead; i++) {
    switch (irInBuf[i].EventType) {
    case KEY_EVENT: // keyboard input
      // KeyEventProc(irInBuf[i].Event.KeyEvent);
      {
        auto e = irInBuf[i].Event.KeyEvent;
        if (e.bKeyDown) {
          buf.push_back(e.uChar.AsciiChar);
        }
      }
      break;

    case MOUSE_EVENT: // mouse input
      // MouseEventProc(irInBuf[i].Event.MouseEvent);
      break;

    case WINDOW_BUFFER_SIZE_EVENT: // scrn buf. resizing
      // ResizeEventProc(irInBuf[i].Event.WindowBufferSizeEvent);
      break;

    case FOCUS_EVENT: // disregard focus events

    case MENU_EVENT: // disregard menu events
      break;

    default:
      // ErrorExit("Unknown event type");
      break;
    }
  }
  return buf;
}
