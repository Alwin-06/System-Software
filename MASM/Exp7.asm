ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    M1 DB 10,13,"ENTER A STRING: $"
    M2 DB 10,13,"PALINDROME$"
    M3 DB 10,13,"NOT A PALINDROME$"
    STRING DB 20 DUP('$')
DATA ENDS

PRTMSG MACRO MESSAGE
    LEA DX,MESSAGE
    MOV AH,09
    INT 21H
    ENDM  

GETDCM MACRO  
    MOV AH,01
    INT 21H
    SUB AL,30H
    ENDM

PRTDCM MACRO
    MOV DL,[SI]
    ADD DL,30H
    MOV AH,02
    INT 21H
    ENDM

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX

    PRTMSG M1
    LEA SI, STRING
    
    INPUT_LOOP:
        MOV AH, 01H
        INT 21H
        CMP AL, 0DH
        JZ END_INPUT
        MOV [SI], AL
        INC SI
        JMP INPUT_LOOP

    END_INPUT:
    MOV [SI], '$'
    DEC SI

    LEA DI, STRING

    CHECK_PALINDROME:
        MOV AL, [SI]
        MOV BL, [DI]
        CMP AL, BL
        JNZ NOT_PALINDROME
        DEC SI
        INC DI
        CMP SI, DI
        JB PALINDROME
        JMP CHECK_PALINDROME

    NOT_PALINDROME:
        PRTMSG M3
        JMP END_PROGRAM

    PALINDROME:
        PRTMSG M2

    END_PROGRAM:
        MOV AH, 4CH
        INT 21H
CODE ENDS
END START