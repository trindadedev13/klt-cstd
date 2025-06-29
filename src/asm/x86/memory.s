.section .text
    .global __ASM_MEMORY_ALLOC__
    .global __ASM_MEMORY_FREE__

# void* __ASM_MEMORY_ALLOC__(size_t size)
__ASM_MEMORY_ALLOC__:
    push   %ebp
    mov    %esp, %ebp

    mov    $0, %ebx          # addr = NULL
    mov    8(%ebp), %ecx     # length (size)
    mov    $0x3, %edx        # prot = PROT_READ | PROT_WRITE
    mov    $0x22, %esi       # flags = MAP_PRIVATE | MAP_ANONYMOUS
    mov    $-1, %edi         # fd = -1
    mov    $0, %ebp          # offset = 0 (em páginas, para mmap2)
    mov    $192, %eax        # syscall number for mmap2
    int    $0x80

    pop    %ebp
    ret

# void __ASM_MEMORY_FREE__(void* ptr, size_t size)
__ASM_MEMORY_FREE__:
    push   %ebp
    mov    %esp, %ebp

    mov    $91, %eax         # syscall number for munmap
    mov    8(%ebp), %ebx     # addr
    mov    12(%ebp), %ecx    # length
    int    $0x80

    pop    %ebp
    ret