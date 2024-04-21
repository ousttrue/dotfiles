#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <time.h>

/* This structure represents a single line of the file we are editing. */
struct erow {
  int idx;           /* Row index in the file, zero-based. */
  int size;          /* Size of the row, excluding the null term. */
  int rsize;         /* Size of the rendered row. */
  char *chars;       /* Row content. */
  char *render;      /* Row content "rendered" for screen (for TABs). */
  unsigned char *hl; /* Syntax highlight type for each character in render.*/
  int hl_oc;         /* Row had open comment at end in last syntax highlight
                        check. */
};

struct editorConfig {
  // Cursor x
  int cx;
  // Cursor y
  int cy;
  // Offset of row displayed.
  int rowoff;
  // Offset of column displayed.
  int coloff;
  // Number of rows that we can show
  int screenrows;
  // Number of cols that we can show
  int screencols;
  // Number of rows
  int numrows;
  // Rows
  struct erow *row;
  // File modified but not saved.
  int dirty;
  // Currently open filename
  char filename[256];
  char statusmsg[80];
  time_t statusmsg_time;
  // Current syntax highlight, or NULL.
  struct editorSyntax *syntax;
};

typedef void (*SignalHandler)(int);
void initEditor(struct editorConfig *E, SignalHandler onWinCh);
int editorOpen(struct editorConfig *E, const char *filename);
void editorSetStatusMessage(struct editorConfig *E, const char *fmt, ...);
void editorRefreshScreen(struct editorConfig *E);
void updateWindowSize(struct editorConfig *E);
void editorInsertNewline(struct editorConfig *E);
int editorSave(struct editorConfig *E);
void editorDelChar(struct editorConfig *E);
void editorMoveCursor(struct editorConfig *E, int key);
void editorInsertChar(struct editorConfig *E, int c);
void editorProcessKeypress(struct editorConfig *E, int c);

#ifdef __cplusplus
}
#endif
