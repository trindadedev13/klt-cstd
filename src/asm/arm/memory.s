.section .text
    .global __ASM_MEMORY_ALLOC__
    .global __ASM_MEMORY_FREE__

// void* __ASM_MEMORY_ALLOC__(size_t size)
__ASM_MEMORY_ALLOC__:
    mov    r1, r0     // length = size
    mov    r0, #0     // addr = null (let kernel choice it)
    mov    r2, #3     // prot = PROT_READ | PROT_WRITE
    mov    r3, #0x22  // flags = MAP_PRIVATE | MAP_ANONYMOUS
    mov    r4, -1     // fd = -1
    mov    r5, #0     // offset(in pages) = 0
    mov    r7, #192
    svc    0
    bx     lr

// void __ASM_MEMORY_FREE__(void* ptr, size_t size)
__ASM_MEMORY_FREE__:
    mov   r7, #91     // syscall munmap
    svc   0
    bx    lr