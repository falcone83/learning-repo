# Table of Contents
- [Moving Data](#moving-data)
  - [Key Differences](#key-differences)
  - [Addressing & Dereferencing Examples](#addressing--dereferencing-examples)
  - [Types of `mov` Instructions in x86-64](#types-of-mov-instructions-in-x86-64)
  - [Summary Table](#summary-table)
  - [Conclusion](#conclusion)
- [Comparing Values](#comparing-values)
  - [Key Differences](#key-differences-1)
  - [Affected Flags](#affected-flags)
  - [Examples](#examples)
- [Flags](#flags)
- [Jump Commands](#jump-commands)

# Moving Data
| Instruction | Operation | Purpose | Addressing & Dereferencing | Example Usage |
|------------|-----------|---------|---------------------------|---------------|
| `MOV` | Copies data from source to destination | Move values between registers, memory, and immediates | Can **dereference memory** (load/store data) | `mov rax, [rbx]` (Load value at address in `rbx` into `rax`) |
| `LEA` | Loads the effective address of a memory operand | Compute addresses without actually accessing memory | **Does NOT dereference memory**, just computes the address | `lea rax, [rbx + 4]` (Compute address `rbx + 4` and store in `rax`) |

## **Key Differences**
| Feature      | `MOV`                          | `LEA`                           |
|-------------|--------------------------------|---------------------------------|
| Function    | Moves data between registers/memory | Computes and loads an address |
| Memory Access | **Dereferences memory** if brackets (`[]`) are used | **Does NOT dereference memory**, only calculates addresses |
| Destination | Holds actual value | Holds an address (not a value) |
| Common Use  | Load/store values, register transfers | Address calculations, pointer arithmetic |

## **Addressing & Dereferencing Examples**
### **Using `MOV` to Load/Store Memory**
```assembly
mov rax, [rbx]      ; Load value from memory at address in `rbx`
mov [rcx], rdx      ; Store value of `rdx` into memory at address in `rcx`
mov rax, qword [rsp + 8] ; Load 8-byte value from `[rsp + 8]`
```

## **Types of `mov` Instructions in x86-64**

### **1. Immediate to Register**
```assembly
mov rax, 5        ; Move the immediate value 5 into rax
mov rdi, 'A'      ; Move ASCII character 'A' (0x41) into rdi
mov rcx, 0x12345678 ; Move a large immediate into rcx
```
- Stores a **constant (immediate value)** into a register.

---

### **2. Register to Register**
```assembly
mov rax, rdi      ; Copy value from rdi into rax
mov rbx, rcx      ; Copy rcx into rbx
```
- Moves data between **two registers**.

---

### **3. Memory to Register**
```assembly
mov rax, [rbp-8]  ; Load 8 bytes from memory at (rbp - 8) into rax
mov al, [rsi]      ; Load 1 byte from address in rsi into al
mov rbx, [rsp]     ; Load 8 bytes from the stack into rbx
```
- Reads a **value from memory** and stores it in a register.

---

### **4. Register to Memory**
```assembly
mov [rbp-8], rax  ; Store rax into memory at (rbp - 8)
mov [rsp], rdi     ; Store rdi into memory at rsp
mov byte [rsi], 0  ; Store byte value 0 at memory location in rsi
```
- Writes a register’s value **into memory**.

---

### **5. Immediate to Memory**
```assembly
mov dword [rsp], 10  ; Store 4-byte value 10 at rsp
mov byte [rdi], 'A'  ; Store 1-byte ASCII 'A' at memory location in rdi
```
- Stores a **constant value** directly into memory.

---

## **Summary Table**
| Type | Example | Description |
|------|---------|-------------|
| **Immediate → Register** | `mov rax, 10` | Load constant into a register |
| **Register → Register** | `mov rax, rbx` | Copy value between registers |
| **Memory → Register** | `mov rax, [rbp-8]` | Load value from memory into register |
| **Register → Memory** | `mov [rsp], rdi` | Store value from register into memory |
| **Immediate → Memory** | `mov dword [rsp], 5` | Store constant in memory |

---

# Comparing Values
| Instruction | Operation        | Purpose                         | Example Use                          |
|------------|-----------------|--------------------------------|--------------------------------------|
| `CMP`      | `dst - src` (subtraction) | Compare two values (signed/unsigned) | `cmp rax, 10` (Check if `rax` is 10) |
| `TEST`     | `dst & src` (bitwise AND) | Check if specific bits are set | `test rax, 1` (Check if lowest bit is set) |

## **Affected Flags**
| Instruction | ZF (Zero Flag) | SF (Sign Flag) | CF (Carry Flag) | OF (Overflow Flag) |
|------------|---------------|---------------|---------------|---------------|
| `CMP`      | Set if `dst == src` | Set if result is negative | Set if unsigned `dst < src` | Set if signed overflow occurs |
| `TEST`     | Set if `dst & src == 0` | Set if result is negative | **Not affected** | **Not affected** |

## **Examples**
```assembly
mov rax, 5
cmp rax, 3    ; Compare: 5 - 3
jg greater    ; Jump if greater (ZF=0, SF=0, CF=0)

mov rax, 5    ; 5 = 0b101
test rax, 1   ; Test if lowest bit is set
jnz bit_is_set ; Jump if bit is set (ZF == 0)
```

# Flags
| Flag Name | Description | Example Usage |
|-------------|------------------------------|------------------------------|
| **ZF** | Zero Flag | `cmp rax, rbx` <br> `je equal_case` |
| **SF** | Sign Flag | `cmp rax, rbx` <br> `jl negative_case` |
| **OF** | Overflow Flag | `add rax, rbx` <br> `jo overflow_occurred` |

# Jump Commands
| The Command  | Description | Example of Calling It | Flags Used |
|-------------|-------------|----------------|-------------|
| `JMP label` | Jumps unconditionally | `jmp my_label` | None |
| `JE` / `JZ` | Jump if equal (zero) | `cmp rax, rbx` <br> `je equal_case` | ZF |
| `JG` | Jump if greater | `cmp rax, rbx` <br> `jg greater_than` | ZF, SF, OF |

