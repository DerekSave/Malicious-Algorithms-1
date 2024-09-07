; Hello World Program - asmtutor.com
; Compile with: nasm -f elf32 helloworld.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld.o -o helloworld
; Run with: ./helloworld

SECTION .data
    msg db 'Hello World!', 0Ah  ; Define the message with a newline character

SECTION .text
global _start

_start:
    ; sys_write system call
    mov edx, 13         ; Length of the message
    mov ecx, msg        ; Address of the message
    mov ebx, 1          ; File descriptor (1 = stdout)
    mov eax, 4          ; Syscall number for sys_write (4)
    int 80h             ; Trigger the interrupt to call the system

    ; sys_exit system call
    mov ebx, 0          ; Exit status (0 = no errors)
    mov eax, 1          ; Syscall number for sys_exit (1)
    int 80h             ; Trigger the interrupt to call the system
