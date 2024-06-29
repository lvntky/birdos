echo -e "[1/2] nasm -f bin -o birdos.bin birdos.asm"
nasm -f bin -o birdos.bin birdos.asm
echo -e "[2/2] qemu-system-x86_64 -drive format=raw,file=birdos.bin &"
qemu-system-x86_64 -drive format=raw,file=birdos.bin &
