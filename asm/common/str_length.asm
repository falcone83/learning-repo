;function to calculate a string length.
;ARGUMENTS
;   rdi - String
;RETURNS
;   rax - Length of the string

global _str_length

section .text

_str_length:

    mov rcx, 0
    .loop:
        cmp byte[rdi + rcx], 0    
        jz .break
        inc rcx

    jmp .loop

.break:
    mov rax, rcx
    ret