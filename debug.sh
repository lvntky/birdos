#!/bin/bash

# Set the paths to your files
BOOTSECTOR=birdos.bin
QEMU=qemu-system-x86_64
GDB=gdb

# Create a temporary image file
IMG=boot.img
dd if=/dev/zero of=$IMG bs=512 count=1
dd if=$BOOTSECTOR of=$IMG conv=notrunc

# Start QEMU and wait for GDB connection
$QEMU -drive format=raw,file=$IMG -s -S &
QEMU_PID=$!

# Give QEMU some time to start up
sleep 1

# Start GDB and connect to QEMU
$GDB -ex "target remote localhost:1234" -ex "symbol-file $BOOTSECTOR"

# After GDB exits, kill QEMU
kill $QEMU_PID

# Clean up the temporary image file
rm $IMG
