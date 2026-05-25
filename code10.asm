; nasm -f elf64 code3.asm -o code3.o
; ld code3.o -o code3
; ./code3

section .bss
    buffer resb 20  ; Reserve space for string conversion
    result resq 1   ; Reserve space for result variable

section .data
    num1 dq 11      ; First number
    num2 dq 999      ; Second number
    newline db 10   ; Newline character

section .text
    global _start

_start:
    ; Load num1 into rax and num2 into rbx
    mov rax, [num1]     ; rax = num1 = 12
    mov rbx, [num2]     ; rbx = num2 = 10
    
    ; Compute result = num1 + num2
    add rax, rbx        ; rax = rax + rbx (12 + 10 = 22)
    mov [result], rax   ; Store result in memory: result = num1 + num2

    ; Load result into rax for conversion
    mov rax, [result]   ; rax = result

    ; Convert result (in rax) to string
    mov rdi, buffer     ; Set destination buffer
    call int_to_str     ; Convert integer to string

    ; Print the result
    mov rsi, buffer     ; String address
    mov rdx, 20         ; Max length
    call print_str      ; Print string

    ; Print newline
    mov rsi, newline    ; Newline character
    mov rdx, 1          ; Length 1
    call print_str      ; Print newline

    ; Exit program
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status 0
    syscall

; Convert integer in RAX to string at RDI
int_to_str:
    mov rbx, 10         ; Divisor for base 10
    mov rcx, 0          ; Counter for digits
    mov r8, rdi         ; Save buffer start pointer

.reverse:
    xor rdx, rdx        ; Clear RDX for division
    div rbx             ; RAX /= 10, remainder in RDX
    add dl, '0'         ; Convert remainder to ASCII
    mov [rdi], dl       ; Store character in buffer
    inc rdi             ; Move buffer pointer forward
    inc rcx             ; Increment digit count
    test rax, rax       ; Check if RAX is zero
    jnz .reverse        ; If not, continue loop

    ; Null-terminate and reverse the string in buffer
    mov byte [rdi], 0   ; Null-terminate the string
    mov rdi, r8         ; Start of string
    mov rsi, rdi        ; Start of string
    add rsi, rcx        ; End of string
    dec rsi             ; Point to last character
    
.reverse_loop:
    cmp rdi, rsi        ; Compare start and end pointers
    jge .done           ; If start >= end, we're done
    mov al, [rdi]       ; Load char from start
    mov bl, [rsi]       ; Load char from end
    mov [rdi], bl       ; Store end char at start
    mov [rsi], al       ; Store start char at end
    inc rdi             ; Move start forward
    dec rsi             ; Move end backward
    jmp .reverse_loop   ; Continue reversing

.done:
    ret

; Print string at RSI with length RDX
print_str:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    syscall
    ret
