/* Kilo -- A very simple editor in less than 1-kilo lines of code (as counted
 *         by "cloc"). Does not depend on libcurses, directly emits VT100
 *         escapes on the terminal.
 *
 * -----------------------------------------------------------------------
 *
 * Copyright (C) 2016 Salvatore Sanfilippo <antirez at gmail dot com>
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *  *  Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *  *  Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define KILO_VERSION "0.0.1"

#ifdef __linux__
#define _POSIX_C_SOURCE 200809L
#endif

#include "kilo.h"
#include "ipty.h"
#include "key_action.h"
#include "kilo_highlight.h"
#include <fcntl.h>
#include <fstream>
#include <signal.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <sys/types.h>
#ifdef _MSC_VER
#include <io.h>
#else
#include <sys/time.h>
#include <unistd.h>
#endif

/* ======================= Editor rows implementation ======================= */

/* Update the rendered version and the syntax highlight of a row. */
static void editorUpdateRow(editorConfig *E, erow *row) {
  unsigned int tabs = 0, nonprint = 0;
  int j, idx;

  /* Create a version of the row we can directly print on the screen,
   * respecting tabs, substituting non printable characters with '?'. */
  free(row->render);
  for (j = 0; j < row->size; j++)
    if (row->chars[j] == TAB)
      tabs++;

  unsigned long long allocsize =
      (unsigned long long)row->size + tabs * 8 + nonprint * 9 + 1;
  if (allocsize > UINT32_MAX) {
    printf("Some line of the edited file is too long for kilo\n");
    exit(1);
  }

  row->render = (char *)malloc(row->size + tabs * 8 + nonprint * 9 + 1);
  idx = 0;
  for (j = 0; j < row->size; j++) {
    if (row->chars[j] == TAB) {
      row->render[idx++] = ' ';
      while ((idx + 1) % 8 != 0)
        row->render[idx++] = ' ';
    } else {
      row->render[idx++] = row->chars[j];
    }
  }
  row->rsize = idx;
  row->render[idx] = '\0';

  /* Update the syntax highlighting attributes of the row. */
  editorUpdateSyntax(E, row);
}

/* Insert a row at the specified position, shifting the other rows on the bottom
 * if required. */
static void editorInsertRow(editorConfig *E, int at, const char *s,
                            size_t len) {
  if (at > E->numrows)
    return;
  E->row = (erow *)realloc(E->row, sizeof(erow) * (E->numrows + 1));
  if (at != E->numrows) {
    memmove(E->row + at + 1, E->row + at,
            sizeof(E->row[0]) * (E->numrows - at));
    for (int j = at + 1; j <= E->numrows; j++)
      E->row[j].idx++;
  }
  E->row[at].size = len;
  E->row[at].chars = (char *)malloc(len + 1);
  memcpy(E->row[at].chars, s, len + 1);
  E->row[at].hl = NULL;
  E->row[at].hl_oc = 0;
  E->row[at].render = NULL;
  E->row[at].rsize = 0;
  E->row[at].idx = at;
  editorUpdateRow(E, E->row + at);
  E->numrows++;
  E->dirty++;
}

/* Free row's heap allocated stuff. */
void editorFreeRow(erow *row) {
  free(row->render);
  free(row->chars);
  free(row->hl);
}

/* Remove the row at the specified position, shifting the remainign on the
 * top. */
static void editorDelRow(editorConfig *E, int at) {
  if (at >= E->numrows)
    return;
  auto row = E->row + at;
  editorFreeRow(row);
  memmove(E->row + at, E->row + at + 1,
          sizeof(E->row[0]) * (E->numrows - at - 1));
  for (int j = at; j < E->numrows - 1; j++)
    E->row[j].idx++;
  E->numrows--;
  E->dirty++;
}

/* Turn the editor rows into a single heap-allocated string.
 * Returns the pointer to the heap-allocated string and populate the
 * integer pointed by 'buflen' with the size of the string, escluding
 * the final nulterm. */
