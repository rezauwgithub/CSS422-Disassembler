*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    LEA USER_INPUT1,A1
    MOVE.B  #13,D0
    TRAP    #15
    
    MOVE.B  #4,D0
    TRAP    #15
    
    ADD.W   D4,D5
    
    MOVEA.L #$00008000,A0
    MOVEA.L A0,A1
    MOVE.L  #$103C0004,(A1)+ *MOVE.B    #4,D0
    MOVE.L  #$307C5000,(A1)+ *MOVEA.W   #$5000,A0
    MOVE.W  #$4E71,(A1)+     *NOP
    
    MOVEA.L A0,A1
TESTBIT_ONE
    MOVE.B  #16,D6
    MOVE.W  (A1)+,D2
    ROL.W   #$1,D2
    SUBI.B   #1,D6
    BCC     BIT_0
BIT_1




BIT_0
    ROL.W   #$1,D2
    SUBI.B  #1,D6
    BCC     BIT_0_0
BIT_0_1
    
    
    

BIT_0_0
    ROL.W   #$1,D2
    SUBI.B  #1,D6
    BCC     BIT_0_0_0
BIT_0_0_1
    BRA MOVEOP
    
    
    
BIT_0_0_0
    ROL.W   #$1,D2
    SUBI.B  #1,D6
    BCC     BIT_0_0_0_0
BIT_0_0_0_1
    
    
    
BIT_0_0_0_0
     
    
    


MOVEOP
        
    
    
    
    
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
