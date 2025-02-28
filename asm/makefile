# Define tools
NASM = nasm
LD = ld

# Define assembler flags (with debugging support)
ASMFLAGS = -f elf64 -g -F dwarf

# Define source directories
SRC_DIRS = . common

# Find all .asm files in the source directories
SRC = $(wildcard $(addsuffix /*.asm, $(SRC_DIRS)))

# Convert source files (.asm) into object files (.o)
OBJ = $(patsubst %.asm, %.o, $(SRC))

# Output executable name
OUTPUT = hello

# Default target (compile and link everything)
all: $(OUTPUT)

# Rule to link object files into the final executable
$(OUTPUT): $(OBJ)
	$(LD) -o $(OUTPUT) $(OBJ)

# Rule to compile each .asm file to an object file
%.o: %.asm
	$(NASM) $(ASMFLAGS) -o $@ $<

# Clean up compiled files
clean:
	rm -f $(OBJ) $(OUTPUT)
