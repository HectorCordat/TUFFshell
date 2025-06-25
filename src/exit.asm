global my_exit

section .text

my_exit:
    mov rax, 60
    syscall
