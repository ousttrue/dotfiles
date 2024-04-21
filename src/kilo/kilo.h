#pragma once
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
  int cx = 0;
  // Cursor y
  int cy = 0;
  // Offset of row displayed.
  int rowoff = 0;
  // Offset of column displayed.
  int coloff = 0;
  // Number of rows that we can show
  int screenrows;
  // Number of cols that we can show
  int screencols;
  // Number of rows
  int numrows = 0;
  // Rows
  erow *row = nullptr;
  // File modified but not saved.
  int dirty = 0;
  // Currently open filename
  char *filename = nullptr;
  char statusmsg[80];
  time_t statusmsg_time;
  // Current syntax highlight, or NULL.
  struct editorSyntax *syntax = nullptr;
};

using SignalHandler = void (*)(int);
void initEditor(editorConfig *E, SignalHandler onWinCh);
int editorOpen(editorConfig *E, const char *filename);
void editorSetStatusMessage(editorConfig *E, const char *fmt, ...);
void editorRefreshScreen(editorConfig *E);
void updateWindowSize(editorConfig *E);
void editorInsertNewline(editorConfig *E);
int editorSave(editorConfig *E);
void editorDelChar(editorConfig *E);
void editorMoveCursor(editorConfig *E, int key);
void editorInsertChar(editorConfig *E, int c);
