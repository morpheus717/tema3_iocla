; subtask 1 - qsort
section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    pusha

    ;; recursive qsort implementation goes here
    ; addr of the array
    mov esi, [ebp + 8]    
    ; left
    mov ecx, [ebp + 12]    
    ; right
    mov edx, [ebp + 16]    
    cmp ecx, edx
    jge return
    ; am pus pe stiva, ecx devine i
    push ecx    
    ; edx devine j
    push edx    
    ; ebx e d = 0
    xor ebx, ebx    
while_loop:
    ; dimensiunea e de 4
    mov eax, [esi + 4 * ecx]
    ; dimensiunea element e de 4
    cmp eax, [esi + 4 * edx]
    jg swap
continue:
    ; i += d
    add ecx, ebx   
    ; d = 1 - d 
    xor ebx, 1
    ; j -= 1 - d
    sub edx, ebx
    ; d = 1 - d   
    xor ebx, 1
    cmp ecx, edx
    jl while_loop
    ; right
    pop eax    
    ; left
    pop ebx 
    ; i - 1
    dec ecx    
    ; i - 1
    push ecx    
    ; left
    push ebx    
    ; v
    push esi    
    call quick_sort
    ; delete params from stack
    add esp, 12    
    ; i = i + 1
    add ecx, 2    
    ; right
    push eax    
    ; i + 1
    push ecx    
    ; v
    push esi    
    call quick_sort
    ; restauram stiva
    add esp, 12
    ;; restore the preserved registers
return:
    popa
    leave
    ret
swap:
    ; swap(v[i], v[j])
    xchg eax, [esi + 4 * edx]    
    ; elementele au dimensiunea de 4 bytes
    mov [esi + 4 * ecx], eax
    ; d = 1 - d
    xor ebx, 1    
    jmp continue