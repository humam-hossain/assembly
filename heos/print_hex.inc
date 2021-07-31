;;;
;;; Printing hexadecimal values using dx register and print_char.inc
;;;
;;; ascii '0' - '9' = hex 0x30 - 0x39
;;; ascii 'A' - 'F' = hex 0x41 - 0x46
;;; ascii 'a' - 'f' = hex 0x61 - 0x66

print_hex:
    pusha           ; store all registers in stack
    mov cx, 0       ; initialize counter loop

hex_loop:
    cmp cx, 4
    je end_hexloop

    ;; convert dx hex values to ascii
    mov ax, dx      
    and ax, 0x000f  ; taking only last hex bit
    cmp al, 0x09    
    jle move_intobx
    add al, 0x07    ; to get 'A' - 'F'

move_intobx:
    add al, 0x30    ; converting into ascii character
    mov bx, hex_string + 5 ; base address of hex_string + length of the string
    sub bx, cx      ; subtract loop counter
    mov [bx], al   
    ror dx, 4       ; rotate right by 4 digit. 0x12AB -> 0xB12A
    inc cx          ; increment loop counter
    jmp hex_loop

    ;; move ascii char to bx string to print

end_hexloop:
    mov bx, hex_string
    call print_char

    popa            ; release all registers from stack
    ret

    ;; data
hex_string: db '0x0000', 0