static char *editorRowsToString(editorConfig *E, int *buflen) {

  /* Compute count of bytes */
  int totlen = 0;
  for (int j = 0; j < E->numrows; j++)
    totlen += E->row[j].size + 1; /* +1 is for "\n" at end of every row */
  *buflen = totlen;
  totlen++; /* Also make space for nulterm */

  auto buf = (char *)malloc(totlen);
  auto p = buf;
  for (int j = 0; j < E->numrows; j++) {
    memcpy(p, E->row[j].chars, E->row[j].size);
    p += E->row[j].size;
    *p = '\n';
    p++;
  }
  *p = '\0';
  return buf;
}

/* Insert a character at the specified position in a row, moving the remaining
 * chars on the right if needed. */
void editorRowInsertChar(editorConfig *E, erow *row, int at, int c) {
  if (at > row->size) {
    /* Pad the string with spaces if the insert location is outside the
     * current length by more than a single character. */
    int padlen = at - row->size;
    /* In the next line +2 means: new char and null term. */
    row->chars = (char *)realloc(row->chars, row->size + padlen + 2);
    memset(row->chars + row->size, ' ', padlen);
    row->chars[row->size + padlen + 1] = '\0';
    row->size += padlen + 1;
  } else {
    /* If we are in the middle of the string just make space for 1 new
     * char plus the (already existing) null term. */
    row->chars = (char *)realloc(row->chars, row->size + 2);
    memmove(row->chars + at + 1, row->chars + at, row->size - at + 1);
    row->size++;
  }
  row->chars[at] = c;
  editorUpdateRow(E, row);
  E->dirty++;
}

/* Append the string 's' at the end of a row */
void editorRowAppendString(editorConfig *E, erow *row, char *s, size_t len) {
  row->chars = (char *)realloc(row->chars, row->size + len + 1);
  memcpy(row->chars + row->size, s, len);
  row->size += len;
  row->chars[row->size] = '\0';
  editorUpdateRow(E, row);
  E->dirty++;
}

/* Delete the character at offset 'at' from the specified row. */
void editorRowDelChar(editorConfig *E, erow *row, int at) {
  if (row->size <= at)
    return;
  memmove(row->chars + at, row->chars + at + 1, row->size - at);
  editorUpdateRow(E, row);
  row->size--;
  E->dirty++;
}

/* Insert the specified char at the current prompt position. */
void editorInsertChar(editorConfig *E, int c) {
  int filerow = E->rowoff + E->cy;
  int filecol = E->coloff + E->cx;
  erow *row = (filerow >= E->numrows) ? NULL : &E->row[filerow];

  /* If the row where the cursor is currently located does not exist in our
   * logical representaion of the file, add enough empty rows as needed. */
  if (!row) {
    while (E->numrows <= filerow)
      editorInsertRow(E, E->numrows, "", 0);
  }
  row = &E->row[filerow];
  editorRowInsertChar(E, row, filecol, c);
  if (E->cx == E->screencols - 1)
    E->coloff++;
  else
    E->cx++;
  E->dirty++;
}

/* Inserting a newline is slightly complex as we have to handle inserting a
 * newline in the middle of a line, splitting the line as needed. */
void editorInsertNewline(editorConfig *E) {
  int filerow = E->rowoff + E->cy;
  int filecol = E->coloff + E->cx;
  erow *row = (filerow >= E->numrows) ? NULL : &E->row[filerow];

  if (!row) {
    if (filerow == E->numrows) {
      editorInsertRow(E, filerow, "", 0);
      goto fixcursor;
    }
    return;
  }
  /* If the cursor is over the current line size, we want to conceptually
   * think it's just over the last character. */
  if (filecol >= row->size)
    filecol = row->size;
  if (filecol == 0) {
    editorInsertRow(E, filerow, "", 0);
  } else {
    /* We are in the middle of a line. Split it between two rows. */
    editorInsertRow(E, filerow + 1, row->chars + filecol, row->size - filecol);
    row = &E->row[filerow];
    row->chars[filecol] = '\0';
    row->size = filecol;
    editorUpdateRow(E, row);
  }
fixcursor:
  if (E->cy == E->screenrows - 1) {
    E->rowoff++;
  } else {
    E->cy++;
  }
  E->cx = 0;
  E->coloff = 0;
}

