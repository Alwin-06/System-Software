ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    M1 DB 10,13,"ENTER FIRST NUMBER: $"
    M2 DB 10,13,"ENTER SECOND NUMBER: $"
    M3 DB 10,13,"PRODUCT: $"
    PROD DB 3 DUP(00H)
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
            MOV BH,AL
            GETDCM
            MOV BL,AL
            PRTMSG M2
            GETDCM
            MOV CH,AL
            GETDCM
            MOV CL,AL

            LEA SI,PROD
            MOV AH,00H

            MUL BL
            AAM
            MOV [SI],AL
            INC SI
            MOV [SI],AH
            MOV AH,00H

            MOV AL,BH
            MUL CL
            AAM
            MOV DL,AL
            MOV DH,AH
            ADD DL,[SI]
            MOV AH,00H

            MOV AL,BL
            MUL CH
            AAM
            ADD DL,AL
            DEC SI
            INC SI
            MOV [SI],DL
            ADD DH,AH
            MOV AH,00H

            MOV AL,BH
            MUL CH
            AAM
            ADD DH,AL
            INC SI
            MOV [SI],DH
            INC SI
            MOV [SI],AH
            PRTMSG M3
            PRTDCM
            DEC SI
            PRTDCM
            DEC SI
            PRTDCM
            DEC SI
            PRTDCM
            MOV AH,4CH
            INT 21H
CODE ENDS
END START
