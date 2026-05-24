section .data
    num1 dq 10
    num2 dq 3

section .bss
    result resq 1

section .text
    global _start
_start:
    mov rax ,[num1]
    mov rbx ,[num2]
    add rax, rbx
    mov [result], rax

    mov rax,60
    xor rdi,rdi
    syscall
