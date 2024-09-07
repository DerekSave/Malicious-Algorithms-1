; Hello World Program (Print with line feed)
; Compile with: nasm -f elf32 helloworld-lf.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-lf.o -o helloworld-lf
; Run with: ./helloworld-lf

%include 'functions-2.asm'

SECTION .data
msg1 db 'Hello, brave new world!', 0h   ; No linefeed hardcoded here
msg2 db 'This is how we recycle in NASM.', 0h  ; No linefeed hardcoded here

SECTION .text
global _start

_start:

    mov eax, msg1     ; Load address of the first message
    call sprintLF     ; Print the first message with a linefeed

    mov eax, msg2     ; Load address of the second message
    call sprintLF     ; Print the second message with a linefeed

    call quit         ; Exit the program