/* Delete the char at the current prompt position. */
void editorDelChar(editorConfig *E) {
  int filerow = E->rowoff + E->cy;
  int filecol = E->coloff + E->cx;
  erow *row = (filerow >= E->numrows) ? NULL : &E->row[filerow];

  if (!row || (filecol == 0 && filerow == 0))
    return;
  if (filecol == 0) {
    /* Handle the case of column 0, we need to move the current line
     * on the right of the previous one. */
    filecol = E->row[filerow - 1].size;
    editorRowAppendString(E, &E->row[filerow - 1], row->chars, row->size);
    editorDelRow(E, filerow);
    row = NULL;
    if (E->cy == 0)
      E->rowoff--;
    else
      E->cy--;
    E->cx = filecol;
    if (E->cx >= E->screencols) {
      int shift = (E->screencols - E->cx) + 1;
      E->cx -= shift;
      E->coloff += shift;
    }
  } else {
    editorRowDelChar(E, row, filecol - 1);
    if (E->cx == 0 && E->coloff)
      E->coloff--;
    else
      E->cx--;
  }
  if (row)
    editorUpdateRow(E, row);
  E->dirty++;
}

/* Load the specified program in the editor memory and returns 0 on success
 * or 1 on error. */
int editorOpen(editorConfig *E, const char *filename) {

  E->dirty = 0;
  E->filename = filename;

  std::ifstream f(filename, std::ios::binary);
  if (!f) {
    // if (errno != ENOENT) {
    //   perror("Opening file");
    //   exit(1);
    // }
    return 1;
  }

  size_t linecap = 0;
  std::string line;
  while (std::getline(f, line)) {
    // if (linelen && (line[linelen - 1] == '\n' || line[linelen - 1] == '\r'))
    //   line[--linelen] = '\0';
    editorInsertRow(E, E->numrows, line.c_str(), line.size());
  }
  E->dirty = 0;
  return 0;
}

/* Save the current file on disk. Return 0 on success, 1 on error. */
int editorSave(editorConfig *E) {
  int len;
  char *buf = editorRowsToString(E, &len);
  int fd = open(E->filename.c_str(), O_RDWR | O_CREAT, 0644);
  if (fd == -1)
    goto writeerr;

  /* Use truncate + a single write(2) call in order to make saving
   * a bit safer, under the limits of what we can do in a small editor. */
  // if (ftruncate(fd, len) == -1)
  //   goto writeerr;
  if (write(fd, buf, len) != len)
    goto writeerr;

  close(fd);
  free(buf);
  E->dirty = 0;
  editorSetStatusMessage(E, "%d bytes written on disk", len);
  return 0;

writeerr:
  free(buf);
  if (fd != -1)
    close(fd);
  editorSetStatusMessage(E, "Can't save! I/O" /* error: %s", strerror(errno)*/);
  return 1;
}

/* ============================= Terminal update ============================ */

/* We define a very simple "append buffer" structure, that is an heap
 * allocated string where we can append to. This is useful in order to
 * write all the escape sequences in a buffer and flush them to the standard
 * output in a single call, to avoid flickering effects. */
struct abuf {
  char *b;
  int len;
};

#define ABUF_INIT                                                              \
  { NULL, 0 }

void abAppend(struct abuf *ab, const char *s, int len) {
  char *newstr = (char *)realloc(ab->b, ab->len + len);

  if (newstr == NULL)
    return;
  memcpy(newstr + ab->len, s, len);
  ab->b = newstr;
  ab->len += len;
}

