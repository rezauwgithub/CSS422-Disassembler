*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    MOVE.B  D7,D0
    MOVE.W  D7,D0
    MOVE.L  D7,D0
    ADD.B   #$FF,D3
    MOVEA.L #$6000,A0
    MOVEA.L A0,A2
    MOVE.W  #$1007,(A2)+
    MOVE.W  #$3007,(A2)+
    MOVE.W  #$2007,(A2)+
    MOVE.L  #$060300FF,(A2)+
    MOVE.W  #$4E71,(A2)+
    
    

    MOVEA.L A0,A2
    ;BEGIN TESTING DISASSEMBLER
TESTLOOP
    MOVE.B  (A2),D2
    LSR.L   #$4,D2
                
        
        ;NOP/MOVEM/LEA/CLR/JSR/RTS    
;----------------------    
    CMP.L   #$4,D2
    JSR     NOP_MOVEM_LEA_CLR_JSR_RTS_
;----------------------

        ;MOVE/MOVEA    
;----------------------    
    CMP.L   #$1,D2
    JSR     MOVE_MOVEA_
    CMP.L   #$2,D2
    JSR     MOVE_MOVEA_
    CMP.L   #$3,D2
    JSR     MOVE_MOVEA_
;----------------------

        ;MOVEQ    
;----------------------    
    CMP.L   #$7,D2
    JSR     MOVEQ_
;----------------------

        ;ADD/ADDA    
;----------------------    
    CMP.L   #$D,D2
    JSR     ADD_ADDA_
;----------------------

        ;ADDI   
;----------------------    
    CMP.L   #$0,D2
    JSR     ADDI_
;----------------------
      
        ;ADDQ    
;----------------------    
    CMP.L   #$5,D2
    JSR     ADDQ_
;----------------------
    
        ;SUB    
;----------------------    
    CMP.L   #$9,D2
    JSR     SUB_
;----------------------

        ;MULS_AND    
;----------------------    
    CMP.L   #$C,D2
    JSR     MULS_AND_
;----------------------

        ;OR_DIVU    
;----------------------    
    CMP.L   #$8,D2
    JSR     SUB_
;----------------------

        ;LSd_ASd_ROd    
;----------------------    
    CMP.L   #$E,D2
    JSR     LSd_ASd_ROd_
;----------------------

        ;CMP   
;----------------------    
    CMP.L   #$B,D2
    JSR     CMP_
;----------------------

        ;BCC   
;----------------------    
    CMP.L   #$6,D2
    JSR     BCC_
;----------------------

NOP_MOVEM_LEA_CLR_JSR_RTS_   
    RTS
MOVE_MOVEA_
    RTS
MOVEQ_
    RTS
ADD_ADDA_
    RTS
ADDI_
    RTS
ADDQ_
    RTS
SUB_
    RTS
MULS_AND_
    RTS
OR_DIVU_
    RTS
LSd_ASd_ROd_
    RTS
CMP_
    RTS
BCC_
    RTS
    SIMHALT             ; halt simulator

* Put variables and constants here
USER_INPUT1  DC.B    'Please specify beginning address',0
USER_INPUT2  DC.B    'Please specify ending address',0
*--------------------OPCODES-------------------------------
NOP_OP      DC.B    'NOP',0
MOVE_OP     DC.B    'MOVE',0
MOVEA_OP    DC.B    'MOVEA',0
MOVEQ_OP    DC.B    'MOVEQ',0
MOVEM_OP    DC.B    'MOVEM',0
ADD_OP      DC.B    'ADD',0
ADDA_OP     DC.B    'ADDA',0
ADDI_OP     DC.B    'ADDI',0
ADDQ_OP     DC.B    'ADDQ',0
SUB_OP      DC.B    'SUB',0
MULS_OP     DC.B    'MULS',0
DIVU_OP     DC.B    'DIVU',0
LEA_OP      DC.B    'LEA',0
CLR_OP      DC.B    'CLR',0
AND_OP      DC.B    'AND',0
OR_OP       DC.B    'OR',0
LSL_OP      DC.B    'LSL',0
LSR_OP      DC.B    'LSR',0
ASL_OP      DC.B    'ASL',0
ASR_OP      DC.B    'ASR',0
ROL_OP      DC.B    'ROL',0
ROR_OP      DC.B    'ROR',0
CMP_OP      DC.B    'CMP',0
BCC_OP      DC.B    'BCC',0
JSR_OP      DC.B    'JSR',0
RTS_OP      DC.B    'RTS',0
*-------------------SIZE OF OP-----------------------------
BYTE_SIZE   DC.B    '.B',0
WORD_SIZE   DC.B    '.W',0
LONG_SIZE   DC.B    '.L',0
*--------------------REGISTERS-----------------------------
*ADDRESS REGISTERS...
A0_REG      DC.B    'A0',0
A1_REG      DC.B    'A1',0
A2_REG      DC.B    'A2',0
A3_REG      DC.B    'A3',0
A4_REG      DC.B    'A4',0
A5_REG      DC.B    'A5',0
A6_REG      DC.B    'A6',0
A7_REG      DC.B    'A7',0
*DATA REGISTERS...
D0_REG      DC.B    'D0',0
D1_REG      DC.B    'D1',0
D2_REG      DC.B    'D2',0
D3_REG      DC.B    'D3',0
D4_REG      DC.B    'D4',0
D5_REG      DC.B    'D5',0
D6_REG      DC.B    'D6',0
D7_REG      DC.B    'D7',0
*INDIRECT ADDRESSING...
A0_IN       DC.B    '(A0)',0
A1_IN       DC.B    '(A1)',0
A2_IN       DC.B    '(A2)',0
A3_IN       DC.B    '(A3)',0
A4_IN       DC.B    '(A4)',0
A5_IN       DC.B    '(A5)',0
A6_IN       DC.B    '(A6)',0
A7_IN       DC.B    '(A7)',0
*INDIRECT ADDRESSING WITH PRE-DECREMENT...
A0_IN_PRE   DC.B    '-(A0)',0
A1_IN_PRE   DC.B    '-(A1)',0
A2_IN_PRE   DC.B    '-(A2)',0
A3_IN_PRE   DC.B    '-(A3)',0
A4_IN_PRE   DC.B    '-(A4)',0
A5_IN_PRE   DC.B    '-(A5)',0
A6_IN_PRE   DC.B    '-(A6)',0
A7_IN_PRE   DC.B    '-(A7)',0
*INDIRECT ADDRESSING WITH POST-INCREMENT...
A0_IN_POST  DC.B    '(A0)+',0
A1_IN_POST  DC.B    '(A1)+',0
A2_IN_POST  DC.B    '(A2)+',0
A3_IN_POST  DC.B    '(A3)+',0
A4_IN_POST  DC.B    '(A4)+',0
A5_IN_POST  DC.B    '(A5)+',0
A6_IN_POST  DC.B    '(A6)+',0
A7_IN_POST  DC.B    '(A7)+',0



    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
