#include "kcstd/memory.h"

#include "kcstd/types.h"

void* memory_alloc(size_t size) {
  void* real_ptr = __ASM_MEMORY_ALLOC__(size + sizeof(memory_block_header));
  memory_block_header* header = (memory_block_header*)real_ptr;
  header->size = size;
  return (void*)(header + 1);
}

void memory_free(void* ptr) {
  memory_block_header* header = ((memory_block_header*)ptr) - 1;
  size_t size = header->size;
  __ASM_MEMORY_FREE__((void*)header, size + sizeof(memory_block_header));
}

void* memory_move(void* dest, const void* src, size_t size) {
  const byte* s = src;
  byte* d = dest;
  if (d < s) {
    for (size_t i = 0; i < size; i++) {
      d[i] = s[i];  // copy byte in s[i] to d[i]
    }
  } else {
    for (size_t i = size; i > 0; i--) {
      d[i - 1] = s[i - 1];  // copy byte in s[i-1] to d[i-1]
    }
  }
  return dest;
}

void* memory_copy(void* dest, const void* src, size_t size) {
  const byte* s = src;
  byte* d = dest;
  while (size--) {
    *d = *s;  // copy origin byte to dest
    d++;      // advance dest pointer
    s++;      // advance origin pointer
  }
  return dest;
}

void* memory_set(void* src, byte new, size_t size) {
  byte* s = src;
  for (int i = 0; i < size; i++) {
    s[i] = new;
  }
  return src;
}