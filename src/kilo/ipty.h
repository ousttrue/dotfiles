#pragma once

#ifdef __cplusplus
extern "C" {
#endif

typedef void (*AtExitFunc)(void);
typedef int (*KeyHandler)(int);

int enableRawMode(AtExitFunc atExit);
void disableRawMode();
int getWindowSize(int *rows, int *cols);

int getInput();

#ifdef __cplusplus
}
#endif
