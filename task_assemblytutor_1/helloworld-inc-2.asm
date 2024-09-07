; Hello World Program (NULL terminating bytes)
; Compile with: nasm -f elf32 helloworld-inc.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-inc.o -o helloworld-inc
; Run with: ./helloworld-inc

%include 'functions.asm'

SECTION .data
msg1 db 'Hello, brave new world!', 0Ah, 0h   ; Null terminating byte added
msg2 db 'This is how we recycle in NASM.', 0Ah, 0h  ; Null terminating byte added

SECTION .text
global _start

_start:

    mov eax, msg1    ; Load the address of the first message
    call sprint      ; Print the first message

    mov eax, msg2    ; Load the address of the second message
    call sprint      ; Print the second message

    call quit        ; Exit the program
