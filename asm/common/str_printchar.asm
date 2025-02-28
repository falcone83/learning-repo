;function to print a scharacer
;ARGUMENTS
;   rdi - Character Code
;RETURNS
;   NONE
global _fn_printchar

section .text

_fn_printchar:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    mov [rsp], rdi   

    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1

    syscall


    mov rsp, rbp
    pop rbp

    ret