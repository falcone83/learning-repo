global _start

extern _str_print
extern _sys_exit
extern _sys_readstring

section .bss

section .data 
                 ;01234567890123456789012345678901 - 32 bytes per line
    mainMenu: db "-----------MAIN MENU-----------", 10, \
                 "|    1) Is it a palindrome?   |", 10, \
                 "|                             |", 10, \
                 "-------------------------------", 10, \
                 "                              ", 10, 0

   

section .text

_start:
   
   mov rdi, mainMenu
   call _str_print
    

    mov rdi, 0
    call _sys_exit




