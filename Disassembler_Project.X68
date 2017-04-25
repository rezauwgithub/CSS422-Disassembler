*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:

CR          EQU $0D
LF          EQU $0A 
                 
ADDR_START  EQU $1002
ADDR_END    EQU $1003
ADDR_ITR

* Test MOVE_MOVEA_
TEST1   move.w  #$363C,D3
        bsr     MOVE_MOVEA_
        bsr     STOP

            


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
    
**************************************************************************************    
MOVE_MOVEA_
                                                       
    * print Op-code                                     OUTPUT SEQUENCE
    bsr     get_bits3_5     * get mode                  brackets [] show added portion   
    bsr     move_or_movea   * print MOVE or MOVEA       [MOVE(A)]
    
    * print length
    bsr     get_bits12_13
    bsr     print_length     * print length (.L.W.B)
    
    * print source                                      MOVE(A) [Xn]
    bsr     get_bits0_2     * get register #
    move.b  D4,D5           * store register # (0-7)
    bsr     get_bits3_5
    bsr     register_type   * get and store 
    bsr     print_source    * register type (D or A)
    
    * print separating comma                            MOVE(A) Xn [, ]
    bsr     print_comma
    
    * print destination                                  MOVE(A) Xn, [Xn]   
    bsr     get_bits9_11    * get register #
    move.b  D4,D5           * store register # (0-7)    
    bsr     get_bits6_8
    bsr     register_type   * get and store 
    bsr     print_source    * register type (D or A)    MOVE(A) Xn, Xn
    
    * start new line when finished                                                   
    bsr     print_new_line
    RTS
    
***************************************************************************************    
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

* ---------------------   
*** move bits to D4 ***
* --------------------- 
* get next 1 bit ** I think this is useless - Confirm/Delete? **
next_1bit
        move.w  D3,D4
        lsr.w   #8,D4
        lsr.w   #7,D4
        RTS
        
* get mext 2 bits ** I think this is useless - Confirm/Delete? **
next_2bit
        move.w  D3,D4
        lsr.w   #8,D4
        lsr.w   #6,D4
        RTS

* get next 3 bits ** I think this is useless - Confirm/Delete? **
next_3bit
        move.w  D3,D4
        lsr.w   #8,D4
        lsr.w   #5,D4
        RTS
        
* ----------------------        
* * Get Specified Bits *
* ---------------------- 
get_bits0_2
        move.w  D3,D4
        lsl.w   #8,D4
        lsl.w   #5,D4
        lsr.w   #5,D4
        lsr.w   #8,D4
        RTS
        
get_bits3_5
        move.w  D3,D4
        lsl.w   #8,D4
        lsl.w   #2,D4
        lsr.w   #5,D4
        lsr.w   #8,D4
        RTS
        
get_bits6_8
        move.w  D3,D4
        lsl.w   #7,D4
        lsr.w   #5,D4
        lsr.w   #8,D4
        RTS
        
get_bits9_11
        move.w  D3,D4
        lsl.w   #4,D4
        lsr.w   #8,D4
        lsr.w   #5,D4
        RTS

get_bits12_13
        move.w  D3,D4
        lsl.w   #2,D4
        lsr.w   #8,D4
        lsr.w   #6,D4
        RTS
        
* -----------------------
* **** MOVE or MOVEA ****
* -----------------------
move_or_movea
    cmp.b   #$01,D4
    beq     print_moveA
    bra     print_move
    
print_moveA
    lea         MOVEA_OP,A1
    move.b      #14,D0          
    trap        #15    
    RTS
    
print_move
    lea         MOVE_OP,A1
    move.b      #14,D0         
    trap        #15
    RTS
    
* ----------------------------
* print length (.B | .W | .L) 
* ----------------------------
print_length
    cmp.b   #$01,D4
    beq     print_B
    cmp.b   #$03,D4
    beq     print_W
    cmp.b   #$02,D4
    beq     print_L
    bra     show_error
    
