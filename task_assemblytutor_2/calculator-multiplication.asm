; Calculator (Multiplication)
; Compile with: nasm -f elf32 calculator-multiplication.asm
; Link with: ld -m elf_i386 calculator-multiplication.o -o calculator-multiplication
; Run with: ./calculator-multiplication

%include 'functions.asm'   ; Include functions for integer printing and quitting

SECTION .text
global _start

_start:

    mov eax, 90      ; Load the first number (90) into EAX
    mov ebx, 9       ; Load the second number (9) into EBX
    mul ebx          ; Multiply EAX by EBX (90 * 9)
    call iprintLF    ; Print the result (810) followed by a linefeed

    call quit        ; Exit the program
