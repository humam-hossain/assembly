stack segment para stack
	db 64 dup (' ')
stack ends

data segment para 'data'
	time_aux db 0
	ball_size dw 04h
	ball_x dw 0ah
	ball_y dw 0ah
	ball_velocity_x dw 05h
	ball_velocity_y dw 02h
	
data ends

code segment para 'code'
	main proc far
	assume cs:code, ds:data, ss:stack
	push ds 	; push data segment to the stack
	sub ax,ax 	; cleaning ax register
	push ax
	mov ax, data ; saving contents of data register to ax register
	mov ds, ax 	; ax to ds
	pop ax
	pop ax
	
		call clear_screen
		
		check_time:
			mov ah, 2ch ; system time
			int 21h 	; CH = hour CL = minute DH = second DL = 1/100 seconds
			
			cmp dl, time_aux
			je check_time
			
			mov time_aux, dl
			
			call clear_screen
			call move_ball
			call draw_ball
			
			jmp check_time
			
		ret
	main endp
	
	move_ball proc near
		mov ax, ball_velocity_x
		add ball_x, ax
		mov ax, ball_velocity_y
		add ball_y, ax
		
		ret
	move_ball endp
	
	draw_ball proc near
		mov cx, ball_x ; initial x axis
		mov dx, ball_y ; initial y axis
		
		draw_ball_horizontal:
		
		mov ah, 0ch ; write graphics pixel mode
		mov al, 0fh ; white color
		mov bh, 00h ; page number 0
		int 10h
		
		inc cx
		mov ax, cx
		sub ax, ball_x
		cmp ax, ball_size
		jng draw_ball_horizontal
		
		mov cx, ball_x
		inc dx
		
		mov ax, dx
		sub ax, ball_y
		cmp ax, ball_size
		jng draw_ball_horizontal
	
	draw_ball endp
	
	clear_screen proc near
		mov ah, 00h ; video mode
		mov al, 13h
		int 10h
		
		mov ah, 0bh 
		mov bh, 00h ; backgound color
		mov bl, 00h ; black
		int 10h
		
		ret
	clear_screen endp
code ends

end