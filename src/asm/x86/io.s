.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__

# void __ASM_WRITE__(int fd, const void *buf, size_t len)
__ASM_WRITE__:
    movl    $4, %eax       # syscall number for write
    int     $0x80          # perform syscall

# void __ASM_EXIT__(int status)
__ASM_EXIT__:
    movl     $60, %eax      # syscall number for exit
    int     $0x80          # perform syscall