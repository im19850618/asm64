section .data
    msg db "Hello", 0xA  ; "Hello" followed by a newline (ASCII 10)
    len equ $ - msg      ; Length of the message
    i db 5             ; Counter initialized to 5

section .text
    global _start

_start:
    ;mov rcx,5
loop_start:
    ; Write syscall: write(1, msg, len)
    mov rax, 1           ; syscall number for sys_write
    mov rdi, 1           ; file descriptor (stdout)
    mov rsi, msg         ; pointer to message
    mov rdx, len         ; message length
    syscall              ; invoke syscall

    ;dec rcx

    dec byte [i]       ; Decrement counter (treating num as a byte)
    cmp byte [i], 0    ; Compare num with 0
    jg loop_start        ; Jump back if num is greater than zero
    ; jnz loop_start
    ; loop loop_start     ;rcx-1<>0 --> loop_start

    ; Exit syscall: exit(0)
    mov rax, 60          ; syscall number for sys_exit
    xor rdi, rdi         ; exit code 0
    syscall              ; invoke syscall
