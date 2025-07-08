%include "syscalls.inc"

section .data
    message db "TUFF -> "
    backslash_n db 10

section .bss
    buff resb 2048
    array resq 2
    envp_ptr resq 1
    status resd 1

global buff
global array
global envp_ptr
global status
global backslash_n

section .text
global _start

_start:
    mov rdi, [rsp]
    lea rsi, [rsp + 8]
    lea rax, [rsi + rdi * 8 + 8]
    mov [envp_ptr], rax
    mov rcx, 0
    jmp my_loop

my_loop:
    call clear_buff
    call prompt
    call my_read
    call input
    call my_forkaka
    jmp my_loop

prompt:
    mov rax, 1                          ; sys_write
    mov rdi, 1
    mov rsi, message
    mov rdx, 8
    syscall
    ret
