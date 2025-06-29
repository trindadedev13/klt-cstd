.section .text
    .global __ASM_WRITE__
    .global __ASM_EXIT__
    .global __ASM_OPENAT__
    .global __ASM_READ__
    .global __ASM_CLOSE__

# void __ASM_WRITE__(int fd, const void *buf, size_t len)
__ASM_WRITE__:
    movl    $4, %eax         # syscall number for write (x86)
    movl    4(%esp), %ebx    # fd
    movl    8(%esp), %ecx    # buf
    movl    12(%esp), %edx   # len
    int     $0x80
    ret

# void __ASM_EXIT__(int status)
__ASM_EXIT__:
    movl    $1, %eax         # syscall number for exit (x86)
    movl    4(%esp), %ebx    # status
    int     $0x80
    ret

# int __ASM_OPENAT__(int dirfd, const char* filename, int flags, int mode)
__ASM_OPENAT__:
    movl    $295, %eax       # syscall number for openat (x86)
    movl    4(%esp), %ebx    # dirfd
    movl    8(%esp), %ecx    # filename
    movl    12(%esp), %edx   # flags
    movl    16(%esp), %esi   # mode
    int     $0x80
    ret

# ssize_t __ASM_READ__(int fd, void* dest, size_t count)
__ASM_READ__:
    movl    $3, %eax         # syscall number for read (x86)
    movl    4(%esp), %ebx    # fd
    movl    8(%esp), %ecx    # dest
    movl    12(%esp), %edx   # count
    int     $0x80
    ret

# void __ASM_CLOSE__(int fd)
__ASM_CLOSE__:
    movl    $6, %eax         # syscall number for close (x86)
    movl    4(%esp), %ebx    # fd
    int     $0x80
    ret