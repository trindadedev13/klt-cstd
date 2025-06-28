.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__

// write(int fd, const void* buffer, size_t len)
__ASM_WRITE__:
    mov     r7, #4         // syscall write
    svc     0              // system call
    bx      lr             // returns to caller

// exit(int status)
__ASM_EXIT__:
    mov     r7, #1         // syscall exit
    svc     0              // ends the process