#pragma once

#ifdef __cplusplus
extern "C" {
#endif

struct hlcolor {
  int r, g, b;
};

// Syntax highlight types
enum KiloHighliht {
  HL_NORMAL = 0,
  HL_NONPRINT = 1,
  // Single line comment.
  HL_COMMENT = 2,
  // Multi-line comment.
  HL_MLCOMMENT = 3,
  HL_KEYWORD1 = 4,
  HL_KEYWORD2 = 5,
  HL_STRING = 6,
  HL_NUMBER = 7,
  // Search match.
  HL_MATCH = 8,
  HL_HIGHLIGHT_STRINGS = (1 << 0),
  HL_HIGHLIGHT_NUMBERS = (1 << 1),
};

struct editorSyntax {
  const char **filematch;
  const char **keywords;
  char singleline_comment_start[2];
  char multiline_comment_start[3];
  char multiline_comment_end[3];
  int flags;
};

struct editorConfig;
struct editorSyntax *editorSelectSyntaxHighlight(const char *filename);
void editorUpdateSyntax(struct editorConfig *E, struct erow *row);
int editorSyntaxToColor(int hl);

#ifdef __cplusplus
}
#endif
