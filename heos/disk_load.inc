;;;
;;; Disk load: Read DH sector into ES:BX memory location from drive DL
;;;

disk_load:
    push dx         ; storing dx on stack so that we can check number of sectors actually read later

    mov ah, 0x02    ; int 13h/ ah 0x02 bios read disk sectors into memeory
    mov al, dh      ; number of sectors we want to read ex. 1
    mov ch, 0x00    ; cylinder 0
    mov dh, 0x00    ; head 0
    mov cl, 0x02    ; start reading at CL sector (in this is case sector 2, right after boot sector)

    int 0x13        ; bios disk function interrupt

    jc disk_error

    ;; checking if there is any error
    pop dx
    cmp dh, al
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG  ; printing error msg
    call print_char
    hlt                     ; halt the cpu

DISK_ERROR_MSG: db "disk read error!!!",0
