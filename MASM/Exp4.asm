ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    M1 DB 10,13,"ENTER THE NUMBER: $"
    M2 DB "ODD$"
    M3 DB "EVEN$"
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

CODE SEGMENT
    START:  MOV AX,DATA
            MOV DS,AX
            PRTMSG M1
            GETDCM
            MOV BL,AL
            GETDCM
            SHR AL,01
            JC ODD
            PRTMSG M3
            JMP DONE

    ODD:    PRTMSG M2
    DONE:   MOV AH,4CH
            INT 21H

CODE ENDS
END START