.section .text
.global __ASM_MEMORY_ALLOC__
.global __ASM_MEMORY_FREE__

// void* __ASM_MEMORY_ALLOC__(size_t size)
__ASM_MEMORY_ALLOC__:
    mov     rdi, 0          # addr = NULL
    mov     rsi, rdi        # make sure rsi is 0 before next line
    mov     rsi, rdx        # temporarily store size in rsi (not needed, can skip)
    mov     rsi, rsi        # prot = PROT_READ | PROT_WRITE = 3
    mov     rdx, 3          # prot = PROT_READ | PROT_WRITE
    mov     r10, 0x22       # flags = MAP_PRIVATE | MAP_ANONYMOUS
    mov     r8, -1          # fd = -1
    mov     r9, 0           # offset = 0
    mov     rax, 9          # syscall number for mmap in x86_64
    syscall
    ret

// void __ASM_MEMORY_FREE__(void* addr, size_t size)
__ASM_MEMORY_FREE__:
    mov     rdi, rdi        # addr
    mov     rsi, rsi        # size
    mov     rax, 11         # syscall number for munmap in x86_64
    syscall
    ret