; Calculator (Subtraction)
; Compile with: nasm -f elf32 calculator-subtraction.asm
; Link with: ld -m elf_i386 calculator-subtraction.o -o calculator-subtraction
; Run with: ./calculator-subtraction

%include 'functions.asm'   ; Include the functions for integer printing and quitting

SECTION .text
global _start

_start:

    mov eax, 90      ; Load the first number (90) into EAX
    mov ebx, 9       ; Load the second number (9) into EBX
    sub eax, ebx     ; Subtract EBX from EAX (90 - 9)
    call iprintLF    ; Print the result (81) followed by a linefeed

    call quit        ; Exit the program
