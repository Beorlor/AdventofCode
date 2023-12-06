section .data
    ; Define race times and record distances
    raceTimes    dw 53, 89, 76, 98    ; Race times for each race
    records      dw 313, 1090, 1214, 1201 ; Record distances for each race
    races        equ 4                ; Total number of races
    result       dd 1                 ; Variable to store the final result
    newline      db 0xA               ; Newline character for output formatting

section .bss
    buffer       resb 32              ; Buffer to store the result as a string

section .text
global _start

_start:
    ; Initialize variables
    xor ebx, ebx                      ; Zero out the race index (ebx)
    mov dword [result], 1             ; Initialize the result to 1

next_race:
    ; Check if all races have been processed
    cmp ebx, races
    jge done                          ; Jump to 'done' if all races are processed
    movzx esi, word [raceTimes + ebx * 2]  ; Load the current race time
    movzx edi, word [records + ebx * 2]    ; Load the current record distance
    xor edx, edx                             ; Zero out the counter for ways to win

    ; Initialize button hold time for the current race
    xor eax, eax

button_loop:
    ; Check if all button hold times have been checked
    cmp eax, esi
    jge update_result

    ; Save current state
    push eax
    push esi

    ; Calculate the distance for the current button hold time
    mov ecx, eax
    sub esi, ecx                           ; Calculate remaining time
    imul ecx, esi                          ; Distance = speed * remaining time
    cmp ecx, edi
    jg increment_win                       ; Increment win count if distance > record

    ; Prepare for the next button hold time
    jmp next_button_time

increment_win:
    ; Increment the win counter for this race
    inc edx

next_button_time:
    ; Restore state and increment button hold time
    pop esi
    pop eax
    inc eax
    jmp button_loop

update_result:
    ; Update the final result
    test edx, edx
    jz no_win_possible
    mov eax, dword [result]
    imul eax, edx
    mov dword [result], eax

no_win_possible:
    ; Move to the next race
    inc ebx
    jmp next_race

done:
    ; Convert the final result to a string
    mov eax, [result]
    mov ebx, 10
    lea esi, [buffer + 31]
    mov byte [esi], 0                      ; Null-terminate the string

convert_to_string:
    ; Convert each digit to ASCII
    xor edx, edx
    div ebx
    add dl, '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz convert_to_string

    ; Write the result string to stdout
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, buffer + 32
    sub edx, ecx
    int 0x80

    ; Write a newline character
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
