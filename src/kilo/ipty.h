#pragma once
#include <vector>

using AtExitFunc = void (*)(void);
using KeyHandler = bool (*)(int);

int enableRawMode(AtExitFunc atExit);
void disableRawMode();
bool getWindowSize(int *rows, int *cols);

std::vector<int> getInput();
