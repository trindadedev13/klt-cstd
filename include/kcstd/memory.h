#ifndef __MEMORY_H__
#define __MEMORY_H__

#include "kcstd/types.h"

// Memory Pool
// Simulates a Heap.

// Memory Pool size
#ifndef POOL_SIZE
#define POOL_SIZE 0x100000  // 1mb
#endif

typedef struct memoryp_block memoryp_block;

// Block in the memory
struct memoryp_block {
  memoryp_block* next;
  size_t size;
  bool used;
};

// Memory manager
typedef struct {
  memoryp_block* free_blocks;  // free blocks in the pool
  byte memoryp[POOL_SIZE];     // all memory data
} memoryp_manager;

// Inicializes default manager
void memoryp_init();
// Allocates a memory pointer in default manager
void* memoryp_alloc(size_t size);
// Free a memory pointer in default manager
void memoryp_free(void* ptr);

// Inits an memory manager
void __memoryp_init__(memoryp_manager* mgr);
// Allocates memory pointer in mgr
void* __memoryp_alloc__(memoryp_manager* mgr, size_t size);
// Free a memory pointer in mgr
void __memoryp_free__(memoryp_manager* mgr, void* ptr);

// Real Heap Allocation with Syscalls ASM
// Block header
// Just to store block size, to free before
typedef struct {
  size_t size;
} memory_block_header;

// Asm functions
extern void* __ASM_MEMORY_ALLOC__(size_t size);
extern void __ASM_MEMORY_FREE__(void* ptr, size_t size);

// Allocates a memory pointer.
void* memory_alloc(size_t size);
// Reallocates a memory pointer
void* memory_realloc(void* ptr, size_t new_size);
// Free's a memory pointer.
void memory_free(void* ptr);
// Moves a memory pointer.
void* memory_move(void* dest, const void* src, size_t len);
// Copies a memory pointer
void* memory_copy(void* dest, const void* src, size_t len);
// Sets a value in memory pointer
void* memory_set(void* dest, byte new, size_t len);

#endif