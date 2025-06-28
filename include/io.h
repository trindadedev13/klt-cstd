#ifndef __IO_H__
#define __IO_H__

#include "core.h"
#include "extern.h"
#include "string.h"

TYPEDEF STRUCT {
  INT fd;
} FILE;

CONST FILE STD_FDS[] = {
    { .fd = 0 },
    { .fd = 1 },
    { .fd = 2 }
};

#define STDIN  (&STD_FDS[0])
#define STDOUT (&STD_FDS[1])
#define STDERR (&STD_FDS[2])

STATIC VOID WRITE(CONST FILE* file, CONST BUFFER buffer, SIZE_T len) {
  INT fd = file->fd;
  __ASM_WRITE__(fd, buffer, len);
}

STATIC VOID PRINT(CONST STRING str) {
  CONST SIZE_T len = STRING_LENGTH(str);
  WRITE(STDOUT, str, len);
}

STATIC VOID EXIT(LONG exit_code) {
  __ASM_EXIT__(exit_code);
}

#endif