%macro rwm 3
mov rax,%1 
mov rdi,1 
mov rsi,%2 
mov rdx,%3 
syscall 
%endmacro

section .data
msg1 db "Enter the string: "
len1 equ $ -msg1 
msg2 db "Length of the string is "
len2 equ $-msg2 
msg3 db 10

section .bss
ipstr resb 50
oplen resb 5

global _start
section .text
_start:

rwm 1,msg1,len1
rwm 0,ipstr,50

mov rsi,oplen
mov bx,ax
mov cl,4

l2:
rol bx,4 
mov ax,bx
and ax,0Fh

cmp ax,09h 
jbe l
add ax,07h
l:
add ax,30h

mov [rsi],ax
inc rsi
dec cl
jnz l2

rwm 1,msg2,len2
rwm 1,oplen,10
rwm 1,msg3,1

call exit

exit:
mov rax, 60
mov rdi, 00
syscall
