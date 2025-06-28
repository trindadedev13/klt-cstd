.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__

// write(int fd, const void* buffer, size_t len)
__ASM_WRITE__:
    mov     x8, #64        // syscall write
    svc     0              // system call
    ret                    // returns to caller

// exit(int status)
__ASM_EXIT__:
    mov     x8, #93        // syscall exit
    svc     0              // ends the process