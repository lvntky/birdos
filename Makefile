# Define variables
NASM = nasm
NASM_FLAGS = -f bin
QEMU = qemu-system-x86_64
GDB = gdb
BOOTSECTOR = birdos.bin
ASM_SOURCE = birdos.asm
IMG = boot.img

# Phony targets
.PHONY: all build run debug clean

# Default target
all: build

# Build target
build:
	@echo -e "[1/2] $(NASM) $(NASM_FLAGS) -o $(BOOTSECTOR) $(ASM_SOURCE)"
	$(NASM) $(NASM_FLAGS) -o $(BOOTSECTOR) $(ASM_SOURCE)

# Run target
run: build
	@echo -e "[2/2] $(QEMU) -drive format=raw,file=$(BOOTSECTOR) &"
	$(QEMU) -drive format=raw,file=$(BOOTSECTOR)

# Debug target
debug: build
	@echo -e "Creating temporary image file $(IMG)"
	dd if=/dev/zero of=$(IMG) bs=512 count=1
	dd if=$(BOOTSECTOR) of=$(IMG) conv=notrunc
	@echo -e "Starting $(QEMU) for debugging"
	$(QEMU) -drive format=raw,file=$(IMG) -s -S &
	QEMU_PID=$!
	@echo -e "Starting $(GDB) and connecting to $(QEMU)"
	sleep 1
	$(GDB) -ex "target remote localhost:1234" -ex "symbol-file $(BOOTSECTOR)"
	kill $$QEMU_PID
	@echo -e "Cleaning up temporary image file $(IMG)"
	rm $(IMG)

# Clean target
clean:
	rm -f $(BOOTSECTOR) $(IMG)
