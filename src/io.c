#include "kcstd/io.h"

#include "kcstd/string.h"
#include "kcstd/types.h"

file std_files[] = {
    (file){.fd = 0},  // stdin
    (file){.fd = 1},  // stdout
    (file){.fd = 2}   // stderr
};

void write(const file* f, const buffer buf, size_t len) {
  int fd = f->fd;
  __ASM_WRITE__(fd, buf, len);
}

void exit(long exit_code) {
  __ASM_EXIT__(exit_code);
}