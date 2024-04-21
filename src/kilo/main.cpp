#include "ipty.h"
#include "kilo.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // STDIN_FILENO
                    //
/* Called at exit to avoid remaining in raw mode. */
static void editorAtExit(void) { disableRawMode(STDIN_FILENO); }

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "Usage: kilo <filename>\n");
    exit(1);
  }

  initEditor();
  editorSelectSyntaxHighlight(argv[1]);
  editorOpen(argv[1]);
  enableRawMode(STDIN_FILENO, editorAtExit);
  editorSetStatusMessage("HELP: Ctrl-S = save | Ctrl-Q = quit | Ctrl-F = find");
  while (1) {
    editorRefreshScreen();
    editorProcessKeypress(STDIN_FILENO);
  }

  return 0;
}
