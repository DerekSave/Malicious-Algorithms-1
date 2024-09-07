; Hello World Program (Calculating string length)
; Compile with: nasm -f elf32 helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len

SECTION .data
    msg db 'Hello, brave new world!', 0Ah  ; Modify this string freely

SECTION .text
global _start

_start:

    mov ebx, msg         ; Move the address of our message string into EBX
    mov eax, ebx         ; Copy the address in EBX into EAX (Both registers point to the same memory location)

nextchar:
    cmp byte [eax], 0    ; Compare the byte at EAX to zero (the end of the string)
    jz finished          ; If zero (null terminator), jump to 'finished'
    inc eax              ; Otherwise, increment EAX to point to the next byte
    jmp nextchar         ; Repeat the process

finished:
    sub eax, ebx         ; EAX now holds the difference between start and end, i.e., the length of the string

    mov edx, eax         ; Move the calculated length into EDX
    mov ecx, msg         ; Move the string's address into ECX (for sys_write)
    mov ebx, 1           ; Output to stdout (file descriptor 1)
    mov eax, 4           ; Syscall number for sys_write (4)
    int 80h              ; Call the kernel to execute sys_write

    ; Exit the program using sys_exit
    mov ebx, 0           ; Return code 0 (no errors)
    mov eax, 1           ; Syscall number for sys_exit (1)
    int 80h              ; Call the kernel to exit the program
