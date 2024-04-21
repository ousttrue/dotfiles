#include "ipty.h"
#include "kilo.h"
#include "kilo_highlight.h"

struct editorConfig E;

static void handleSigWinCh(int) {
  updateWindowSize(&E);
  if (E.cy > E.screenrows)
    E.cy = E.screenrows - 1;
  if (E.cx > E.screencols)
    E.cx = E.screencols - 1;
  editorRefreshScreen(&E);
}

/* Called at exit to avoid remaining in raw mode. */
static void editorAtExit(void) { disableRawMode(); }

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "Usage: kilo <filename>\n");
    exit(1);
  }

  initEditor(&E, handleSigWinCh);
  // E.syntax = s;
  E.syntax = editorSelectSyntaxHighlight(argv[1]);
  editorOpen(&E, argv[1]);
  enableRawMode(editorAtExit);
  editorSetStatusMessage(&E,
                         "HELP: Ctrl-S = save | Ctrl-Q = quit | Ctrl-F = find");
  while (1) {
    editorRefreshScreen(&E);
    for (auto input : getInput()) {
      editorProcessKeypress(&E, input);
    }
  }

  return 0;
}
