.section .text
.global __ASM_MEMORY_ALLOC__
.global __ASM_MEMORY_FREE__

// void* __ASM_MEMORY_ALLOC__(size_t size)
__ASM_MEMORY_ALLOC__:
    push   %ebp
    mov    %esp, %ebp

    push   $0           # offset = 0
    push   $-1          # fd = -1
    push   $0x22        # flags = MAP_PRIVATE | MAP_ANONYMOUS
    push   $0x3         # prot = PROT_READ | PROT_WRITE
    push   $0           # addr = NULL
    push   8(%ebp)      # size (argumento do chamador)

    movl   $192, %eax   # syscall number for mmap2
    mov    %esp, %ebx   # pointer to argument array
    int    $0x80

    add    $24, %esp    # limpar os 6 argumentos (6 * 4 bytes)
    pop    %ebp
    ret

// void __ASM_MEMORY_FREE__(void* ptr, size_t size)
__ASM_MEMORY_FREE__:
    push   %ebp
    mov    %esp, %ebp

    movl   $91, %eax       # syscall number for munmap
    mov    8(%ebp), %ebx   # ptr
    mov    12(%ebp), %ecx  # size
    int    $0x80

    pop    %ebp
    ret