;;;
;;; Print string characters in bx register
;;;

print_char:
    pusha               ; store all the reg into stack
    mov ah, 0x0e		; int 10/ ah=0eh bios teletype video output mode

_loop:
    mov al, [bx]
    cmp al, 0
    je end_print
    int 0x10
    inc bx
    jmp _loop

end_print:
    popa                ; release all reg
    ret