print_B
    lea         BYTE_SIZE,A1
    move.b      #14,D0          
    trap        #15    
    RTS
    
print_W
    lea         WORD_SIZE,A1
    move.b      #14,D0         
    trap        #15
    RTS 

print_L
    lea         LONG_SIZE,A1
    move.b      #14,D0         
    trap        #15
    RTS 
     
* ---------------------
* * get Register type *
* ---------------------
* 3 bits should be in D4
register_type
    cmp.b   #$00,D4
    beq     get_Dregister
    cmp.b   #$07,D4
    beq     get_immidiate
    
    bra     get_Aregister    

get_Aregister
    cmp.b   #0,D5
    beq     load_A0_REG
    cmp.b   #1,D5
    beq     load_A1_REG 
    cmp.b   #2,D5
    beq     load_A2_REG
    cmp.b   #3,D5
    beq     load_A3_REG
    cmp.b   #4,D5
    beq     load_A4_REG   
    cmp.b   #5,D5
    beq     load_A5_REG   
    cmp.b   #6,D5
    beq     load_A6_REG   
    cmp.b   #7,D5
    beq     load_A7_REG
    
    RTS 

get_Dregister
    cmp.b   #0,D5
    beq     load_D0_REG
    cmp.b   #1,D5
    beq     load_D1_REG    
    cmp.b   #2,D5
    beq     load_D2_REG
    cmp.b   #3,D5
    beq     load_D3_REG
    cmp.b   #4,D5
    beq     load_D4_REG  
    cmp.b   #5,D5
    beq     load_D5_REG 
    cmp.b   #6,D5
    beq     load_D6_REG   
    cmp.b   #7,D5
    beq     load_D7_REG
   
    RTS
    
   
get_immidiate   
    move.l  (ADDR_START),D5  * get immidiate long   
    RTS
         
* ----------------------------------
* **** Print Source/Destination ****
* ----------------------------------
* 3 bits should be in D4
print_source

    cmp.b   #0,D4
    beq     data_register
    cmp.b   #1,D4
    beq     show_error     
    cmp.b   #2,D4
    beq     effective_address
    cmp.b   #3,D4
    beq     effective_address_increment
    cmp.b   #4,D4
    beq     effective_address_decrement
    cmp.b   #5,D4
    beq     effective_address *(d16,An) do we need to do this?
    cmp.b   #6,D4
    beq     effective_address *(d16,An,Xn) do we need to do this?  
    cmp.b   #7,D4
    beq     print_immidiate     
    
    RTS
    
data_register
    lea         (A2),A1
    move.b      #14,D0          * print register
    trap        #15
    RTS
    
effective_address
    lea         PAREN_OPEN,A1
    move.b      #14,D0          * print '('
    trap        #15
    
    lea         (A2),A1
    move.b      #14,D0          * print register
    trap        #15
    
    lea         PAREN_CLOSE,A1
    move.b      #14,D0          * print ')'
    trap        #15
    
    RTS
    
effective_address_increment
    lea         PAREN_OPEN,A1
    move.b      #14,D0          * print '('
    trap        #15
    
    lea         (A2),A1
    move.b      #14,D0          * print register
    trap        #15
    
    lea         PAREN_CLOSE,A1
    move.b      #14,D0          * print ')'
    trap        #15
    
    lea         PLUS,A1
    move.b      #14,D0          * print '+'
    trap        #15
    
    RTS

effective_address_decrement
    lea         MINUS,A1
    move.b      #14,D0          * print '-'
    trap        #15
   
    lea         PAREN_OPEN,A1
    move.b      #14,D0          * print '('
    trap        #15
    
    lea         (A2),A1
    move.b      #14,D0          * print register
    trap        #15  
     
    lea         PAREN_CLOSE,A1
    move.b      #14,D0          * print ')'
    trap        #15

    RTS
 
