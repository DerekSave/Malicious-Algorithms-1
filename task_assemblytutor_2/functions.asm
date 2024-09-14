;------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
    push    eax             ; preserve eax on the stack to be restored after function runs
    push    ecx             ; preserve ecx on the stack to be restored after function runs
    push    edx             ; preserve edx on the stack to be restored after function runs
    push    esi             ; preserve esi on the stack to be restored after function runs
    mov     ecx, 0          ; counter of how many bytes we need to print in the end
 
divideLoop:
    inc     ecx             ; count each byte to print - number of characters
    mov     edx, 0          ; empty edx
    mov     esi, 10         ; mov 10 into esi
    idiv    esi             ; divide eax by esi
    add     edx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    push    edx             ; push edx (string representation of an intger) onto the stack
    cmp     eax, 0          ; can the integer be divided anymore?
    jnz     divideLoop      ; jump if not zero to the label divideLoop
 
printLoop:
    dec     ecx             ; count down each byte that we put on the stack
    mov     eax, esp        ; mov the stack pointer into eax for printing
    call    sprint          ; call our string print function
    pop     eax             ; remove last character from the stack to move esp forward
    cmp     ecx, 0          ; have we printed all bytes we pushed onto the stack?
    jnz     printLoop       ; jump is not zero to the label printLoop
 
    pop     esi             ; restore esi from the value we pushed onto the stack at the start
    pop     edx             ; restore edx from the value we pushed onto the stack at the start
    pop     ecx             ; restore ecx from the value we pushed onto the stack at the start
    pop     eax             ; restore eax from the value we pushed onto the stack at the start
    ret
 
 
;------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
    call    iprint          ; call our integer printing function
 
    push    eax             ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     eax, 0Ah        ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push    eax             ; push the linefeed onto the stack so we can get the address
    mov     eax, esp        ; move the address of the current stack pointer into eax for sprint
    call    sprint          ; call our sprint function
    pop     eax             ; remove our linefeed character from the stack
    pop     eax             ; restore the original value of eax before our function was called
    ret
 
 
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
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
    pop     ebx
    pop     ecx
    pop     edx
    ret
 
 
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
 
    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret
 
 
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret
;------------------------------------------
; int atoi(Integer number)
; Ascii to integer function (atoi)
atoi:
    push    ebx             ; preserve ebx on the stack
    push    ecx             ; preserve ecx on the stack
    push    edx             ; preserve edx on the stack
    push    esi             ; preserve esi on the stack
    mov     esi, eax        ; move pointer in eax into esi (our number to convert)
    mov     eax, 0          ; initialize eax with decimal value 0
    mov     ecx, 0          ; initialize ecx with decimal value 0

.multiplyLoop:
    xor     ebx, ebx        ; reset ebx to 0
    mov     bl, [esi+ecx]   ; move a single byte (character) into ebx
    cmp     bl, 48          ; check if character is '0'
    jl      .finished       ; jump to finished if character is less than '0'
    cmp     bl, 57          ; check if character is '9'
    jg      .finished       ; jump to finished if character is greater than '9'

    sub     bl, 48          ; convert ASCII character to its integer value
    add     eax, ebx        ; add converted digit to result in eax
    mov     ebx, 10         ; prepare for multiplying by 10
    mul     ebx             ; multiply eax by 10 to shift place value
    inc     ecx             ; move to the next character
    jmp     .multiplyLoop   ; repeat for next character

.finished:
    cmp     ecx, 0          ; check if we converted any digits
    je      .restore        ; if no digits, return 0
    mov     ebx, 10         ; divide eax by 10 to adjust the last multiply
    div     ebx             ; correct the result

.restore:
    pop     esi             ; restore saved registers
    pop     edx
    pop     ecx
    pop     ebx
    ret                     ; return the result in eax
