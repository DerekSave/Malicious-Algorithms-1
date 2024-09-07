; Hello World Program (Subroutines)
; Compile with: nasm -f elf32 helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len

SECTION .data
    msg db 'Hello, brave new world!', 0Ah  ; Our message with a newline character

SECTION .text
global _start

_start:

    mov eax, msg        ; Move the address of our message string into EAX
    call strlen         ; Call our subroutine to calculate the length of the string

    ; After returning from the subroutine, EAX contains the length
    mov edx, eax        ; Move the string length into EDX (required by sys_write)
    mov ecx, msg        ; Move the string's address into ECX
    mov ebx, 1          ; File descriptor for stdout (1 = console)
    mov eax, 4          ; Syscall number for sys_write
    int 80h             ; Call the kernel to execute sys_write

    ; Exit the program
    mov ebx, 0          ; Return code 0 (no errors)
    mov eax, 1          ; Syscall number for sys_exit
    int 80h             ; Call the kernel to exit

; Subroutine to calculate string length
strlen:
    push ebx            ; Save EBX (since we'll use it in the subroutine)
    mov ebx, eax        ; Copy the address in EAX into EBX (both point to the start of the string)

nextchar:
    cmp byte [eax], 0   ; Compare the byte at EAX to 0 (null terminator)
    jz finished         ; If null terminator is found, jump to 'finished'
    inc eax             ; Otherwise, increment EAX to move to the next character
    jmp nextchar        ; Repeat the process

finished:
    sub eax, ebx        ; Calculate the length of the string by subtracting EBX from EAX
    pop ebx             ; Restore the original value of EBX
    ret                 ; Return to the point where the subroutine was called
