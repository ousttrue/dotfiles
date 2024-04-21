#include "ipty.h"
#include "key_action.h"
#include "kilo.h"
#include "kilo_highlight.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if _MSC_VER
#include <io.h>
#else
#include <unistd.h> // STDIN_FILENO
#endif

/* Called at exit to avoid remaining in raw mode. */
static void editorAtExit(void) { disableRawMode(); }

struct editorConfig E;

void handleSigWinCh(int) {
  updateWindowSize(&E);
  if (E.cy > E.screenrows)
    E.cy = E.screenrows - 1;
  if (E.cx > E.screencols)
    E.cx = E.screencols - 1;
  editorRefreshScreen(&E);
}

#define KILO_QUERY_LEN 256

void editorFind(editorConfig *E) {
  char query[KILO_QUERY_LEN + 1] = {0};
  int qlen = 0;
  int last_match = -1;    /* Last line where a match was found. -1 for none. */
  int find_next = 0;      /* if 1 search next, if -1 search prev. */
  int saved_hl_line = -1; /* No saved HL */
  char *saved_hl = NULL;

#define FIND_RESTORE_HL                                                        \
  do {                                                                         \
    if (saved_hl) {                                                            \
      memcpy(E->row[saved_hl_line].hl, saved_hl, E->row[saved_hl_line].rsize); \
      free(saved_hl);                                                          \
      saved_hl = NULL;                                                         \
    }                                                                          \
  } while (0)

  /* Save the cursor position in order to restore it later. */
  int saved_cx = E->cx, saved_cy = E->cy;
  int saved_coloff = E->coloff, saved_rowoff = E->rowoff;

  while (1) {
    editorSetStatusMessage(E, "Search: %s (Use ESC/Arrows/Enter)", query);
    editorRefreshScreen(E);

    for (auto c : getInput()) {
      if (c == DEL_KEY || c == CTRL_H || c == BACKSPACE) {
        if (qlen != 0)
          query[--qlen] = '\0';
        last_match = -1;
      } else if (c == ESC || c == ENTER) {
        if (c == ESC) {
          E->cx = saved_cx;
          E->cy = saved_cy;
          E->coloff = saved_coloff;
          E->rowoff = saved_rowoff;
        }
        FIND_RESTORE_HL;
        editorSetStatusMessage(E, "");
        return;
      } else if (c == ARROW_RIGHT || c == ARROW_DOWN) {
        find_next = 1;
      } else if (c == ARROW_LEFT || c == ARROW_UP) {
        find_next = -1;
      } else if (isprint(c)) {
        if (qlen < KILO_QUERY_LEN) {
          query[qlen++] = c;
          query[qlen] = '\0';
          last_match = -1;
        }
      }

      /* Search occurrence. */
      if (last_match == -1)
        find_next = 1;
      if (find_next) {
        char *match = NULL;
        int match_offset = 0;
        int i, current = last_match;

        for (i = 0; i < E->numrows; i++) {
          current += find_next;
          if (current == -1)
            current = E->numrows - 1;
          else if (current == E->numrows)
            current = 0;
          match = strstr(E->row[current].render, query);
          if (match) {
            match_offset = match - E->row[current].render;
            break;
          }
        }
        find_next = 0;

        /* Highlight */
        FIND_RESTORE_HL;

        if (match) {
          erow *row = &E->row[current];
          last_match = current;
          if (row->hl) {
            saved_hl_line = current;
            saved_hl = (char *)malloc(row->rsize);
            memcpy(saved_hl, row->hl, row->rsize);
            memset(row->hl + match_offset, HL_MATCH, qlen);
          }
          E->cy = 0;
          E->cx = match_offset;
          E->rowoff = current;
          E->coloff = 0;
          /* Scroll horizontally as needed. */
          if (E->cx > E->screencols) {
            int diff = E->cx - E->screencols;
            E->cx -= diff;
            E->coloff += diff;
          }
        }
      }
    }
  }
}

/* Process events arriving from the standard input, which is, the user
 * is typing stuff on the terminal. */
#define KILO_QUIT_TIMES 3
void editorProcessKeypress(editorConfig *E, int c) {
  /* When the file is modified, requires Ctrl-q to be pressed N times
   * before actually quitting. */
  static int quit_times = KILO_QUIT_TIMES;

  switch (c) {
  case ENTER: /* Enter */
    editorInsertNewline(E);
    break;
  case CTRL_C: /* Ctrl-c */
    /* We ignore ctrl-c, it can't be so simple to lose the changes
     * to the edited file. */
    break;
  case CTRL_Q: /* Ctrl-q */
    /* Quit if the file was already saved. */
    if (E->dirty && quit_times) {
      editorSetStatusMessage(E,
                             "WARNING!!! File has unsaved changes. "
                             "Press Ctrl-Q %d more times to quit.",
                             quit_times);
      quit_times--;
      return;
    }
    exit(0);
    break;
  case CTRL_S: /* Ctrl-s */
    editorSave(E);
    break;
  case CTRL_F:
    editorFind(E);
    break;
  case BACKSPACE: /* Backspace */
  case CTRL_H:    /* Ctrl-h */
  case DEL_KEY:
    editorDelChar(E);
    break;
  case PAGE_UP:
  case PAGE_DOWN:
    if (c == PAGE_UP && E->cy != 0)
      E->cy = 0;
    else if (c == PAGE_DOWN && E->cy != E->screenrows - 1)
      E->cy = E->screenrows - 1;
    {
      int times = E->screenrows;
      while (times--)
        editorMoveCursor(E, c == PAGE_UP ? ARROW_UP : ARROW_DOWN);
    }
    break;

  case ARROW_UP:
  case ARROW_DOWN:
  case ARROW_LEFT:
  case ARROW_RIGHT:
    editorMoveCursor(E, c);
    break;
  case CTRL_L: /* ctrl+l, clear screen */
    /* Just refresht the line as side effect. */
    break;
  case ESC:
    /* Nothing to do for ESC in this mode. */
    break;
  default:
    editorInsertChar(E, c);
    break;
  }

  quit_times = KILO_QUIT_TIMES; /* Reset it to the original value. */
}

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
