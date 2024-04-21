#pragma once

void initEditor(void);
void editorSelectSyntaxHighlight(const char *filename);
int editorOpen(const char *filename);
int enableRawMode(int fd);
void editorSetStatusMessage(const char *fmt, ...);
void editorRefreshScreen(void);
void editorProcessKeypress(int fd);
