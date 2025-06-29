#include "kcstd/io.h"

#include "kcstd/memory.h"
#include "kcstd/string.h"
#include "kcstd/types.h"

file std_files[] = {
    (file){.fd = 0, .filename = "__builtin__stdin__"},   // stdin
    (file){.fd = 1, .filename = "__builtin__stdout__"},  // stdout
    (file){.fd = 2, .filename = "__builtin__stderr__"}   // stderr
};

size_t write(const file* f, const void* buf, size_t len) {
  int fd = f->fd;
  return __ASM_WRITE__(fd, buf, len);
}

size_t read(const file* f, const void* dest, size_t count) {
  int fd = f->fd;
  return __ASM_READ__(fd, dest, count);
}

void exit(long exit_code) {
  __ASM_EXIT__(exit_code);
}

file* file_open(string filename, file_open_mode mode) {
  file* fl = memory_alloc(sizeof(file));
  if (fl == null) {
    printf("Failed to allocated memory to open %s.\n", filename);
    return null;
  }
  fl->filename = filename;
  int flags;
  int perm = 0;
  if (mode == FILE_MODE_READ) {
    flags = O_RDONLY;
  } else if (mode == FILE_MODE_WRITE) {
    flags = O_CREAT | O_WRONLY | O_TRUNC;
    perm = PERM_RWR_R_R;
  }
  int fd = __ASM_OPENAT__(-100, filename, flags, perm);
  if (fd < 0) {
    return null;
  }
  fl->fd = fd;
  return fl;
}

void file_close(file* fl) {
  if (fl == null) return;
  if (fl->fd >= 0) {
    __ASM_CLOSE__(fl->fd);
    fl->fd = -1;
  }
  memory_free(fl);
}