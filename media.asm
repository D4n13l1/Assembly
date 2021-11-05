segment .data
    LF equ 0xa          ;line feed
    SYS_CALL equ 0x80   ;envia informação ao SO
    NULL equ 0xd        ;final da string
    ; EAX
    SYS_EXIT equ 0x1    ;codigo de chamadapara finalizar
    RET_EXIT equ 0x0    ;operação realizada com sucesso
    SYS_READ equ 0x3    ;operação de leitura
    SYS_WRITE equ 0x4   ;operação de escrita
    ; EBX
    RET_EXIT equ 0x0    ;operação realizada com sucesso
    STD_IN equ 0x0      ;entrada padrão
    STD_OUT equ 0x1     ;saída padrão

section .data
    msg db "Entre com seu nome: ", LF, NULL
    tam equ $- msg
    msg1 db "Nota 1: ", LF, NULL
    tam1 equ $- msg1
    msg2 db "Nota 2: ", LF, NULL
    tam2 equ $- msg2
    msg3 db "Nota 3: ", LF, NULL
    tam3 equ $- msg3
    msg4 db "Nota 4: ", LF, NULL
    tam4 equ $- msg4
    msgR db "Aluno Reprovado", LF, NULL
    tamR equ $- msgR
    msgA db "Aluno Aprovado", LF, NULL
    tamA equ $- msgA

section .bss
    nome RESB 2
    n1  RESB 1
    n2  RESB 1    
    n3  RESB 1
    n4  RESB 1
    sumf    RESB 2
    sum1    RESB 3
    sum2    RESB 3
    divis RESB 2

section .text
global _start
_start:
    mov eax, SYS_WRITE  ;escreve "Digite seu nome"
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, tam
    int SYS_CALL

    mov eax, SYS_READ   ;lê nome
    mov ebx, STD_IN
    mov ecx, nome
    mov edx, 7
    int SYS_CALL

    mov eax, SYS_WRITE  ;escrevre "nota 1"
    mov ebx, STD_OUT
    mov ecx, msg1
    mov edx, tam1
    int SYS_CALL

    mov eax, SYS_READ   ;obtem n1
    mov ebx, STD_IN
    mov ecx, n1
    mov edx, 0xa
    int SYS_CALL
    
    mov eax, SYS_WRITE  ;escrevre "nota 2"
    mov ebx, STD_OUT
    mov ecx, msg2
    mov edx, tam2
    int SYS_CALL

    mov eax, SYS_READ   ;obtem n2
    mov ebx, STD_IN
    mov ecx, n2
    mov edx, 0xa
    int SYS_CALL

    mov eax, SYS_WRITE  ;escrevre "nota 3"
    mov ebx, STD_OUT
    mov ecx, msg3
    mov edx, tam3
    int SYS_CALL

    mov eax, SYS_READ   ;obtem n3
    mov ebx, STD_IN
    mov ecx, n3
    mov edx, 0xa
    int SYS_CALL

    mov eax, SYS_WRITE  ;escrevre "nota 4"
    mov ebx, STD_OUT
    mov ecx, msg4
    mov edx, tam4
    int SYS_CALL

    mov eax, SYS_READ   ;obtem n4
    mov ebx, STD_IN
    mov ecx, n4
    mov edx, 0xa
    int SYS_CALL

    mov al, [n1]      ;somar
    sub al, '0'
    mov bl, [n2]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sum1], al
    int SYS_CALL

    mov al, [n3]
    sub al, '0'
    mov bl, [n4]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sum2], al
    int SYS_CALL

    mov al, [sum1]
    sub al, '0'
    mov bl, [sum2]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sumf], al
    int SYS_CALL

    mov al, [sumf]      ;dividir por 4
    sub al, '0'
    mov bl, '4'
    sub bl, '0'
    mov ah,0 ;zerar o ah
    div bl
    add al, '0'
    mov [divis], al

    ; mov eax, SYS_WRITE  ;mostrar resultado teste
    ; mov ebx, STD_OUT
    ; mov ecx, divis
    ; mov edx, 3
    ; int SYS_CALL

    mov eax, DWORD [divis]
    mov edx, DWORD '5'
    cmp eax, edx
    jge maior
    mov ecx, msgR
    mov edx, tamR
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL
    
    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL

    maior:
        mov ecx, msgA
        mov edx, tamA
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        int SYS_CALL
        mov eax, SYS_EXIT
        mov ebx, RET_EXIT
        int SYS_CALL
