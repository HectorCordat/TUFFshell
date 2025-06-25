%include "syscalls.inc"

section .data
    message db "TUFF -> "
    backslash_n db 10

section .bss
    buff resb 2048
    array resq 2
    envp_ptr resq 1

global buff
global array
global envp_ptr

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

input:
    mov rdi, 0
    cmp rax, 0
    jz my_exit
    call my_clean_string
    mov qword [array], buff
    mov qword [array + 8], 0
    mov rax, 1
    mov rdi, 1
    mov rsi, buff
    mov rdx, 2048
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, backslash_n
    mov rdx, 1
    syscall
    ret

prompt:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 6
    syscall
    ret

my_read:
    mov rax, 0
    mov rdi, 0
    mov rsi, buff
    mov rdx, 2048
    syscall
    ret

my_clean_string:
    mov rsi, buff

verif_clean:
    cmp byte [rsi], 0
    je return
    cmp byte [rsi], 10
    jne incr_rsi
    mov byte [rsi], 0
    jmp return

incr_rsi:
    inc rsi
    jmp verif_clean

return:
    ret

clear_buff:
    mov rcx, 0
    mov rsi, buff

clear_loop:
    mov byte [rsi + rcx], 0
    inc rcx
    cmp rcx, 2048
    jl clear_loop
    ret
