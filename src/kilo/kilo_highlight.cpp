#include "kilo_highlight.h"
#include "kilo.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* =========================== Syntax highlights DB =========================
 *
 * In order to add a new syntax, define two arrays with a list of file name
 * matches and keywords. The file name matches are used in order to match
 * a given syntax with a given file name: if a match pattern starts with a
 * dot, it is matched as the last past of the filename, for example ".c".
 * Otherwise the pattern is just searched inside the filenme, like "Makefile").
 *
 * The list of keywords to highlight is just a list of words, however if they
 * a trailing '|' character is added at the end, they are highlighted in
 * a different color, so that you can have two different sets of keywords.
 *
 * Finally add a stanza in the HLDB global variable with two two arrays
 * of strings, and a set of flags in order to enable highlighting of
 * comments and numbers.
 *
 * The characters for single and multi line comments must be exactly two
 * and must be provided as well (see the C language example).
 *
 * There is no support to highlight patterns currently. */

/* C / C++ */
const char *C_HL_extensions[] = {".c", ".h", ".cpp", ".hpp", ".cc", nullptr};
const char *C_HL_keywords[] = {
    /* C Keywords */
    "auto", "break", "case", "continue", "default", "do", "else", "enum",
    "extern", "for", "goto", "if", "register", "return", "sizeof", "static",
    "struct", "switch", "typedef", "union", "volatile", "while", "NULL",

    /* C++ Keywords */
    "alignas", "alignof", "and", "and_eq", "asm", "bitand", "bitor", "class",
    "compl", "constexpr", "const_cast", "deltype", "delete", "dynamic_cast",
    "explicit", "export", "false", "friend", "inline", "mutable", "namespace",
    "new", "noexcept", "not", "not_eq", "nullptr", "operator", "or", "or_eq",
    "private", "protected", "public", "reinterpret_cast", "static_assert",
    "static_cast", "template", "this", "thread_local", "throw", "true", "try",
    "typeid", "typename", "virtual", "xor", "xor_eq",

    /* C types */
    "int|", "long|", "double|", "float|", "char|", "unsigned|", "signed|",
    "void|", "short|", "auto|", "const|", "bool|", nullptr};

/* Here we define an array of syntax highlights by extensions, keywords,
 * comments delimiters and flags. */
struct editorSyntax HLDB[] = {{/* C / C++ */
                               C_HL_extensions,
                               C_HL_keywords,
                               {'/', '/'},
                               "/*",
                               "*/",
                               HL_HIGHLIGHT_STRINGS | HL_HIGHLIGHT_NUMBERS}};

#define HLDB_ENTRIES (sizeof(HLDB) / sizeof(HLDB[0]))

/* Select the syntax highlight scheme depending on the filename,
 * setting it in the global state E.syntax. */
editorSyntax *editorSelectSyntaxHighlight(const char *filename) {
  for (unsigned int j = 0; j < HLDB_ENTRIES; j++) {
    editorSyntax *s = HLDB + j;
    unsigned int i = 0;
    while (s->filematch[i]) {
      int patlen = strlen(s->filematch[i]);
      if (auto p = strstr(filename, s->filematch[i])) {
        if (s->filematch[i][0] != '.' || p[patlen] == '\0') {
          return s;
        }
      }
      i++;
    }
  }
  return nullptr;
}

/* ====================== Syntax highlight color scheme  ==================== */

/* Return true if the specified row last char is part of a multi line comment
 * that starts at this row or at one before, and does not end at the end
 * of the row but spawns to the next row. */
int editorRowHasOpenComment(erow *row) {
  if (row->hl && row->rsize && row->hl[row->rsize - 1] == HL_MLCOMMENT &&
      (row->rsize < 2 || (row->render[row->rsize - 2] != '*' ||
                          row->render[row->rsize - 1] != '/')))
    return 1;
  return 0;
}

/* Maps syntax highlight token types to terminal colors. */
int editorSyntaxToColor(int hl) {
  switch (hl) {
  case HL_COMMENT:
  case HL_MLCOMMENT:
    return 36; /* cyan */
  case HL_KEYWORD1:
    return 33; /* yellow */
  case HL_KEYWORD2:
    return 32; /* green */
  case HL_STRING:
    return 35; /* magenta */
  case HL_NUMBER:
    return 31; /* red */
  case HL_MATCH:
    return 34; /* blu */
  default:
    return 37; /* white */
  }
}
static int is_separator(int c) {
  return c == '\0' || isspace(c) || strchr(",.()+-/*=~%[];", c) != NULL;
}

