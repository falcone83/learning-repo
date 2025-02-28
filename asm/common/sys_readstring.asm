;Function to read input from the user and strip the trailing carriage return
;ARGUMENTS
;   NONE
;RETURN
;   rax - buffer to trimmed string.

global _sys_readstring  ;declares a global function

;preprocessor directive macro
%define BUFFER_LEN 1024 

;This section is for dynamic data. These are pointers.
section .bss
    buffer: resb BUFFER_LEN     ;User Entry
    bufferf: resb BUFFER_LEN    ;Trimmed entry, whitespaces removed

section .text   ;This section is for code.

_sys_readstring:  ;function implementation

    ;Setup a SYSCALL
    mov rax, 0          ;Syscall to read data from the user;
    mov rdi, 0          ;file descriptior, 0 for STDIN
    mov rsi, buffer     ;pointer to a buffer to store the users data
    mov rdx, BUFFER_LEN ;The length of bytes we should read from the buffer
    syscall             ;Execution of the syscall

    mov rsi, buffer     ;Ensure the buffer's current address is in RSI
    mov rdi, bufferf    ;Ensure the filtered buffer is in RDI

    lea rcx, [buffer + BUFFER_LEN]  ;load the address of the last byte of buffer to detect overflow

     .loop:
        mov al, [rsi] ;move the first by of the value in RSI (RSI points to Buffer, brackets dereference the value)
                      ;this works because al is an 8-bit register, so moving the value at RSI only moves the first byte at rsi

        ;See  if AL is zero, if it is, jump to the end label.
        cmp al, 0   ;cmp set the zero flag
        jz .end     ;jz jumps to end if the zero flag is set.

        ;check for tabs, spaces and returns, if so, skip adding them to bufferf
        cmp al, 0x20
        jz .skip
        cmp al, 0x0A 
        jz .skip
        cmp al, 0x09
        jz .skip

        mov [rdi], al   ;move the value of al, the current bye we are processing, into the address referenced by rdi (bufferf)
        inc rdi         ;increment RDI by 1 byte which moves the pointer 1 addess to the next character

    .skip:              ;increment rsi, then compare it to the address saved in rck, if they are equal, we have overflowed.i
        inc rsi
        cmp rsi, rcx
        jz .overflow

    jmp .loop           ;loop back

    .end:   ;return the buffer in rax per standards in the event we do not overflow
        mov rax, [bufferf]
        ret

    .overflow:  ;we have overflows, so return 0
        mov rax, 0
        ret