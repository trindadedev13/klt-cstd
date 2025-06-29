.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__

// void __ASM_WRITE__(int fd, const void* buffer, size_t len)
__ASM_WRITE__:
    mov     r7, #4         // syscall write
    svc     0              // system call
    bx      lr             // returns to caller

// void __ASM_EXIT__(int status)
__ASM_EXIT__:
    mov     r7, #1         // syscall exit
    svc     0              // ends the process