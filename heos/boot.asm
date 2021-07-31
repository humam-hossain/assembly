;;;
;;; simple bootloader that uses int 13h/ ah 02h to read from disk into memory
;;;
    org 0x7c00

    ;; setup ES:BX memory address/segment:offset to load sector(s) into
    mov bx, 0x1000              ; load sector to memory address 0x1000
    mov es, bx                  ; es = 0x1000
    mov bx, 0x0000              ; es:bx = 0x1000:0x0000

    ;; setup disk read
    mov dh, 0x00    ; head 0
    mov dl, 0x00    ; drive 0
    mov ch, 0x00    ; cylinder 0
    mov cl, 0x02    ; starting sector to read from disk

read_disk:
    mov ah, 0x02    ; bios int 13h/ah 02h = read disk sectors
    mov al, 0x01    ; # of sectors to read
    int 0x13        ; bios interrupt for disk read function

    jc read_disk

    ;; reset segment registers for RAM
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    jmp 0x1000:0x0


    ;; bootsector magic
    times 510 - ($ - $$) db 0   ; filling up with zeros until 510th byte

    dw 0xaa55                   ; bios magic number to boot
