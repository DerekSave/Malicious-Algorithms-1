; Calculator (Division)
; Compile with: nasm -f elf32 calculator-division.asm
; Link with: ld -m elf_i386 calculator-division.o -o calculator-division
; Run with: ./calculator-division

%include 'functions.asm'   ; Include functions for integer and string printing

SECTION .data
msg1    db ' remainder ', 0h   ; A message string to correctly output result

SECTION .text
global _start

_start:

    mov eax, 90      ; Load the first number (90) into EAX
    mov ebx, 9       ; Load the second number (9) into EBX
    div ebx          ; Divide EAX by EBX (90 / 9)
    call iprint      ; Print the quotient (10)
    
    mov eax, msg1    ; Move the message ' remainder ' into EAX
    call sprint      ; Print the string ' remainder '
    
    mov eax, edx     ; Move the remainder (stored in EDX) into EAX
    call iprintLF    ; Print the remainder (0) followed by a linefeed

    call quit        ; Exit the program
