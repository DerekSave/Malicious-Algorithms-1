; Calculator (ATOI)
; Compile with: nasm -f elf32 calculator-atoi.asm
; Link with: ld -m elf_i386 calculator-atoi.o -o calculator-atoi
; Run with: ./calculator-atoi 20 1000 317

%include 'functions.asm'

SECTION .text
global _start

_start:

    pop     ecx             ; first value on the stack is the number of arguments
    pop     edx             ; second value on the stack is the program name (discarded)
    sub     ecx, 1          ; subtract 1 (ignore the program name)
    mov     edx, 0          ; initialize edx to store the sum

nextArg:
    cmp     ecx, 0          ; check if there are any arguments left
    jz      noMoreArgs      ; if no arguments, jump to noMoreArgs
    pop     eax             ; pop the next argument off the stack (ASCII string)
    call    atoi            ; convert the string to an integer using atoi
    add     edx, eax        ; add the converted integer to edx (running total)
    dec     ecx             ; decrement argument counter
    jmp     nextArg         ; repeat the loop for the next argument

noMoreArgs:
    mov     eax, edx        ; move the total sum into eax for printing
    call    iprintLF        ; print the sum followed by a linefeed
    call    quit            ; exit the program
