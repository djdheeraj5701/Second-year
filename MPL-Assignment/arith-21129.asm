%macro print 2
mov rax, 01
mov rdi,01
mov rsi, %1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax, 00
mov rdi,00
mov rsi, %1
mov rdx, %2
syscall
%endmacro

section .data
	num1 dq 0000000000000007
	num2 dq 0000000000000002
	cnt: db 00h
	menu: db "1.Addition",0xA,"2.Subtraction",0xA, "3.Multiplication",0xA, "4.Division",0xA, "0.Exit",0xA 
	len: equ $-menu
	Addition: db "Addition: "
	len1: equ $-Addition
	Subtraction: db "Substraction:"
	len2: equ $-Subtraction
	Multiply: db "Multiplication: "
	len3: equ $-Multiply
	Quotient: db "Quotient : "
	len4: equ $-Quotient
	Remainder: db "Remainder: "
	len5: equ $-Remainder
	endl: db 0xA
	len6: equ $-endl
	executed: db "Program Executed Successfully "
	len7: equ $-executed 
section .bss
	ans resb 16
	inp resb 64
	option resb 2

section .text

global _start

_start:

	print menu,len
	read option,2
	cmp byte[option],30h
	JE exit
	cmp byte[option],31h
	JE Add
	cmp byte[option],32h
	JE Sub
	cmp byte[option],33h
	JE Mul
	cmp byte[option],34h
	JE Div
	
	

	exit:
	print endl,len6
	print executed,len7
	mov rax,60
	mov rdi,0
	syscall
	
	Add:
	print Addition,len1
	mov rax,[num1]
	mov rbx,[num2]
	add rax,rbx
	call HextoAscii	
	JMP exit

	Sub:
	print Subtraction,len2
	mov rax,[num1]
	mov rbx,[num2]
	sub rax,rbx
	call HextoAscii	
	JMP exit	
	
	Mul:
	print Multiply,len3
	mov rax, [num1]
	mov rbx, [num2]
	xor rdx,rdx
	mul rbx
	mov r9,rax
	xor rax,rax
	mov rax,rdx
	call HextoAscii	
	xor rax,rax
	mov rax,r9
	call HextoAscii
	JMP exit
	
	Div:
	print Remainder,len5
	mov rax, [num1]
	mov ebx, [num2]
	xor rdx,rdx
	div ebx	
	mov r9,rax
	mov rax,rdx
	call HextoAscii
	print endl,len6
	print Quotient,len4
	mov rax,r9
	call HextoAscii
	JMP exit
	

	HextoAscii:
	mov rbx,ans
	mov byte[cnt],10h	
	M:
	rol rax,04
	mov cl,al
	and cl,0x0F
	cmp cl,09h
	JBE L
	add cl,07h
	L: add cl,30h
	mov byte[rbx],cl
	inc rbx
	dec byte[cnt]
	jnz M
	mov r8,ans
	mov bl,16h
	l1: print r8,1
	inc r8
	dec bl
	jnz l1
	
	ret
	
