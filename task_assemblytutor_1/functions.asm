;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    ebx
    mov     ebx, eax

nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar

finished:
    sub     eax, ebx
    pop     ebx
    ret

;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen

    mov     edx, eax    ; String length in EAX
    pop     eax         ; Restore message address

    mov     ecx, eax    ; Move message address into ECX
    mov     ebx, 1      ; File descriptor (stdout = 1)
    mov     eax, 4      ; Syscall number for sys_write
    int     80h         ; Call kernel

    pop     ebx
    pop     ecx
    pop     edx
    ret

;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint      ; Call the sprint function to print the message

    push    eax         ; Save EAX (message address) on the stack
    mov     eax, 0Ah    ; Move linefeed character (0Ah) into EAX
    push    eax         ; Push the linefeed onto the stack (ESP now points to it)
    mov     eax, esp    ; Move ESP (address of linefeed) into EAX
    call    sprint      ; Call sprint to print the linefeed

    pop     eax         ; Pop the linefeed off the stack
    pop     eax         ; Restore original value of EAX
    ret                 ; Return to the calling code

;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret
;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    ebx
    mov     ebx, eax  ; Store the starting address in EBX

nextchar:
    cmp     byte [eax], 0  ; Compare each byte with 0 (null terminator)
    jz      finished        ; If null terminator, jump to 'finished'
    inc     eax             ; Move to the next byte
    jmp     nextchar        ; Repeat the process

finished:
    sub     eax, ebx        ; Calculate length by subtracting start from current address
    pop     ebx             ; Restore original EBX
    ret                     ; Return length in EAX

;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    edx             ; Save EDX, ECX, EBX, and EAX (used in sys_write)
    push    ecx
    push    ebx
    push    eax
    call    slen            ; Call the slen subroutine to calculate string length

    mov     edx, eax        ; Length of string in EAX
    pop     eax             ; Restore original value of EAX

    mov     ecx, eax        ; Message string address
    mov     ebx, 1          ; File descriptor (stdout = 1)
    mov     eax, 4          ; Syscall number for sys_write
    int     80h             ; Call the kernel to print the string

    pop     ebx             ; Restore EBX, ECX, and EDX
    pop     ecx
    pop     edx
    ret                     ; Return to the calling code

;------------------------------------------
; void quit()
; Exit program and restore resources
quit:
    mov     ebx, 0          ; Exit code 0 (no errors)
    mov     eax, 1          ; Syscall number for sys_exit
    int     80h             ; Call the kernel to exit
    ret                     ; Not really necessary since quit ends the program
