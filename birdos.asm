; ====================================================================================
; birdos
; Description    : A boot sector game inspired by Flappy Bird written in NASM.
; Author         : Levent Kaya
; Date           : 2024
; License        : MIT License
; ====================================================================================
; 
; This boot sector program sets up a 320x200 256-color video mode and implements a 
; simplified version of the Flappy Bird game. The bird can be controlled using the 
; keyboard, and the game runs entirely in real mode with a size limit of 512 bytes.
;
; Instructions:
; - Assemble the code using NASM.
; - Test the binary in an emulator like QEMU or Bochs.
; 
; Files:
; - birdos.asm : The main assembly source file.
; - birdos.bin : The assembled boot sector binary.
; 
; How to build:
; - nasm -f bin -o birdos.bin birdos.asm
; - qemu-system-x86_64 -drive format=raw,file=birdos.bin
;
; ====================================================================================


BITS 16
ORG 0X7C00

%include "constant.asm"

%macro setpixel x, y
    mov ax, 0x0C0F
%endmacro

start:
    ; Set video mode to 320x200 256-color
    mov ax, 0x13
    int 0x10


game_loop:
    
    jmp game_loop

times 510 - ($ - $$) db 0   ; Pad the rest of the boot sector with zeros
dw 0xAA55                   ; Boot sector signature