;;;
;;; kernel.asm : basic 'kernel' loaded from our bootsector
;;;

    ;; set video mode
    mov ah, 0x00                ; int 10h/ ah 00h set video mode
    mov al, 0x03                ; 80x25 text mode
    int 0x10

    ;; change background color
    mov ah, 0x0b                ; backgound color
    mov bh, 0x00
    mov bl, 0x01                ; blue color
    int 0x10

    ;; teletype output                   
    mov si, test_str
    call print_string                

    ;; end program
    hlt                       ; halt the cpu


print_string:
    mov ah, 0x0e
    mov bh, 0x00
    mov bl, 0x07

print_char:
    mov al, [si]
    cmp al, 0
    je end_print
    int 0x10
    inc si
    jmp print_char

end_print:
    ret


    ;; data
test_str: db "Kernel booted, Welcome to heOS ...", 0xa, 0xd, 0

    ;; sector padding magic
    times 510 - ($ - $$) db 0   ; filling up with zeros until 510th byte