void abFree(struct abuf *ab) { free(ab->b); }

/* This function writes the whole screen using VT100 escape characters
 * starting from the logical state of the editor in the global state 'E'. */
void editorRefreshScreen(editorConfig *E) {
  int y;
  erow *r;
  char buf[32];
  struct abuf ab = ABUF_INIT;

  abAppend(&ab, "\x1b[?25l", 6); /* Hide cursor. */
  abAppend(&ab, "\x1b[H", 3);    /* Go home. */
  for (y = 0; y < E->screenrows; y++) {
    int filerow = E->rowoff + y;

    if (filerow >= E->numrows) {
      if (E->numrows == 0 && y == E->screenrows / 3) {
        char welcome[80];
        int welcomelen =
            snprintf(welcome, sizeof(welcome),
                     "Kilo editor -- verison %s\x1b[0K\r\n", KILO_VERSION);
        int padding = (E->screencols - welcomelen) / 2;
        if (padding) {
          abAppend(&ab, "~", 1);
          padding--;
        }
        while (padding--)
          abAppend(&ab, " ", 1);
        abAppend(&ab, welcome, welcomelen);
      } else {
        abAppend(&ab, "~\x1b[0K\r\n", 7);
      }
      continue;
    }

    r = &E->row[filerow];

    int len = r->rsize - E->coloff;
    int current_color = -1;
    if (len > 0) {
      if (len > E->screencols)
        len = E->screencols;
      char *c = r->render + E->coloff;
      unsigned char *hl = r->hl + E->coloff;
      int j;
      for (j = 0; j < len; j++) {
        if (hl[j] == HL_NONPRINT) {
          char sym;
          abAppend(&ab, "\x1b[7m", 4);
          if (c[j] <= 26)
            sym = '@' + c[j];
          else
            sym = '?';
          abAppend(&ab, &sym, 1);
          abAppend(&ab, "\x1b[0m", 4);
        } else if (hl[j] == HL_NORMAL) {
          if (current_color != -1) {
            abAppend(&ab, "\x1b[39m", 5);
            current_color = -1;
          }
          abAppend(&ab, c + j, 1);
        } else {
          int color = editorSyntaxToColor(hl[j]);
          if (color != current_color) {
            char buf[16];
            int clen = snprintf(buf, sizeof(buf), "\x1b[%dm", color);
            current_color = color;
            abAppend(&ab, buf, clen);
          }
          abAppend(&ab, c + j, 1);
        }
      }
    }
    abAppend(&ab, "\x1b[39m", 5);
    abAppend(&ab, "\x1b[0K", 4);
    abAppend(&ab, "\r\n", 2);
  }

  /* Create a two rows status. First row: */
  abAppend(&ab, "\x1b[0K", 4);
  abAppend(&ab, "\x1b[7m", 4);
  char status[80], rstatus[80];
  int len =
      snprintf(status, sizeof(status), "%.20s - %d lines %s",
               E->filename.c_str(), E->numrows, E->dirty ? "(modified)" : "");
  int rlen = snprintf(rstatus, sizeof(rstatus), "%d/%d", E->rowoff + E->cy + 1,
                      E->numrows);
  if (len > E->screencols)
    len = E->screencols;
  abAppend(&ab, status, len);
  while (len < E->screencols) {
    if (E->screencols - len == rlen) {
      abAppend(&ab, rstatus, rlen);
      break;
    } else {
      abAppend(&ab, " ", 1);
      len++;
    }
  }
  abAppend(&ab, "\x1b[0m\r\n", 6);

  /* Second row depends on E->statusmsg and the status message update time. */
  abAppend(&ab, "\x1b[0K", 4);
  int msglen = strlen(E->statusmsg);
  if (msglen && time(NULL) - E->statusmsg_time < 5)
    abAppend(&ab, E->statusmsg,
             msglen <= E->screencols ? msglen : E->screencols);

  /* Put cursor at its current position. Note that the horizontal position
   * at which the cursor is displayed may be different compared to 'E->cx'
   * because of TABs. */
  int j;
  int cx = 1;
  int filerow = E->rowoff + E->cy;
  erow *row = (filerow >= E->numrows) ? NULL : &E->row[filerow];
  if (row) {
    for (j = E->coloff; j < (E->cx + E->coloff); j++) {
      if (j < row->size && row->chars[j] == TAB)
        cx += 7 - ((cx) % 8);
      cx++;
    }
  }
  snprintf(buf, sizeof(buf), "\x1b[%d;%dH", E->cy + 1, cx);
  abAppend(&ab, buf, strlen(buf));
  abAppend(&ab, "\x1b[?25h", 6); /* Show cursor. */
  write(1, ab.b, ab.len);
  abFree(&ab);
}

