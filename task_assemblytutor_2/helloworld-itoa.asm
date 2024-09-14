; Hello World Program (Count to 10 itoa)
; Compile with: nasm -f elf32 helloworld-itoa.asm
; Link with: ld -m elf_i386 helloworld-itoa.o -o helloworld-itoa
; Run with: ./helloworld-itoa

%include 'functions.asm'

SECTION .text
global _start

_start:

    mov ecx, 0           ; initialize counter

nextNumber:
    inc ecx              ; increment counter
    mov eax, ecx         ; move counter value to eax
    call iprintLF        ; call integer printing function with linefeed
    cmp ecx, 10          ; check if counter is 10
    jne nextNumber       ; if not, repeat the loop

    call quit            ; exit the program
