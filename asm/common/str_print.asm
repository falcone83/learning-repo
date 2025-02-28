;function to print a string
;ARGUMENTS
;   rdi - address to the start of the string buffer
;RETURNS
;   NONE
global _str_print

extern _str_length

section .text

_str_print:

    call _str_length ;get the length of the string, rdi is already the address. reutnr length in RAX
    mov rdx, rax ;mov RAX (length) into RDX for the 
    mov rax, 1 ;SYSCALL Read
    mov rsi, rdi ;String buffer address
    mov rdi, 1 ;stdout File Descriptor
    syscall
    ret