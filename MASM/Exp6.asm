ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    M1 DB 10,13,"ENTER THE NUMBER: $"
    M2 DB 10,13,"SQUARE: $"
    SQU DB 5 DUP(00)
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
            MUL AL
            AAM
            LEA SI,SQU
           

            MOV [SI],AL
            INC SI
            MOV [SI],AH

            PRTMSG M2
            PRTDCM
            DEC SI
            PRTDCM

            MOV AH,4CH
            INT 21H
CODE ENDS
END START 