# Makefile for compiling and linking hello.asm

# Target executable name
TARGET = hello

# Source assembly file
SRC = hello.asm

# Object file generated from the source
OBJ = hello.o

# NASM settings
# Use elf64 for 64-bit assembly. Change to elf32 if you're targeting 32-bit.
ASM = nasm
ASMFLAGS = -f elf64 -g -F dwarf 

# Linker
LD = ld

# Default target
all: $(TARGET)

# Linking step: Convert object file into executable
$(TARGET): $(OBJ)
	$(LD) $(OBJ) -o $(TARGET)

# Assembling step: Convert source file into object file
$(OBJ): $(SRC)
	$(ASM) $(ASMFLAGS) $(SRC) -o $(OBJ)

# Clean up generated files
clean:
	rm -f $(OBJ) $(TARGET)

# Declare non-file targets to avoid conflicts
.PHONY: all clean
