;------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
    push    eax             ; preserve eax on the stack
    push    ecx             ; preserve ecx on the stack
    push    edx             ; preserve edx on the stack
    push    esi             ; preserve esi on the stack
    mov     ecx, 0          ; initialize counter to count how many digits we need to print

divideLoop:
    inc     ecx             ; increment counter for each digit
    mov     edx, 0          ; clear edx
    mov     esi, 10         ; divide by 10
    idiv    esi             ; eax = eax / esi, remainder in edx
    add     edx, 48         ; convert remainder to ASCII
    push    edx             ; push the ASCII character onto the stack
    cmp     eax, 0          ; check if there are more digits to divide
    jnz     divideLoop      ; if eax != 0, continue dividing

printLoop:
    dec     ecx             ; decrement counter
    mov     eax, esp        ; get address of the digit on the stack
    call    sprint          ; print the digit
    pop     eax             ; remove digit from the stack
    cmp     ecx, 0          ; check if we have printed all digits
    jnz     printLoop       ; if more digits remain, print them

    pop     esi             ; restore registers
    pop     edx
    pop     ecx
    pop     eax
    ret

;------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
    call    iprint          ; call integer printing function
    push    eax             ; preserve eax
    mov     eax, 0Ah        ; load linefeed character into eax
    push    eax             ; push the linefeed onto the stack
    mov     eax, esp        ; get the address of the linefeed
    call    sprint          ; print the linefeed
    pop     eax             ; remove linefeed from the stack
    pop     eax             ; restore original eax value
    ret
