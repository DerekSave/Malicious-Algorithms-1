; Calculator (Addition)
; Compile with: nasm -f elf32 calculator-addition.asm
; Link with: ld -m elf_i386 calculator-addition.o -o calculator-addition
; Run with: ./calculator-addition

%include 'functions.asm'   ; Include our functions file with iprintLF and quit

SECTION .text
global _start

_start:

    mov eax, 90      ; Move the first number (90) into EAX
    mov ebx, 9       ; Move the second number (9) into EBX
    add eax, ebx     ; Add EBX to EAX (90 + 9)
    call iprintLF    ; Print the result (99) followed by a linefeed

    call quit        ; Exit the program
