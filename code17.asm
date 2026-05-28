section .data
    msg db "Hello", 0xA  ; "Hello" followed by a newline (ASCII 10)
    len equ $ - msg      ; Length of the message
    num db 5             ; Counter initialized to 5

section .text
    global _start

_start:

loop_start:
    ; Write syscall: write(1, msg, len)
    mov rax, 1           ; syscall number for sys_write
    mov rdi, 1           ; file descriptor (stdout)
    mov rsi, msg         ; pointer to message
    mov rdx, len         ; message length
    syscall              ; invoke syscall

    dec byte [num]       ; Decrement counter (treating num as a byte)
    cmp byte [num], 0    ; Compare num with 0
    jg loop_start        ; Jump back if num is greater than zero

    ; Exit syscall: exit(0)
    mov rax, 60          ; syscall number for sys_exit
    xor rdi, rdi         ; exit code 0
    syscall              ; invoke syscall
