;function to exit the program.
;ARGUMENTS
;-rdi - Exit Code
;
;NOTE: We are exiting the program here so no need to mess with registers
global _sys_exit

section .text

_sys_exit:
    mov rax, 60
    syscall
    ret