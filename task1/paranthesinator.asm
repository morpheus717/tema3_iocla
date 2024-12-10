; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp

    ; sa-nceapa concursul
    push ebx
    push ecx
    push edx
    push esi
    push edi
    ; pe ebp + 8 se afla stringul
    mov eax, [ebp + 8]
    xor ecx, ecx
    xor edi, edi
determine_size:
    mov bl, byte [eax]
    inc eax
    inc ecx
    test bl, bl
    jnz determine_size
    ; in esi tinem sirul
    mov esi, [ebp + 8] 
    ; plecam de la -1 sa nu mai folosim offset si crestem imediat ce intram in loop
    mov edx, -1
    ; caracterul NULL
    dec ecx        
    ; faptul ca plecam de la -1 ca sa nu folosim offset
    dec ecx        
verify:
    inc edx
    ; caracterul curent
    mov bl, byte [esi + edx]    
    cmp bl, ')'
    jz closed_round
    cmp bl, ']'
    jz closed_other
    cmp bl, '}'
    jz closed_other
    ; caz de deschisa, punem pe stiva
    push ebx    
    inc edi
    cmp edx, ecx
    jl verify
    ; cazul in care am ajuns la final, verificam daca stiva e goala
possibly_good:
    ; daca e nenul
    cmp edi, 0
    jnz bad
good:
    ; inmultim cu 4 ca sa restauram stiva in caz ca a ramas ceva pe ea
    shl edi, 2
    add esp, edi
    xor eax, eax
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

bad:
    ; analog linia 58
    shl edi, 2
    add esp, edi
    ; valoarea de return daca e parantezat gresit
    mov eax, 1
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    ; ) deoarece diferenta cod ascii intre ( si ) e 1
closed_round:    
    ; cazul in care avem inchisa si nu deschisa
    cmp edi, 0    
    jz bad
    pop eax
    dec edi
    inc eax
    cmp eax, ebx
    jnz bad
    cmp edx, ecx
    jl verify
    jmp possibly_good
    ; ] / } deoarece diferente cod ascii intre [ si ] si { si } e 2
closed_other:
    ; analog linia 85
    cmp edi, 0    
    jz bad
    pop eax
    dec edi
    ; diferenta in ascii
    add eax, 2
    cmp eax, ebx
    jnz bad
    cmp edx, ecx
    jl verify
    jmp possibly_good