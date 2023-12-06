section .data
    raceTimes    dw 53, 89, 76, 98    ; Définit les temps de course pour chaque course
    records      dw 313, 1090, 1214, 1201 ; Définit les distances record pour chaque course
    races        equ 4                ; Définit le nombre total de courses (une constante)
    result       dd 1                 ; Initialise une variable 'result' avec la valeur 1
    newline      db 0xA               ; Stocke le caractère de nouvelle ligne (ASCII 10) pour la mise en forme

section .bss
    buffer       resb 32              ; Réserve un espace de 32 octets pour 'buffer' (pour stocker le résultat en chaîne)

section .text
global _start                         ; Déclare un point d'entrée global '_start'

_start:
    xor ebx, ebx                      ; Met à zéro le registre EBX (utilisé comme index de course)
    mov dword [result], 1             ; Initialise 'result' avec la valeur 1

next_race:
    cmp ebx, races                    ; Compare l'index de course actuel avec le nombre total de courses
    jge done                          ; Saute à l'étiquette 'done' si toutes les courses sont traitées
    movzx esi, word [raceTimes + ebx * 2]  ; Charge le temps de la course actuelle dans ESI
    movzx edi, word [records + ebx * 2]    ; Charge la distance record de la course actuelle dans EDI
    xor edx, edx                      ; Met à zéro EDX, qui comptera les façons de gagner

    xor eax, eax                      ; Met à zéro EAX, utilisé pour le temps de maintien du bouton

button_loop:
    cmp eax, esi                      ; Compare le temps de maintien avec le temps de la course
    jge update_result                 ; Saute à 'update_result' si toutes les durées sont vérifiées

    push eax                          ; Sauvegarde EAX (temps de maintien du bouton)
    push esi                          ; Sauvegarde ESI (temps de course restant)

    mov ecx, eax                      ; Copie EAX dans ECX
    sub esi, ecx                      ; Soustrait ECX de ESI (temps restant)
    imul ecx, esi                     ; Multiplie ECX et ESI (calcule la distance)
    cmp ecx, edi                      ; Compare la distance calculée à la distance record
    jg increment_win                  ; Saute à 'increment_win' si la distance est supérieure au record

    jmp next_button_time              ; Passe au prochain temps de maintien du bouton

increment_win:
    inc edx                           ; Incrémente EDX (nombre de façons de gagner)

next_button_time:
    pop esi                           ; Restaure ESI
    pop eax                           ; Restaure EAX
    inc eax                           ; Incrémente EAX (temps de maintien du bouton)
    jmp button_loop                   ; Revient au début de la boucle des boutons

update_result:
    test edx, edx                     ; Vérifie si EDX est zéro
    jz no_win_possible                ; Saute à 'no_win_possible' si pas de victoire possible
    mov eax, dword [result]           ; Charge 'result' dans EAX
    imul eax, edx                     ; Multiplie EAX par EDX
    mov dword [result], eax           ; Stocke le résultat dans 'result'

no_win_possible:
    inc ebx                           ; Incrémente EBX (passe à la course suivante)
    jmp next_race                     ; Revient au début de la boucle des courses

done:
    mov eax, [result]                 ; Charge le résultat final dans EAX
    mov ebx, 10                       ; Définit EBX à 10 (pour la conversion en base 10)
    lea esi, [buffer + 31]            ; Positionne ESI à la fin du buffer
    mov byte [esi], 0                 ; Place un caractère nul à la fin du buffer (fin de chaîne)

convert_to_string:
    xor edx, edx                      ; Met à zéro EDX
    div ebx                           ; Divise EAX par EBX, résultat dans EAX, reste dans EDX
    add dl, '0'                       ; Convertit le reste en caractère ASCII
    dec esi                           ; Décrémente ESI (recule dans le buffer)
    mov [esi], dl                     ; Place le caractère dans le buffer
    test eax, eax                     ; Vérifie si EAX est non nul
    jnz convert_to_string             ; Continue la conversion si EAX est non nul

    mov eax, 4                        ; Prépare l'appel système pour écrire (syscall write)
    mov ebx, 1                        ; Définit le descripteur de fichier (1 pour stdout)
    mov ecx, esi                      ; Met l'adresse du début de la chaîne dans ECX
    mov edx, buffer + 32              ; Calcule la longueur de la chaîne
    sub edx, ecx                      ; Soustrait l'adresse de début de la longueur totale
    int 0x80                          ; Appel système pour écrire la chaîne

    mov eax, 4                        ; Prépare un autre appel système pour écrire
    mov ebx, 1                        ; Descripteur de fichier pour stdout
    mov ecx, newline                  ; Adresse du caractère de nouvelle ligne
    mov edx, 1                        ; Longueur du texte à écrire (1 caractère)
    int 0x80                          ; Appel système pour écrire la nouvelle ligne

    mov eax, 1                        ; Prépare l'appel système pour quitter (syscall exit)
    xor ebx, ebx                      ; Met à zéro EBX (code de sortie)
    int 0x80                          ; Appel système pour quitter le programme

