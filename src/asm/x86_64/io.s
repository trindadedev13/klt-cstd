.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__

# write(int fd, const void *buf, size_t len)
__ASM_WRITE__:
    mov     $1, %rax       # syscall number for write
    syscall                # perform syscall
    ret                    # return to caller

# exit(int status)
__ASM_EXIT__:
    mov     $60, %rax      # syscall number for exit
    syscall                # perform syscall