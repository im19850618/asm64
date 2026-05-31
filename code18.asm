section .data
    num db 3

section .text
    global _start

_start:
loop_start:
    dec byte [num]
    cmp byte [num],0
    je exiting
loop loop_start

exiting:
    ; Exit syscall: exit(0)
    mov rax, 60          ; syscall number for sys_exit
    xor rdi, rdi         ; exit code 0
    syscall              ; invoke syscall
