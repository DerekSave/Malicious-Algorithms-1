; Hello World Program (External file include)
; Compile with: nasm -f elf32 helloworld-inc.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-inc.o -o helloworld-inc
; Run with: ./helloworld-inc

%include 'functions.asm'   ; Include the external file with subroutines

SECTION .data
msg1 db 'Hello, brave new world!', 0Ah   ; Our first message string
msg2 db 'This is how we recycle in NASM.', 0Ah   ; Our second message string

SECTION .text
global _start

_start:

    mov eax, msg1   ; Move the address of the first message string into EAX
    call sprint     ; Call our string printing function

    mov eax, msg2   ; Move the address of the second message string into EAX
    call sprint     ; Call the string printing function again

    call quit       ; Call our quit function to exit the program