/* Set an editor status message for the second line of the status, at the
 * end of the screen. */
void editorSetStatusMessage(editorConfig *E, const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  vsnprintf(E->statusmsg, sizeof(E->statusmsg), fmt, ap);
  va_end(ap);
  E->statusmsg_time = time(NULL);
}

/* ========================= Editor events handling  ======================== */

/* Handle cursor position change because arrow keys were pressed. */
void editorMoveCursor(editorConfig *E, int key) {
  int filerow = E->rowoff + E->cy;
  int filecol = E->coloff + E->cx;
  int rowlen;
  erow *row = (filerow >= E->numrows) ? NULL : &E->row[filerow];

  switch (key) {
  case ARROW_LEFT:
    if (E->cx == 0) {
      if (E->coloff) {
        E->coloff--;
      } else {
        if (filerow > 0) {
          E->cy--;
          E->cx = E->row[filerow - 1].size;
          if (E->cx > E->screencols - 1) {
            E->coloff = E->cx - E->screencols + 1;
            E->cx = E->screencols - 1;
          }
        }
      }
    } else {
      E->cx -= 1;
    }
    break;
  case ARROW_RIGHT:
    if (row && filecol < row->size) {
      if (E->cx == E->screencols - 1) {
        E->coloff++;
      } else {
        E->cx += 1;
      }
    } else if (row && filecol == row->size) {
      E->cx = 0;
      E->coloff = 0;
      if (E->cy == E->screenrows - 1) {
        E->rowoff++;
      } else {
        E->cy += 1;
      }
    }
    break;
  case ARROW_UP:
    if (E->cy == 0) {
      if (E->rowoff)
        E->rowoff--;
    } else {
      E->cy -= 1;
    }
    break;
  case ARROW_DOWN:
    if (filerow < E->numrows) {
      if (E->cy == E->screenrows - 1) {
        E->rowoff++;
      } else {
        E->cy += 1;
      }
    }
    break;
  }
  /* Fix cx if the current line has not enough chars. */
  filerow = E->rowoff + E->cy;
  filecol = E->coloff + E->cx;
  row = (filerow >= E->numrows) ? NULL : &E->row[filerow];
  rowlen = row ? row->size : 0;
  if (filecol > rowlen) {
    E->cx -= filecol - rowlen;
    if (E->cx < 0) {
      E->coloff += E->cx;
      E->cx = 0;
    }
  }
}

int editorFileWasModified(editorConfig *E) { return E->dirty; }

void updateWindowSize(editorConfig *E) {
  if (!getWindowSize(&E->screenrows, &E->screencols)) {
    perror("Unable to query the screen for size (columns / rows)");
    exit(1);
  }
  E->screenrows -= 2; /* Get room for status bar. */
}

void initEditor(editorConfig *E, SignalHandler onWinCh) {
  updateWindowSize(E);
#ifdef _MSC_VER
#else
  signal(SIGWINCH, onWinCh);
#endif
}
