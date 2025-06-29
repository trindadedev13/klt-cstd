.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__
    .global __ASM_OPENAT__
    .global __ASM_READ__
    .global __ASM_CLOSE__

// void __ASM_WRITE__(int fd, const void* buffer, size_t len)
__ASM_WRITE__:
    mov     r7, #4         // syscall write
    svc     0              // system call
    bx      lr             // returns to caller

// void __ASM_EXIT__(int status)
__ASM_EXIT__:
    mov     r7, #1         // syscall exit
    svc     0              // ends the process

// int __ASM_OPENAT__(int dirfd, const char* filename, int flags, int mode)
__ASM_OPENAT__:
    mov    r7, #56  // openat syscall
    svc    0
    bx     lr

// size_t __ASM_READ__(int fd, void* dest, size_t count)
__ASM_READ__:
    mov    r8, #63  // read syscall
    svc    0
    bx     lr

// void __ASM_CLOSE__(int fd)
__ASM_CLOSE__:
    mov    r7, #57  // close syscall
    svc    0
    bx     lr