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
    START:  MOV AX,DATA
            MOV DS,AX

            PRTMSG M1
            GETDCM

            MOV CL,AL
            MOV AL,01

            LEA SI,FACT
            MOV AH,00

    LOOP1:  MUL CL
            AAM
            DEC CL
            JZ F0 
            JMP LOOP1

    F0:     MOV [SI],AL
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