#ifndef SYSCALLS_H
#define SYSCALLS_H

#include "kcstd/types.h"

extern size_t __ASM_WRITE__(int fd, const void* buffer, size_t len);
extern size_t __ASM_READ__(int fd, const void* dest, size_t count);
extern void __ASM_EXIT__(long status);
extern int __ASM_OPENAT__(int dirfd, const char* filename, int flags, int mode);
extern void __ASM_CLOSE__(int fd);
extern void* __ASM_NMAP__(void *addr, size_t size, int prot, int flags, int fd, size_t offset);
extern void __ASM_MUNMAP__(void* ptr, size_t size);

#endif