%macro rwm 2
mov rax,01 
mov rdi,01 
mov rsi,%1 
mov rdx,%2 
syscall 
%endmacro

section .bss
posa resb 02
nega resb 02

section .data
arr db -11,12,10,-20,-25,-33,126,55h,00
lenarr equ $-arr
answer db "In the array",10,"Positive : Negative = "
lenanswer equ $-answer
colon db " : "
lencolon equ $-colon
newline db 10
lennewline equ $-newline

global _start
section .text
_start:

mov rsi,arr
mov al,00
mov bl,30h
mov cl,lenarr
mov dl,30h
l1:
cmp al,[rsi]
jle posi
jg negi
posi:
add bl,01
jmp l2
negi:
add dl,01
l2:
inc rsi
dec cl
jnz l1

mov byte[posa],bl

mov byte[nega],dl

rwm answer,lenanswer
rwm posa,02
rwm colon,lencolon
rwm nega,02
rwm newline,lennewline

call exit

exit:
mov rax, 60
mov rdi, 00
syscall
