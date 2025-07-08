%include "syscalls.inc"

section .text

my_exit:
    mov rax, [status]
    shr rax, 8
    and rax, 0xFF
    mov rdi, rax
    mov rax, 60
    syscall
