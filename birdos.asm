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

draw_pipe:
        mov cx, 100               ; x counter - width
        mov dx, 0               ; y counter - height
        mov ax, 120              ; hole counter
        jmp pipe_draw_loop
pipe_next_line:
        cmp dx, 80
        je pipe_make_hole
        mov cx, 100
        inc dx
        cmp dx, PIPE_HEIGHT
        jb pipe_draw_loop
        je exit_draw_loop

pipe_make_hole:
        inc dx
        cmp dx, ax
        je pipe_next_line
        jb pipe_make_hole
pipe_draw_loop:
        mov si, dx
        imul si, SCREEN_WIDTH
        add si, cx
        mov di, si
        mov BYTE [es:di], PIPE_COLOR
        inc cx
        cmp cx, PIPE_WIDTH + 100
        je pipe_next_line
        jb pipe_draw_loop
exit_draw_loop:
        ret

times 510 - ($ - $$) db 0   ; Pad the rest of the boot sector with zeros
dw 0xAA55                   ; Boot sector signature
