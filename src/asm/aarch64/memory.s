.section .text
    .global __ASM_MEMORY_ALLOC__
    .global __ASM_MEMORY_FREE__

// void* __ASM_MEMORY_ALLOC__(size_t size)
__ASM_MEMORY_ALLOC__:
    mov    x1, x0     // length = size
    mov    x0, #0     // addr = null (let kernel choice it)
    mov    x2, #3     // prot = PROT_READ | PROT_WRITE
    mov    x3, #0x22  // flags = MAP_PRIVATE | MAP_ANONYMOUS
    mov    x4, -1     // fd = -1
    mov    x5, #0     // offset = 0
    mov    x8, #222
    svc    0
    ret

// void __ASM_MEMORY_FREE__(void* ptr, size_t size)
__ASM_MEMORY_FREE__:
    mov   x8, #215
    svc   0
    ret