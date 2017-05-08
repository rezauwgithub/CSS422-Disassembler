*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
* Put program code here
    MOVE.B  #2,D0           ;USER INPUT
    TRAP    #15             ;GET USER INPUT
    MOVE.L  #$00006000,A2   ;STRING BUILDER
    MOVEA.L A2,A3
LOOP
    CMPI.B  #$00,(A1)
    BEQ     DONE
    MOVE.B  (A1)+,D2
    LEA     ASCII_HEX,A0
    MOVE.B  (0,A0,D2),D3
    LSL.B   #$4,D3
    MOVE.B  (A1)+,D2
    ADD.B   (0,A0,D2),D3
    MOVE.B  D3,(A3)+
    BRA     LOOP
    SIMHALT             ; halt simulator
DONE
    MOVE.L  (A2),STARTING_ADDR
    MOVE.B  #9,D0
    TRAP    #15

* Put variables and constants here
STARTING_ADDR   DS.L    1
    ORG    $5000
ASCII_HEX
    DCB.B   48,0
    DC.B    $0  
    DC.B    $1
    DC.B    $2
    DC.B    $3
    DC.B    $4
    DC.B    $5
    DC.B    $6
    DC.B    $7
    DC.B    $8
    DC.B    $9
    DCB.B   7,0
    DC.B    $A
    DC.B    $B
    DC.B    $C
    DC.B    $D
    DC.B    $E
    DC.B    $F
    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
