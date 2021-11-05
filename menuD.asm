section .data
    tit         db  10, '+-------------+',10,'| Calculadora |', 10, '+-------------+', 0
    ltit        equ $ - tit
    obVal1      db  10, 'Valor 1: ', 0
    lobVal1     equ $ - obVal1 
    obVal2      db  10, 'Valor 2: ', 0
    lobVal2     equ $ - obVal2
    opc1        db  10, '1. Somar',0
    lopc1       equ $ - opc1
    opc2        db  10, '2. Subtrair',0
    lopc2       equ $ - opc2
    opc3        db  10, '3. Multiplicar',0
    lopc3       equ $ - opc3
    opc4        db  10, '4. Dividir',0
    lopc4       equ $ - opc4
    msgOpc      db  10, 'Deseja Realizar? ',0
    lmsgOpc     equ $ - msgOpc
    msgErro     db  10, 'Valor da Opção Inválida',0
    lmsgErro    equ $ - msgErro
    salLinha    db  10,0
    lsalLinha   equ $ - salLinha ;SALTAR LINHA

section .bss
    opc     resb 2
    num1    resb 10
    num2    resb 10
    result  resb 10
    
section .text
    global _start

        _start:
            mov ecx, tit
            mov edx, ltit
            call mst_saida

            mov ecx, obVal1
            mov edx, lobVal1
            call mst_saida
            mov ecx, num1
            mov edx, 10
            mov eax, 3
            mov ebx, 0
            int 80h

            mov ecx, obVal2
            mov edx, lobVal2
            call mst_saida
            mov ecx, num2
            mov edx, 10
            mov eax, 3
            mov ebx, 0
            int 80h

            mov ecx, opc1
            mov edx, lopc1
            call mst_saida

            mov ecx, opc2
            mov edx, lopc2
            call mst_saida

            mov ecx, opc3
            mov edx, lopc3
            call mst_saida

            mov ecx, opc4
            mov edx, lopc4
            call mst_saida

            
            mov ecx, msgOpc
            mov edx, lmsgOpc
            call mst_saida
            mov ecx, opc
            mov edx, 2
            mov eax, 3
            mov ebx, 0
            int 80h

            mov ah, [opc]
            sub ah, '0'     ;tira o último zero da String e assim ele deixa de ser uma String

            cmp ah, 1
            je  Somar       ;chama a 'função' somar
            cmp ah, 2
            je  Subtrair    ;chama a 'função' subtrair
            cmp ah, 3
            je  Multiplicar ;chama a 'função' multiplicar
            cmp ah, 4
            je  Dividir     ;chama a 'função' dividir

            mov ecx, msgErro
            mov edx, lmsgErro
            call mst_saida
            jmp exit

        Somar:
            call soma       ;chama a 'função' que fará a soma

            mov ecx, result
            mov edx, 3
            call exibir     ;chama a 'função' que exibe o resultado
            jmp exit        ;pula para a 'função' exit, que encerra o código
        Subtrair:
            call subtrai

            mov ecx, result
            mov edx, 3
            call exibir
            jmp exit    
        Multiplicar:
            call multiplica

            mov ecx, result
            mov edx, 3
            call exibir
            jmp exit
        Dividir:
            call divide

            mov ecx, result
            mov edx, 3
            call exibir
            jmp exit   
        soma:
            mov al, [num1]
            sub al, '0'
            mov bl, [num2]
            sub bl, '0'
            add al, bl
            add al, '0'
            mov [result], al
            ret
        subtrai:
            mov al, [num1]
            sub al, '0'
            mov bl, [num2]
            sub bl, '0'
            sub al, bl
            add al, '0'
            mov [result], al
            ret
        multiplica:
            mov al, [num1]
            sub al, '0'
            mov bl, [num2]
            sub bl, '0'
            mul bl
            add al, '0'
            mov [result], al 
            ret
        divide:
            mov al, [num1]
            sub al, '0'
            mov bl, [num2]
            sub bl, '0'
            mov ah,0 ;zerar o ah
            div bl
            add al, '0'
            mov [result], al
            ret
        exibir:
            mov eax, 4
            mov ebx, 1
            int 80h
            ret 
        exit:
            mov ecx, salLinha
            mov edx, lsalLinha
            call mst_saida
            mov eax, 1
            cmp ebx, ebx
            int 80h

        mst_saida:
            mov eax, 4
            mov ebx, 1
            int 80h
            ret
