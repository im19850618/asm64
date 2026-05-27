section .data
    magsoom dq 10
    magsoom_alaih dq 2

section .text
    global _start
_start:
    mov rax, [magsoom]
    mov rdx, 0
    mov rcx, [magsoom_alaih]
    div rcx

    mov rax,60
    xor rdi,rdi
    syscall
