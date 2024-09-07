; Hello World Program (Count to 10)
; Compile with: nasm -f elf32 helloworld-10.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-10.o -o helloworld-10
; Run with: ./helloworld-10

%include 'functions-2.asm'

SECTION .text
global _start

_start:

    mov ecx, 0          ; Initialize ecx to 0

nextNumber:
    inc ecx             ; Increment ecx

    cmp ecx, 10         ; Check if ecx is less than 10
    jl oneDigit         ; Jump if ecx is a one-digit number (less than 10)

    ; Handling two-digit numbers (10 and above)
    mov eax, ecx        ; Copy ecx to eax
    mov ebx, 10         ; Load 10 into ebx for division

    div ebx             ; Divide eax by 10, quotient in AL and remainder in AH

    add al, 48          ; Convert quotient (tens digit) to ASCII
    push eax            ; Push the tens digit onto the stack
    mov eax, esp        ; Get the address of the tens digit
    call sprint         ; Print the tens digit
    pop eax             ; Clean up the stack

    mov al, ah          ; Move the remainder (ones digit) to AL
    add al, 48          ; Convert ones digit to ASCII
    push eax            ; Push the ones digit onto the stack
    mov eax, esp        ; Get the address of the ones digit
    call sprintLF       ; Print the ones digit with a linefeed
    pop eax             ; Clean up the stack

    jmp checkExit       ; Jump to check if we should exit

oneDigit:
    mov eax, ecx        ; Move ecx into eax
    add eax, 48         ; Convert the number to ASCII (0-9)
    push eax            ; Push the number onto the stack
    mov eax, esp        ; Get the address of the number on the stack
    call sprintLF       ; Print the number with a linefeed
    pop eax             ; Clean up the stack

checkExit:
    cmp ecx, 10         ; Have we reached 10 yet?
    jne nextNumber      ; If not, keep counting

    call quit           ; Exit the program
