#ifndef __CSTD_H_
#define __CSTD_H_

// Macros for who likes c names

// IO
#define putchar(c) put_char(c)
#define puts(s) put_string(s)

// Memory
#define malloc(size) memory_alloc(size)
#define free(ptr) memory_free(ptr)
#define memmove(dest, src, size) memory_move(dest, src, size)
#define memcpy(dest, src, size) memory_copy(dest, src, size)
#define memset(dest, new, size) memory_set(dest, new, size)

// String
#define strlen(str) str_len(str)
#define strcmp(a, b) str_cmp(a, b)
#define strncmp(a, b, lmt) str_cmp_lmt(a, b, lmt)
#define strcat(src, new) str_cat(src, new)
#define strcpy(src, dest) str_copy(src, dest)
#define strncpy(src, dest, lmt) str_copy_lmt(src, dest, lmt)

#endif