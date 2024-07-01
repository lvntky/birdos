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
%include "util.mac"

start:
;; set 13h mode
        mov ah, 0x00
        mov al, 0x13
        int 0x10

        mov bx, 0
        mov ax, VIDEO_BUFFER
        mov es, ax

set_background:
        mov BYTE [es:bx], BG_COLOR
        inc bx
        cmp bx, (SCREEN_WIDTH * SCREEN_HEIGHT)
        jb set_background

game_loop:
        call draw_pipe
        jmp game_loop

draw_pipe:
        mov cx, 20        ; Start y-coordinate
        mov bx, 190       ; End x-coordinate
        xor dx, dx        ; Initialize x-coordinate to 0

draw_y_axis:
        mov dx, 20        ; Start x-coordinate for each row
draw_x_axis:
        ;set_pixel es, cx, dx, 0x4
        mov ax, cx
        imul ax, SCREEN_HEIGHT
        add ax, dx
        mov di, ax
        mov byte [es:di], 0x4
        inc dx
        cmp dx, 20
        jl draw_x_axis    ; Loop until x reaches 190

        inc cx            ; Increment y-coordinate
        cmp cx, 190        ; This can be adjusted to control height
        jne draw_y_axis

exit_draw:
        ret
times 510 - ($ - $$) db 0   ; Pad the rest of the boot sector with zeros
dw 0xAA55                   ; Boot sector signature
