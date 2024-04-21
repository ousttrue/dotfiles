#include "ipty.h"
#include <Windows.h>
#include <vector>

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

int getWindowSize(int *rows, int *cols) {
  CONSOLE_SCREEN_BUFFER_INFO csbi;
  if (GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi) == 0) {
    return false;
  }

  *cols = csbi.srWindow.Right - csbi.srWindow.Left + 1;
  *rows = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
  return true;
}

INPUT_RECORD g_irInBuf[128];
DWORD g_cNumRead = 0;
size_t g_current = 0;

int getInput() {
  if (g_current >= g_cNumRead) {
    g_current = 0;
    if (!ReadConsoleInput(g_hStdin,       // input buffer handle
                          g_irInBuf,      // buffer to read into
                          128,            // size of read buffer
                          &g_cNumRead)) { // number of records read
      return {};
      // ErrorExit("ReadConsoleInput");
    }
  }

  // Dispatch the events to the appropriate handler.
  for (; g_current < g_cNumRead;) {
    auto record = g_irInBuf[g_current++];
    switch (record.EventType) {
    case KEY_EVENT: // keyboard input
      // KeyEventProc(irInBuf[i].Event.KeyEvent);
      {
        auto e = record.Event.KeyEvent;
        if (e.bKeyDown) {
          return e.uChar.AsciiChar;
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

  return 0;
}
