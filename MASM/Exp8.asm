ASSUME DS:DATA,CS:CODE

DATA SEGMENT
    M1 DB 10,13,"ENTER THE NUMBER: $"
    M2 DB 10,13,"FACTORIAL: $"
    FACT DB 6 DUP(00)
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
    MOV AX,DATA
    MOV DS,AX

    PRTMSG M1
    GETDCM

    MOV CL,AL
    MOV AL,01
    LEA SI,FACT+5 ; Start from the end of the array

LOOP1:
    MUL CL
    ADC AH,0 ; Add any carry to AH
    DEC CL
    JNZ LOOP1

F0:
    MOV [SI],AL
    DEC SI
    MOV [SI],AH

    PRTMSG M2
    LEA SI,FACT+5 ; Start from the end of the array
    PRTDCM
    LOOP F0

    MOV AH,4CH
    INT 21H
CODE ENDS
END START