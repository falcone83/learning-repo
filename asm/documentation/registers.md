
# x86-64 Register Table with Purpose and Caller/Callee-Saved Information

| Register  | Purpose                                      | Special Notes                                         | Caller/Callee-Saved |
|-----------|----------------------------------------------|-------------------------------------------------------|---------------------|
| `rax`     | Return value, general-purpose               | Used for function return values                       | **Caller-Saved**     |
| `rbx`     | Callee-saved, general-purpose               | Must be preserved across function calls               | **Callee-Saved**     |
| `rcx`     | Argument passing, loops                     | Used in `rep` string instructions                     | **Caller-Saved**     |
| `rdx`     | Argument passing, I/O operations            | Used for division (`div` instruction)                 | **Caller-Saved**     |
| `rsi`     | Argument passing, source pointer            | Used for `movs` and `stos` string operations           | **Caller-Saved**     |
| `rdi`     | Argument passing, destination pointer       | Used for `movs` and `stos` string operations           | **Caller-Saved**     |
| `rbp`     | Base pointer (Callee-saved)                  | Traditionally used for stack frames                   | **Callee-Saved**     |
| `rsp`     | Stack pointer                               | Always points to the top of the stack                 | **Callee-Saved**     |
| `r8-r11`  | Caller-saved, general-purpose               | Used for additional function arguments                | **Caller-Saved**     |
| `r12-r15` | Callee-saved, general-purpose               | Must be preserved across function calls               | **Callee-Saved**     |
| `rip`     | Instruction pointer                         | Holds the address of the next instruction to execute  | **Managed by CPU**   |
| `eflags`  | Status flags                                | Holds CPU condition flags (ZF, CF, SF, etc.)          | **Varies**           |


## x86-64 Registers by Bit Size

| **Register (64-bit)** | **32-bit Register** | **16-bit Register** | **8-bit Register (Low)** | **8-bit Register (High)** |
|-----------------------|---------------------|---------------------|--------------------------|---------------------------|
| **RAX**               | EAX                 | AX                  | AL                       | AH                        |
| **RBX**               | EBX                 | BX                  | BL                       | BH                        |
| **RCX**               | ECX                 | CX                  | CL                       | CH                        |
| **RDX**               | EDX                 | DX                  | DL                       | DH                        |
| **RSI**               | ESI                 | SI                  | SIL                      |                           |
| **RDI**               | EDI                 | DI                  | DIL                      |                           |
| **RBP**               | EBP                 | BP                  | BPL                      |                           |
| **RSP**               | ESP                 | SP                  | SPL                      |                           |
| **R8**                | R8D                 | R8W                 | R8B                      |                           |
| **R9**                | R9D                 | R9W                 | R9B                      |                           |
| **R10**               | R10D                | R10W                | R10B                     |                           |
| **R11**               | R11D                | R11W                | R11B                     |                           |
| **R12**               | R12D                | R12W                | R12B                     |                           |
| **R13**               | R13D                | R13W                | R13B                     |                           |
| **R14**               | R14D                | R14W                | R14B                     |                           |
| **R15**               | R15D                | R15W                | R15B                     |                           |

## Key Points:
- **64-bit registers** (e.g., `RAX`) are the full registers.
- **32-bit registers** (e.g., `EAX`) are the lower 32 bits of the 64-bit register.
- **16-bit registers** (e.g., `AX`) are the lower 16 bits of the 32-bit register.
- **8-bit registers** (e.g., `AL`, `AH`) are the lower 8 bits of the 16-bit register (with `AH` representing the high byte).

---

## Callee-Saved vs. Caller-Saved Registers

### Caller-Saved Registers - Callers responsibility before saving because the function CAN overwrite them

| Register  | Purpose                                      |
|-----------|----------------------------------------------|
| `rax`     | Return value, general-purpose               |
| `rcx`     | Argument passing, loops                     |
| `rdx`     | Argument passing, I/O operations            |
| `rsi`     | Argument passing, source pointer            |
| `rdi`     | Argument passing, destination pointer       |
| `r8-r11`  | Caller-saved, general-purpose               |

---

### Callee-Saved Registers - MUST store local copies and restores them if needed

| Register  | Purpose                                      |
|-----------|----------------------------------------------|
| `rbx`     | Callee-saved, general-purpose               |
| `rbp`     | Base pointer (Callee-saved)                  |
| `rsp`     | Stack pointer                               |
| `r12-r15` | Callee-saved, general-purpose               |

### Caller-Saved Registers
- The **caller** (function making the call) is responsible for saving these if needed before calling a function.  
- If a function modifies a caller-saved register, it **does NOT need to restore it**.  

### Callee-Saved Registers
- The **callee** (function being called) must **preserve** these if it modifies them.  
- If a function changes a callee-saved register, it must **restore it before returning**.  

---

## Example Usage

### Caller-Saved Registers:
```assembly
mov rax, 5       ; Store a value in RAX
call some_func   ; RAX might be overwritten
; RAX may have changed, so save it before the call if needed
```
✅ If `rax` holds important data, the caller **must save it before the function call**.

### Callee-Saved Registers:
```assembly
some_func:
    push rbx      ; Save RBX (callee-saved)
    mov rbx, 10   ; Use RBX
    ; Function logic
    pop rbx       ; Restore RBX before returning
    ret
```
✅ Since `rbx` is **callee-saved**, the function must **restore it before returning**.

---

This ensures that registers are used correctly in function calls without unexpected overwrites!