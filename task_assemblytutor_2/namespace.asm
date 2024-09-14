; Namespace Example in Assembly
; Compile with: nasm -f elf32 namespace.asm
; Link with: ld -m elf_i386 namespace.o -o namespace
; Run with: ./namespace

%include 'functions.asm'

SECTION .data
msg1    db 'Jumping to finished label.', 0h  ; Message 1
msg2    db 'Inside subroutine number: ', 0h  ; Message 2
msg3    db 'Inside subroutine "finished".', 0h  ; Message 3

SECTION .text
global _start

_start:

subrountineOne:
    mov eax, msg1       ; Move msg1 into eax
    call sprintLF       ; Print msg1 with a linefeed
    jmp .finished       ; Jump to the local label .finished under subroutineOne

.finished:
    mov eax, msg2       ; Move msg2 into eax
    call sprint         ; Print msg2 (no linefeed)
    mov eax, 1          ; Load the value 1 into eax (subroutine number)
    call iprintLF       ; Print the number 1 with a linefeed

subrountineTwo:
    mov eax, msg1       ; Move msg1 into eax
    call sprintLF       ; Print msg1 with a linefeed
    jmp .finished       ; Jump to the local label .finished under subroutineTwo

.finished:
    mov eax, msg2       ; Move msg2 into eax
    call sprint         ; Print msg2 (no linefeed)
    mov eax, 2          ; Load the value 2 into eax (subroutine number)
    call iprintLF       ; Print the number 2 with a linefeed

    mov eax, msg1       ; Print msg1 one more time
    call sprintLF       ; Print msg1 with a linefeed
    jmp finalFinished   ; Jump to the new global label finalFinished

finalFinished:            ; Renamed global label
    mov eax, msg3       ; Move msg3 into eax
    call sprintLF       ; Print msg3 with a linefeed
    call quit           ; Exit the program
