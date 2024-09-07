; Hello World Program (Getting input)
; Compile with: nasm -f elf32 helloworld-input.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-input.o -o helloworld-input
; Run with: ./helloworld-input

%include 'functions-2.asm'

SECTION .data
msg1    db 'Please enter your name: ', 0h  ; Prompt message
msg2    db 'Hello, ', 0h                   ; Greeting message after user input

SECTION .bss
sinput  resb 255                           ; Reserve 255 bytes for user input

SECTION .text
global _start

_start:

    mov eax, msg1        ; Move the prompt message into EAX
    call sprint          ; Print the prompt

    mov edx, 255         ; Maximum number of bytes to read (buffer size)
    mov ecx, sinput      ; Address of the buffer to store user input
    mov ebx, 0           ; Read from STDIN (file descriptor 0)
    mov eax, 3           ; Syscall number for sys_read
    int 80h              ; Trigger the interrupt to call sys_read

    mov eax, msg2        ; Move the greeting message into EAX
    call sprint          ; Print the greeting

    mov eax, sinput      ; Move the address of the input buffer into EAX
    call sprint          ; Print the user input

    call quit            ; Exit the program
