section .data
    num dq 8              ; Define a 64-bit number (8)
    buffer db '0', 0xA    ; Buffer to store the ASCII result (newline included)
    len equ 2             ; Length of string to print (1 digit + newline)

section .text
    global _start

_start:
    mov rax, [num]        ; Load num into RAX
    add rax, '0'          ; Convert to ASCII ('0' + 8 = '8')
    mov byte [buffer], al ; ✅ Store only the ASCII character (1 byte)

    ; Write to stdout
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    mov rsi, buffer       ; Pointer to string
    mov rdx, len          ; Length of string
    syscall

    ; Exit
    mov rax, 60           ; sys_exit
    xor rdi, rdi          ; Status 0
    syscall
