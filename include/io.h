#ifndef __IO_H__
#define __IO_H__

#include "string.h"
#include "types.h"

typedef struct {
  int fd;
} file;

extern file std_files[];

#define stdin (&std_files[0])
#define stdout (&std_files[1])
#define stderr (&std_files[2])

// ASM
extern long __ASM_WRITE__(int fd, const buffer buffer, size_t len);
extern long __ASM_EXIT__(long status);

// Writes a content(buffer) to a file
void write(const file *f, const buffer buf, size_t len);

// Finishes the program
void exit(long exit_code);

// Writes a char in stdout.
void put_char(char c);
// Writes a string in stdout.
void put_str(string s);

// Writes a int in stdout.
void print_int(int n);
// Writes a formatted string in stdout.
void printf(const string fmt, ...);

#endif