/* Set every byte of row->hl (that corresponds to every character in the line)
 * to the right syntax highlight type (HL_* defines). */
void editorUpdateSyntax(editorConfig *E, erow *row) {
  row->hl = (unsigned char *)realloc(row->hl, row->rsize);
  memset(row->hl, HL_NORMAL, row->rsize);

  if (E->syntax == NULL)
    return; /* No syntax, everything is HL_NORMAL. */

  int i, prev_sep, in_string, in_comment;
  char *p;
  const char **keywords = E->syntax->keywords;
  char *scs = E->syntax->singleline_comment_start;
  char *mcs = E->syntax->multiline_comment_start;
  char *mce = E->syntax->multiline_comment_end;

  /* Point to the first non-space char. */
  p = row->render;
  i = 0; /* Current char offset */
  while (*p && isspace(*p)) {
    p++;
    i++;
  }
  prev_sep = 1;   /* Tell the parser if 'i' points to start of word. */
  in_string = 0;  /* Are we inside "" or '' ? */
  in_comment = 0; /* Are we inside multi-line comment? */

  /* If the previous line has an open comment, this line starts
   * with an open comment state. */
  if (row->idx > 0 && editorRowHasOpenComment(&E->row[row->idx - 1]))
    in_comment = 1;

  while (*p) {
    /* Handle // comments. */
    if (prev_sep && *p == scs[0] && *(p + 1) == scs[1]) {
      /* From here to end is a comment */
      memset(row->hl + i, HL_COMMENT, row->size - i);
      return;
    }

    /* Handle multi line comments. */
    if (in_comment) {
      row->hl[i] = HL_MLCOMMENT;
      if (*p == mce[0] && *(p + 1) == mce[1]) {
        row->hl[i + 1] = HL_MLCOMMENT;
        p += 2;
        i += 2;
        in_comment = 0;
        prev_sep = 1;
        continue;
      } else {
        prev_sep = 0;
        p++;
        i++;
        continue;
      }
    } else if (*p == mcs[0] && *(p + 1) == mcs[1]) {
      row->hl[i] = HL_MLCOMMENT;
      row->hl[i + 1] = HL_MLCOMMENT;
      p += 2;
      i += 2;
      in_comment = 1;
      prev_sep = 0;
      continue;
    }

    /* Handle "" and '' */
    if (in_string) {
      row->hl[i] = HL_STRING;
      if (*p == '\\') {
        row->hl[i + 1] = HL_STRING;
        p += 2;
        i += 2;
        prev_sep = 0;
        continue;
      }
      if (*p == in_string)
        in_string = 0;
      p++;
      i++;
      continue;
    } else {
      if (*p == '"' || *p == '\'') {
        in_string = *p;
        row->hl[i] = HL_STRING;
        p++;
        i++;
        prev_sep = 0;
        continue;
      }
    }

    /* Handle non printable chars. */
    if (!isprint(*p)) {
      row->hl[i] = HL_NONPRINT;
      p++;
      i++;
      prev_sep = 0;
      continue;
    }

    /* Handle numbers */
    if ((isdigit(*p) && (prev_sep || row->hl[i - 1] == HL_NUMBER)) ||
        (*p == '.' && i > 0 && row->hl[i - 1] == HL_NUMBER)) {
      row->hl[i] = HL_NUMBER;
      p++;
      i++;
      prev_sep = 0;
      continue;
    }

    /* Handle keywords and lib calls */
    if (prev_sep) {
      int j;
      for (j = 0; keywords[j]; j++) {
        int klen = strlen(keywords[j]);
        int kw2 = keywords[j][klen - 1] == '|';
        if (kw2)
          klen--;

        if (!memcmp(p, keywords[j], klen) && is_separator(*(p + klen))) {
          /* Keyword */
          memset(row->hl + i, kw2 ? HL_KEYWORD2 : HL_KEYWORD1, klen);
          p += klen;
          i += klen;
          break;
        }
      }
      if (keywords[j] != NULL) {
        prev_sep = 0;
        continue; /* We had a keyword match */
      }
    }

    /* Not special chars */
    prev_sep = is_separator(*p);
    p++;
    i++;
  }

  /* Propagate syntax change to the next row if the open commen
   * state changed. This may recursively affect all the following rows
   * in the file. */
  int oc = editorRowHasOpenComment(row);
  if (row->hl_oc != oc && row->idx + 1 < E->numrows)
    editorUpdateSyntax(E, &E->row[row->idx + 1]);
  row->hl_oc = oc;
}
