ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    M1 DB 10,13,"ENTER TWO NUMBER: $";
    M2 DB 10,13,"SUBTRATION: $";
    SUBT DB 4 DUP(00)
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
    START:  MOV AX,DATA
            MOV DS,AX
            PRTMSG M1
            GETDCM
            MOV BL,AL
            GETDCM

            LEA SI,SUBT
            MOV AH,00H

            SUB BL,AL
            MOV [SI],BL
            PRTMSG M2
            PRTDCM

            MOV AH,4CH
            INT 21H
CODE ENDS
END START