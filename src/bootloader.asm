org  0x7C00
bits 16

%define ENDL 0X0D, 0X0A ; define a macro for the end of line (need 0X0D AND 0X0A)
start:
    jmp main

puts:

    push si ; push to  the stack
    push ax

.loop: ;inside the loop under puts
    lodsb ; load a byte from ds:si into al and increment si
    or al, al ; set the flags
    jz .done ; if al is zero, we're done
    
    mov ah, 0x0e ; print the character in al
    mov bh, 0 ; page number
    int 0x10 ; call the bios handover to video

    jmp .loop
 .done:
  
    pop ax
    pop si
    ret   

main:
    mov ax, 0   ; we can't use di:ds directly, so we use ax as a temporary register
    mov ds, ax  ;data segment
    mov es, ax  ;call alongside ds
    
    mov ss, ax  ; set the stack segment to where we are loaded
    mov sp, 0x7C00  ; grow downwards from were we are loaded


    mov si, msg_boot    ; hold the address of the string
    call puts

    hlt
.halt:
    jmp .halt

msg_boot:
    db "Hello, World!", 0    
times 510-($-$$) dB 0 
dw 0xAA55
 