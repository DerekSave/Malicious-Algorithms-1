; Hello World Program (Passing arguments from the command line)
; Compile with: nasm -f elf32 helloworld-args.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-args.o -o helloworld-args
; Run with: ./helloworld-args "This is one argument" "This is another" 101

%include 'functions-2.asm'

SECTION .text
global _start

_start:

    pop ecx            ; First value on the stack is the number of arguments

nextArg:
    cmp ecx, 0h        ; Check if we have any arguments left
    jz noMoreArgs      ; If ECX is 0, jump to noMoreArgs (end of loop)
    pop eax            ; Pop the next argument off the stack
    call sprintLF      ; Print the argument with a linefeed
    dec ecx            ; Decrement ECX (number of arguments left)
    jmp nextArg        ; Jump back to process the next argument

noMoreArgs:
    call quit          ; Exit the program
