ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    M1 DB 10,13,"ENTER THREE NUMBER: $";
    M2 DB 10,13,"AVERAGE: $";
    AVG DB 4 DUP(00)
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
            CLC
            PRTMSG M1
            GETDCM
            MOV BH,AL
            GETDCM
            MOV BL,AL
            GETDCM

            LEA SI,AVG
            MOV AH,00H

            ADD AL,BL
            ADC AL,BH
            MOV AH,00H
            JC CARRY
            MOV CL,03H
            DIV CL
            MOV CH,AH
            JMP LAST

    CARRY:  MOV AH,01H
            MOV DX,0003H
            DIV DX
            

    LAST:   MOV [SI],AL
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