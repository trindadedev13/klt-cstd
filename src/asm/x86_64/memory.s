.section .text
    .global __ASM_MEMORY_ALLOC__
    .global __ASM_MEMORY_FREE__

# void* __ASM_MEMORY_ALLOC__(size_t size)
__ASM_MEMORY_ALLOC__:
    movq     %rdi, %rsi         # length = size
    movq     $0, %rdi           # addr = NULL
    movq     $3, %rdx           # prot = PROT_READ | PROT_WRITE
    movq     $0x22, %r10        # flags = MAP_PRIVATE | MAP_ANONYMOUS
    movq     $-1, %r8           # fd = -1
    movq     $0, %r9            # offset = 0
    movq     $9, %rax           # syscall number for mmap
    syscall
    ret

# void __ASM_MEMORY_FREE__(void* addr, size_t size)
__ASM_MEMORY_FREE__:
    movq     $11, %rax          # syscall number for munmap
    syscall
    ret