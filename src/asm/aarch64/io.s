.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__
    .global __ASM_OPENAT__
    .global __ASM_READ__
    .global __ASM_CLOSE__

// size_t __ASM_WRITE__(int fd, const void* buffer, size_t len)
__ASM_WRITE__:
    mov    x8, #64        // syscall write
    svc    0              // system call
    ret                   // returns to caller

// void __ASM_EXIT__(int status)
__ASM_EXIT__:
    mov    x8, #93        // syscall exit
    svc    0              // ends the process

// int __ASM_OPENAT__(int dirfd, const char* filename, int flags, int mode)
__ASM_OPENAT__:
    mov    x8, #56  // openat syscall
    svc    0
    ret

// size_t __ASM_READ__(int fd, void* dest, size_t count)
__ASM_READ__:
    mov    x8, #63  // read syscall
    svc    0
    ret

// void __ASM_CLOSE__(int fd)
__ASM_CLOSE__:
    mov    x8, #57  // close syscall
    svc    0
    ret