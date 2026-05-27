section .data
    num1 dq 12345678       ; First number (stored as 64-bit)
    num2 dq 98765432       ; Second number (stored as 64-bit)
    newline db 10          ; Newline character

section .bss
    result resq 1          ; Space to store the result

section .text
    global _start

_start:
    ; Load num1 into RAX
    mov rax, [num1]        
    
    ; Multiply by num2 (RDX:RAX = RAX * Operand)
    mul qword [num2]       
  
    ; Store the result in memory
    mov [result], rax      
    
    ; Convert result to string for printing
    call print_result      

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

print_result:
    ; Convert RAX (result) to string
    mov rsi, result_buffer + 20  ; Point to end of buffer
    mov rcx, 10                  ; Divisor (base 10)
    mov rax, [result]            ; Load result

convert_loop:
    dec rsi                       ; Move buffer pointer back
    xor rdx, rdx                  ; Clear RDX for division
    div rcx                       ; RAX = RAX / 10, RDX = RAX % 10
    add dl, '0'                   ; Convert remainder to ASCII
    mov [rsi], dl                 ; Store character
    test rax, rax                 ; Check if RAX is zero
    jnz convert_loop              ; Repeat if not zero

    ; Print the result
    mov rdx, result_buffer + 20   ; End of buffer
    sub rdx, rsi                  ; Calculate string length
    mov rax, 1                    ; syscall: write
    mov rdi, 1                    ; file descriptor: stdout
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ret

section .bss
    result_buffer resb 21  ; Buffer to store result (max 20 digits)
