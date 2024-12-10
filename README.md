# Tema 3

## Task 1
Incepem prin a pune pe stiva registrii pentru a ii salva. In eax tinem adresa elementului din sirul de caractere. Din moment ce lucram cu siruri de caractere, crestem valoarea registrului eax cu 1. Primul lucru determinam lungimea sirului parcurgandu-l pana gasim caracterul NULL. Ulterior, parcurgem din nou sirul, de data asta il tinem in esi cum ar face un om sanatos. In caz de paranteza deschisa punem pe stiva. In caz de paranteza inchisa mergem la labelul corespunzator. Motivul pentru care avem doua labeluri este ca in caul parantezelor patrate sau acolade diferenta de codd ascii e de 2 in timp ce in cazul parantezelor rotunde e de 1. In final, cand am ajuns la finalul sirului dam de eticheta possibly_good, in care verificam daca ne-a ramas vreo paranteza deschisa pe stiva. Daca da, sarim la bad, daca nu, programul ajunge singur la good de unde se da return.

## Task 2
### Subtask 1
Stocam in esi adresa vectorului, in ecx limita stanga si in edx limita dreapta. Incepem prin a verifica conditia de return, apoi punem pe stiva valorile ecx si edx pentru a le salva caci vom avea nevoie de ele din nou si continuam in ceea ce simuleaza un loop while. Apoi, continuam algoritmul prin a compara cu pivotul si a face interschimbarile necesare. Apoi, recuperam valorile stanga si dreapta de pe stiva, scadem din ecx 1 si apoi punem pe stiva valorile invers de cum le primeste functia si o apelam pentru intervalul (stanga, i - 1). Facem acelasi lucru pentru (i + 1, dreapta).
### Subtask 2
Incepem prin a salva de data asta nu toti registrii pe stiva ci doar ebx, esi si edi pentru ca eax este return value, iar datorita fastcall ecx si edx retin intotdeauna primul, respectiv al doilea parametru al functiei. In esi retinem capatul din stanga iar in edi cel din dreapta al apelului. Dupa ce verificam conditia de esuat, continuam prin a calcula mijlocul si a cauta la stanga sau la dreapta, dupa caz. Exista 3 cazuri de return. Return bad gestioneaza lipsa elementului in vector si returneaza -1, return good returneaza valoarea lui ebx care este mijlocul intervalului, iar return chill curata stiva si nu modifica cu nimic valoarea de return.

## Task 3
Incepem prin a salva valorile pe stiva la intrarea in apel. In ebs retinem nodul pe care facem parcurgerea. Primul lucru, il vizitam si il afisam. Apoi, chemam functia primita ca parametru pentru a afla lista de vecini a nodului. Retinem in esi adresa de return a functiei tocmai apelate, adica vectorul de vecini. Incepem sa parcurgem vecinii, daca ese vizitat, continuam, daca nu, transmitem parametrii pe stiva si apelam dfs pe vecinul curent. In final, curatam stiva.