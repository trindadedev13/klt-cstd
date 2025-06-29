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
extern void __ASM_MEMORY_FREE__(void* ptr, size_t size);

static void* memory_alloc(size_t size) {
  void* real_ptr = __ASM_MEMORY_ALLOC__(size + sizeof(memory_block_header));
  memory_block_header* header = (memory_block_header*) real_ptr;
  header->size = size;
  return (void*)(header + 1);
}

static void memory_free(void* ptr) {
  memory_block_header* header = ((memory_block_header*)ptr) - 1;
  size_t size = header->size;
  __ASM_MEMORY_FREE__((void*)header, size + sizeof(memory_block_header));
}

#endif