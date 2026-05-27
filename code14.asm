section .data
    num1 dq 25      ; Dividend
    num2 dq 4       ; Divisor
    quotient_msg db "Quotient: ", 0
    remainder_msg db "Remainder: ", 0
    newline db 10, 0

section .bss
    quotient resb 20
    remainder resb 20

section .text
    global _start

    ; Convert integer to string
    ; RDI = number, RSI = buffer
    int_to_str:
        mov rax, rdi
        mov rbx, 10
        mov rcx, 0
        mov rdi, rsi
        add rdi, 19
        mov byte [rdi], 0
        dec rdi
    .convert:
        xor rdx, rdx
        div rbx
        add dl, '0'
        mov [rdi], dl
        dec rdi
        inc rcx
        test rax, rax
        jnz .convert
        inc rdi
        ret

    _start:
        ; Load numbers
        mov rax, [num1]  ; Dividend
        mov rbx, [num2]  ; Divisor
        xor rdx, rdx     ; Clear remainder
        div rbx          ; RAX = Quotient, RDX = Remainder

        ; Convert quotient to string
        mov rdi, rax
        mov rsi, quotient
        call int_to_str
        mov rsi, rdi  ; Store converted string in RSI

        ; Print quotient message
        mov rax, 1
        mov rdi, 1
        mov rdx, 10
        mov rsi, quotient_msg
        syscall
        
        ; Print quotient value
        mov rax, 1
        mov rdi, 1
        mov rdx, 20
        mov rsi, quotient
        syscall
        
        ; Print newline
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1
        syscall
        
        ; Convert remainder to string
        mov rdi, rdx
        mov rsi, remainder
        call int_to_str
        mov rsi, rdi  ; Store converted string in RSI

        ; Print remainder message
        mov rax, 1
        mov rdi, 1
        mov rdx, 11
        mov rsi, remainder_msg
        syscall
        
        ; Print remainder value
        mov rax, 1
        mov rdi, 1
        mov rdx, 20
        mov rsi, remainder
        syscall
        
        ; Print newline
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1
        syscall

        ; Exit program
        mov rax, 60
        xor rdi, rdi
        syscall
