#ifndef __MEMORY_H__
#define __MEMORY_H__

#include "types.h"

#ifndef POOL_SIZE
#define POOL_SIZE 0x100000 // 1mb
#endif

typedef struct memoryp_block memoryp_block;

struct memoryp_block {
  memoryp_block* next;
  size_t size;
  bool used;
};

typedef struct {
  memoryp_block* free_blocks;
  byte memoryp[POOL_SIZE];
} memoryp_manager;

void  memoryp_init();
void* memoryp_alloc(size_t size);
void  memoryp_free(void* ptr);

void  __memoryp_init__ (memoryp_manager* mgr);
void* __memoryp_alloc__(memoryp_manager* mgr, size_t size);
void  __memoryp_free__ (memoryp_manager* mgr, void* ptr);

// Real Heap Allocation with Syscalls ASM
typedef struct {
  size_t size;
} memory_block_header;

extern void* __ASM_MEMORY_ALLOC__(size_t size);
extern void  __ASM_MEMORY_FREE__(void* ptr, size_t size);

void* memory_alloc(size_t size);
void  memory_free(void* ptr);
void* memory_move(void* dest, const void* src, size_t len);
void* memory_copy(void* dest, const void* src, size_t len);
void* memory_set (void* dest, byte new, size_t len);
#endif