print_immidiate     * determine size of immidiate data
    
    bsr     print_hashtag
    bsr     print_dollar
    move.b  #16,D2
    move.b  #15,D0
    bsr     get_bits12_13
    cmp.b   #$01,D4
    beq     print_immidiate_B
    cmp.b   #$03,D4
    beq     print_immidiate_W
    cmp.b   #$02,D4
    beq     print_immidiate_L
    bra     show_error
  
print_immidiate_B   * print immidiate Byte
    lsr.l   #8,D5
    lsr.l   #8,D5
    lsr.l   #8,D5

    move.l  D5,D1    
    trap    #15
    RTS    

print_immidiate_W   * print immidiate Word
    lsr.l   #8,D5
    lsr.l   #8,D5

    move.l  D5,D1    
    trap    #15 
    RTS
    
print_immidiate_L   * print immidiate Long
    move.l  D5,D1    
    trap    #15  
    RTS
    
  
* -------------------------
* * Load register cString *
* -------------------------
* store register cString in A2 for printing
load_A0_REG
    lea     A0_REG,A2
    RTS
load_A1_REG
    lea     A1_REG,A2  
    RTS
load_A2_REG
    lea     A2_REG,A2
    RTS
load_A3_REG
    lea     A3_REG,A2
    RTS
load_A4_REG
    lea     A4_REG,A2
    RTS
load_A5_REG   
    lea     A5_REG,A2
    RTS
load_A6_REG   
    lea     A6_REG,A2
    RTS
load_A7_REG   
    lea     A7_REG,A2
    RTS
    
load_D0_REG
    lea     D0_REG,A2
    RTS
load_D1_REG
    lea     D1_REG,A2  
    RTS
load_D2_REG
    lea     D2_REG,A2
    RTS
load_D3_REG
    lea     D3_REG,A2
    RTS
load_D4_REG
    lea     D4_REG,A2
    RTS
load_D5_REG   
    lea     D5_REG,A2
    RTS
load_D6_REG   
    lea     D6_REG,A2
    RTS
load_D7_REG   
    lea     D7_REG,A2
    RTS

* --------------------
* * Print comma ', ' *
* --------------------
print_comma
    lea     COMMA,A1
    move.b  #14,D0
    trap    #15
    RTS
    
* ---------------------
* ** Print hashtag # **
* ---------------------
print_hashtag
    lea     HASHTAG,A1
    move.b  #14,D0
    trap    #15
    RTS
    
* ---------------------
* ** Print dollar $ **
* ---------------------
print_dollar
    lea     DOLLAR,A1
    move.b  #14,D0
    trap    #15
    RTS
    
* ------------------
* * Print new line *
* ------------------
print_new_line
    lea     NEW_LINE,A1
    move.b  #14,D0
    trap    #15
    RTS

**********************
****** ERRORS ********
**********************

  
* --------------------
* **** Show Error ****      // TO DO: Come up with more descriptive errors
* --------------------
show_error
    lea     ERROR,A1
    move.b  #14,D0
    trap    #15
    bra     TESTLOOP       


STOP
    SIMHALT             ; halt simulator

* Put variables and constants here
USER_INPUT1  DC.B    'Please specify beginning address',0
USER_INPUT2  DC.B    'Please specify ending address',0
*----------------------------------------------------------
DOLLAR      DC.B    '$',0
HASHTAG     DC.B    '#',0
PLUS        DC.B    '+',0
MINUS       DC.B    '-',0
PAREN_OPEN  DC.B    '(',0
PAREN_CLOSE DC.B    ')',0
COMMA       DC.B    ', ',0
NEW_LINE    DC.B    ' ',CR,LF,0
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
BYTE_SIZE   DC.B    '.B ',0
WORD_SIZE   DC.B    '.W ',0
LONG_SIZE   DC.B    '.L ',0
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
*ERROR
ERROR       DC.B    'Something went wrong. Derp',0



    END    START        ; last line of source






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
