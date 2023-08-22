
# FILE
`stdio.h`
```c
extern FILE *stdin;     /* Standard input stream.  */
extern FILE *stdout;    /* Standard output stream.  */
extern FILE *stderr;    /* Standard error output stream.  */
```

# file descriptor
`unistd.h`
```c
#define  STDIN_FILENO   0  /* Standard input.  */
#define  STDOUT_FILENO  1  /* Standard output.  */
#define  STDERR_FILENO  2  /* Standard error output.  */
```
