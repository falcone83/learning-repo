
Declare one in its own file

```
FILENAME: exit.csv

;function to exit the program
;ARGUMENTS
;   rdi - Exit Code
;RETURN
;    NONE

global _fn_exit ;Function Name;

section .text

_fn_exit:
    mov rax, 60 ;syscall type
    //rdi already exists
    syscall



```
\\

| Register Type   | Registers         | Who Saves? | Purpose | Example Usage |
|----------------|------------------|------------|---------|--------------|
| **Callee-Saved** | `rbx, rbp, r12-r15` | **Callee** (function being called) | Preserved across function calls | Used for long-lived values that must survive function calls |
| **Caller-Saved** | `rax, rcx, rdx, rsi, rdi, r8-r11` | **Caller** (function making the call) | May be overwritten by the callee | Used for temporary values and function arguments |

\\
\\

# Function Parameter Order

| Register | Parameter #  | Description                |
|----------|--------------|----------------------------|
| **RDI**  | 1st          | First argument             |
| **RSI**  | 2nd          | Second argument            |
| **RDX**  | 3rd          | Third argument             |
| **RCX**  | 4th          | Fourth argument            |
| **R8**   | 5th          | Fifth argument             |
| **R9**   | 6th          | Sixth argument             |
| **Stack**| 7th+         | Additional arguments (passed in reverse order) |
| **RAX**  | -            | Return value (integer)     |
| **XMM0** | -            | Return value (floating-point) |

\\