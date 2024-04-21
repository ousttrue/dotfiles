#pragma once

using AtExitFunc = void (*)(void);
int enableRawMode(int fd, AtExitFunc atExit);
void disableRawMode(int fd);

int getWindowSize(int ifd, int ofd, int *rows, int *cols);
