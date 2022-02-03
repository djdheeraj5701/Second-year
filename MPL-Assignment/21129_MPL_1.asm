%macro msgmarco 1
mov rax, 01
mov rdi, 01
mov rsi, %1
mov rdx, 20
syscall
%endmacro

%macro rwmarco 1
mov rax, %1
mov rdi, %1
add rsi, rbx
mov rdx, 17
syscall
add rbx, 17
dec byte[count]
%endmacro

section .data
msg1 db "Enter the numbers: ",10
msg2 db 10,"The numbers are : ",10

section .bss
arr resb 85
count resb 1

global _start
section .text
_start:
msgmarco msg1

call setarr
l1:
rwmarco 0
jnz l1

msgmarco msg2

call setarr
l2:
rwmarco 1
jnz l2

mov rax, 60
mov rdi, 00
syscall

setarr:
mov rbx, 00
mov byte[count], 05
mov rsi, arr
ret

