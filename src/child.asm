%include "syscalls.inc"

section .text

my_forkaka:
    mov rax, 57
    syscall
    cmp rax, 0
    jz my_child
    mov rdi, rax
    mov rax, 61
    mov rsi, 0
    mov rdx, 0
    mov r10, 0
    syscall
    ret

my_child:
    call my_execve
    mov rdi, 0
    jmp my_exit

my_execve:
    mov rax, 59
    mov rdi, buff
    lea rsi, [rel array]
    mov rdx, [envp_ptr]
    syscall
    ret
