; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push esi
    push edi
    ;; recursive bsearch implementation goes here
    ; start is in esi
    mov esi, [ebp + 8]
    ; end is in edi
    mov edi, [ebp + 12]    
    cmp esi, edi
    jg return_bad
    mov ebx, edi
    ; (r - l)
    sub ebx, esi    
    ; (r - l) / 2
    shr ebx, 1        
    ; ebx = l + (r - l) / 2 (mid)
    add ebx, esi    
    ; eax = v[mid]
    mov eax, [ecx + ebx * 4]    
    ; if v[mid] == needle
    cmp eax, edx    
    jz return_good
    cmp eax, edx
    jl search_right
    cmp eax, edx
    jg search_left
search_left:
    dec ebx
    push ebx
    push esi
    call binary_search
    ; restauram stiva
    add esp, 8
    inc ebx
    jmp return_chill
search_right:
    inc ebx
    push edi
    push ebx
    call binary_search
    ; curatam stiva
    add esp, 8
    dec ebx
    jmp return_chill
    ;; restore the preserved registers
return_good:
    pop edi
    pop esi
    mov eax, ebx
    pop ebx
    leave
    ret
return_bad:
    pop edi
    pop esi
    pop ebx
    ; cazul in care nu gasim, returnam 1
    mov eax, -1
    leave
    ret
return_chill:
    pop edi
    pop esi
    pop ebx
    leave
    ret