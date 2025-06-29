.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__

# void __ASM_WRITE__(int fd, const void *buf, size_t len)
__ASM_WRITE__:
    mov     $1, %rax       # syscall number for write
    syscall                # perform syscall
    ret                    # return to caller

# void __ASM_EXIT__ exit(int status)
__ASM_EXIT__:
    mov     $60, %rax      # syscall number for exit
    syscall                # perform syscall