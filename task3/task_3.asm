%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    push ebp
    mov ebp, esp

    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    ; node we dfs on
    mov ebx, [ebp + 8]    
    ; vizitam
    inc dword [visited + ebx * 4]
    push ebx
    push fmt_str
    ; printam nodul curent
    call printf
    ; restauram valoarea stivei
    add esp, 8
    push ebx
    ; functia primita ca parametru
    call [ebp + 12]
    pop ebx
    ; tinem in ecx nr vecini
    mov ecx, [eax]        
    ; in esi adresa vectorului de vecini
    mov esi, [eax + 4]    
    xor ebx, ebx
traverse_neigh:
    ; for ebx = 0; ebx < ecx; ebx++
    cmp ebx, ecx
    jge end
    ; nod curent in eax
    mov eax, [esi + ebx * 4]
    inc ebx
    ; dimensiunea unui element e de 4
    mov edx, dword [visited + eax * 4]
    test edx, edx
    jnz traverse_neigh
    ; functia primita se afla la adresa ebp + 12
    push dword [ebp + 12]
    push eax
    call dfs
    ; curatam stiva
    add esp, 8
    jmp traverse_neigh
end:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    leave
    ret
