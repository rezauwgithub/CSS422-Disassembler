 *-----------------------------------------------------------
* Title      : NULL TERMINATORS "I'LL GET IT BACK, BABY" DISASSEMBLER
* Written by : Reza, Eduard, Eric
* Date       : Sometime in the future, but now back in the present
* Description: Taking back op-code from Skynet, one byte at a time
*-----------------------------------------------------------
    
                                        ;CONSTANTS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
CR          EQU $0D
LF          EQU $0A 
                 
ADDR_START  EQU $1002
ADDR_END    EQU $1003
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
    ORG    $1000
START:
    MEMORY READ  $006000,$0060EF

                                ;HOW TO USE ASCII TABLE TO PRINT
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
*    MOVE.B  #$1,D0  ;Mode (M)      ***************************************************************
*    MOVE.B  #$5,D1  ;Register (Xn) ***************************************************************
*                                   ***************************************************************
*    MULS.W  #$30,D0 ;Offset        ***************************************************************
*    MULS.W  #$6,D1  ;Offset        ***************************************************************
*                                   ***************************************************************
*    ADD.W   D0,D1                  ***************************************************************
*                                   ***************************************************************
*    LEA     ASCII_TABLE,A1         ***************************************************************
*    ADDA.W  D1,A1                  ***************************************************************
*    MOVE.B  #14,D0                 ***************************************************************            
*    TRAP    #15                    ***************************************************************
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************


                                        ;User Input
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
LOOP_INPUT

* Prompt the user for the starting address.
* After user enters the starting address, verify it is valid.
* If invalid, prompt the user for the starting address again.

*    LEA			,A1
*	MOVE.B		#14,D0
*	TRAP		#15
*	
*	MOVE.B		#4,D0
*	TRAP		#15
*	
*	CMP.B		$00002000,D1
*	BLT			INVALID_INPUT_DETECTED
*	CMP.B	 	$000FFFFF,D1
*	BGT			INVALID_INPUT_DETECTED
*	
*	
*	MOVE.B		D1,D4	;Save the starting address
	

* Now prompt the user for the ending address.
* After user enters the ending address, verify it is valid.
* If invalid, prompt the user for the ending address again.

*	LEA			USER_INPUT2





;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************






                                        ;TEST CODE        
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
** Test print immediate hex values
*    MOVEA.W #$8500,A2
*    MOVE.L  #$12345678,(A2)
*    MOVEA.W #$8500,A2
*    BRA     PRINT_IMMEDIATE_LONG
*    
*    BRA     STOP
*
** Test MOVE_MOVEA_
*TEST1   move.w  #$363C,D3
*        bsr     MOVE_MOVEA_
*        bsr     STOP  

* Put program code here
    MOVEA.L #$8000,A0
    MOVEA.L A0,A2
    MOVE.W  #$1007,(A2)+
    MOVE.W  #$3007,(A2)+
    MOVE.W  #$2007,(A2)+
    MOVE.L  #$060300FF,(A2)+
    MOVE.W  #$4E71,(A2)+
    
    

    MOVEA.L A0,A2 ;USE A2 TO TRAVERSE MEMORY
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************




                                        ;DETERMINE OPCODE
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
TESTLOOP
    JSR ROTATEBYTE
                
        
        
CASE1
        ;NOP/MOVEM/LEA/CLR/JSR/RTS    
;----------------------    
    CMP.L   #$4,D2
    BNE     CASE2
    JSR     NOP_MOVEM_LEA_CLR_JSR_RTS_
    JMP     MOVENEXT
;----------------------


CASE2
        ;MOVE/MOVEA    
;----------------------    
    CMP.L   #$1,D2
    BNE     CASE2_1
    JSR     MOVE_MOVEA_
    JMP     MOVENEXT
CASE2_1
    CMP.L   #$2,D2
    BNE     CASE2_2
    JSR     MOVE_MOVEA_
    JMP     MOVENEXT
CASE2_2
    CMP.L   #$3,D2
    BNE     CASE3
    JSR     MOVE_MOVEA_
    JMP     MOVENEXT
;----------------------

CASE3
        ;MOVEQ    
;----------------------    
    CMP.L   #$7,D2
    BNE     CASE4
    JSR     MOVEQ_
    JMP     MOVENEXT
;----------------------

CASE4
        ;ADD/ADDA    
;----------------------    
    CMP.L   #$D,D2
    BNE     CASE5
    JSR     ADD_ADDA_
    JMP     MOVENEXT
;----------------------

CASE5
        ;ADDI   
;----------------------    
    CMP.L   #$0,D2
    BNE     CASE6
    JSR     ADDI_
    JMP     MOVENEXT
;----------------------

CASE6      
        ;ADDQ    
;----------------------    
    CMP.L   #$5,D2
    BNE     CASE7
    JSR     ADDQ_
    JMP     MOVENEXT
;----------------------

CASE7   
        ;SUB    
;----------------------    
    CMP.L   #$9,D2
    BNE     CASE8
    JSR     SUB_
    JMP     MOVENEXT
;----------------------

CASE8
        ;MULS_AND    
;----------------------    
    CMP.L   #$C,D2
    BNE     CASE9
    JSR     MULS_AND_
    JMP     MOVENEXT
;----------------------

CASE9
        ;OR_DIVU    
;----------------------    
    CMP.L   #$8,D2
    BNE     CASE10
    JSR     SUB_
    JMP     MOVENEXT
;----------------------

CASE10
        ;LSd_ASd_ROd    
;----------------------    
    CMP.L   #$E,D2
    BNE     CASE11
    JSR     LSd_ASd_ROd_
    JMP     MOVENEXT
;----------------------

CASE11
        ;CMP   
;----------------------    
    CMP.L   #$B,D2
    BNE     CASE12
    JSR     CMP_
    JMP     MOVENEXT
;----------------------

CASE12
        ;BCC   
;----------------------    
    CMP.L   #$6,D2
    BNE     DEFAULT
    JSR     BCC_
    JMP     MOVENEXT
;----------------------

DEFAULT
        ;FAIL 
;----------------------    
    LEA     ERROR,A1
    JSR     TASK13
    JMP     MOVENEXT
;----------------------
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
    SIMHALT             ; halt simulator
    
    
    
    
    
    
                                        ;OPCODE SUBROUTINES   
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************    
ROTATEBYTE
    MOVE.B  (A2),D2
    LSR.L   #$4,D2
    RTS
MOVENEXT
    ADDA.L  #$2,A2
    CLR.L   D2
    JMP     TESTLOOP

NOP_MOVEM_LEA_CLR_JSR_RTS_   
    RTS
      
MOVE_MOVEA_                     ;BOOKMARK
    JSR     CLEAR_REGS
    MOVE.B  (A2),D2
    JSR     S1
    *JSR     LOAD_SIZE
    MOVE.B  D2,SIZE
    JSR     CLEAR_REGS
    
    MOVE.B  (A2),D2
    JSR     XN
    MOVE.B  D2,DESTINATION_REG
    JSR     CLEAR_REGS
    
    MOVE.W  (A2),D4
    LSR.W   #$1,D4
    MOVE.B  D4,D2
    JSR     MO
    MOVE.B  D2,DESTINATION_MODE
    JSR     CLEAR_REGS
    
    MOVE.W  (A2),D4
    LSL.W   #$2,D4
    MOVE.B  D4,D2
    JSR     MO
    MOVE.B  D2,SOURCE_MODE
    JSR     CLEAR_REGS
    
    MOVE.W  (A2),D4
    MOVE.B  D4,D2
    LSL.B   #$1,D2
    JSR     XN
    MOVE.B  D2,SOURCE_REG
    JSR     CLEAR_REGS
    
    CMP.B   #$1,DESTINATION_MODE
    BEQ     PRINT_MOVEA
    BRA     PRINT_MOVE

PRINT_MOVEA
    LEA     MOVEA_OP,A1
    JSR     TASK14
    
    JSR     PRINT_S1
    
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    
    MULS.W  #$30,D2
    MULS.W  #$6,D4
    ADD.W   D2,D4
    LEA     ASCII_TABLE,A1
    ADDA    D4,A1
    JSR     TASK14
    
    JSR     PRINT_COMMA
    JSR     CLEAR_REGS
    
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    
    MULS.W  #$30,D2
    MULS.W  #$6,D4
    ADD.W   D2,D4
    LEA     ASCII_TABLE,A1
    ADDA    D3,A1
    JSR     TASK13
    RTS

PRINT_MOVE
    LEA     MOVE_OP,A1
    JSR     TASK14
    
    JSR     PRINT_S1
    
    JSR     CLEAR_REGS
    JSR     PRINT_SOURCE ;---------------
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    
    MULS.W  #$30,D2
    MULS.W  #$6,D4
    ADD.W   D2,D4
    LEA     ASCII_TABLE,A1
    ADDA    D4,A1
    JSR     TASK14
    
    JSR     PRINT_COMMA
    JSR     CLEAR_REGS
    
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    
    MULS.W  #$30,D2
    MULS.W  #$6,D4
    ADD.W   D2,D4
    LEA     ASCII_TABLE,A1
    ADDA    D3,A1
    JSR     TASK13
    RTS
    
    
    
PRINT_SOURCE
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    CMP     #$7,D2
    BEQ     PRINT_ABSOLUTE_OR_IMMEDIATE
    
FINISH_SOURCE
    RTS

PRINT_DESTINATION

PRINT_ABSOLUTE_OR_IMMEDIATE
    CLR.L   D6
    MOVE.W  D2,D6
    ADD.W   D4,D6
    CMP.W   #$7,D6
    BEQ     ABSOLUTE_SHORT

ABSOLUTE_SHORT
    CLR.L       D3
    LEA         HEX_ASCII,A3
    MOVEA.L     A2,A6
    ADDA.L      #$2,A6
    CLR.L       D6
    MOVE.W      (A6),D6
    MOVEA.L     #$5000,A6
    ROR.W       #$8,D6
    MOVE.B      D6,D7
    LSR.B       #$4,D7
    ADDA        D7,A3
    *MOVE.B      (A3),
    
    RTS
    
   
MOVEQ_
    RTS
ADD_ADDA_
    * 1. get size
    * 2. get source register
    * 3. get opmode
    * 4. get EA mode
    *   - if EA mode is An(001), OPCODE = ADDA
    * 5. get EA register
    * 6. Print OPCODE 
    * 7. Based on opmode:
    *     - print source register, EA register or;
    *     - print EA register, source register    
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
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************




                                          ;MODULAR SUBROUTINES
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
MO
    LSR.B   #$5,D2
    RTS
XN
    LSL.B   #$4,D2
    LSR.B   #$5,D2
    RTS
S1          ;MOVE
    LSR.B   #$4,D2
    RTS
S2          ;ADD
    RTS
S3          ;MOVEM
    RTS
D1          ;ADD
    RTS
D2          ;MOVEM
    RTS
D3          ;SHIFTS
    RTS
    
CLEAR_REGS
    CLR.L   D2
    CLR.L   D4
    RTS
    
;----------------------------------------------------------------   
PRINT_S1
    CMP.B   #$1,SIZE
    BEQ     PRINT_BYTE
    CMP.B   #$3,SIZE
    BEQ     PRINT_WORD
    CMP.B   #$2,SIZE
    BEQ     PRINT_LONG

DONE
    RTS
PRINT_BYTE
    LEA     BYTE_SIZE,A1
    JSR     TASK14
    BRA     DONE
PRINT_WORD
    LEA     WORD_SIZE,A1
    JSR     TASK14
    BRA     DONE
PRINT_LONG
    LEA     LONG_SIZE,A1
    JSR     TASK14
    BRA     DONE
;----------------------------------------------------------------  


LOAD_DESTINATION
    CMP.B   #$0,D2
    BEQ     DATA_REG
    
DATA_REG
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   
    
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************



                                            ;GET SPECIFIC BITS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
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
* put bits in D4 register
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
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************


                                ;PRINT IMMEDIATE BYTE,WORD,LONG
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
PRINT_IMMEDIATE_BYTE
    MOVE.B  (A2)+,D3
    MOVE.B  D3,D4
    LSR.B   #4,D4
    BSR     PRINT_HEX_BYTE
    MOVE.B  D3,D4
    LSL.B   #4,D4
    LSR.B   #4,D4
    BSR     PRINT_HEX_BYTE
    RTS

PRINT_IMMEDIATE_WORD
    BSR     PRINT_IMMEDIATE_BYTE
    BSR     PRINT_IMMEDIATE_BYTE
    RTS

PRINT_IMMEDIATE_LONG
    BSR     PRINT_IMMEDIATE_BYTE
    BSR     PRINT_IMMEDIATE_BYTE
    BSR     PRINT_IMMEDIATE_BYTE
    BSR     PRINT_IMMEDIATE_BYTE
    RTS

PRINT_HEX_BYTE
    CMP.B   #$00,D4
    BEQ     PRINT_HEX_0
    CMP.B   #$01,D4
    BEQ     PRINT_HEX_1
    CMP.B   #$02,D4
    BEQ     PRINT_HEX_2
    CMP.B   #$03,D4
    BEQ     PRINT_HEX_3
    CMP.B   #$04,D4
    BEQ     PRINT_HEX_4
    CMP.B   #$05,D4
    BEQ     PRINT_HEX_5
    CMP.B   #$06,D4
    BEQ     PRINT_HEX_6
    CMP.B   #$07,D4
    BEQ     PRINT_HEX_7
    CMP.B   #$08,D4
    BEQ     PRINT_HEX_8
    CMP.B   #$09,D4
    BEQ     PRINT_HEX_9
    CMP.B   #$0A,D4
    BEQ     PRINT_HEX_A
    CMP.B   #$0B,D4
    BEQ     PRINT_HEX_B
    CMP.B   #$0C,D4
    BEQ     PRINT_HEX_C
    CMP.B   #$0D,D4
    BEQ     PRINT_HEX_D
    CMP.B   #$0E,D4
    BEQ     PRINT_HEX_E
    CMP.B   #$0F,D4
    BEQ     PRINT_HEX_F
    BRA     SHOW_ERROR

PRINT_HEX_0
    LEA     HEX_0,A1
    BRA     PRINT_
PRINT_HEX_1
    LEA     HEX_1,A1
    BRA     PRINT_
PRINT_HEX_2
    LEA     HEX_2,A1
    BRA     PRINT_
PRINT_HEX_3
    LEA     HEX_3,A1
    BRA     PRINT_
PRINT_HEX_4
    LEA     HEX_4,A1
    BRA     PRINT_
PRINT_HEX_5
    LEA     HEX_5,A1
    BRA     PRINT_
PRINT_HEX_6
    LEA     HEX_6,A1
    BRA     PRINT_
PRINT_HEX_7
    LEA     HEX_7,A1
    BRA     PRINT_
PRINT_HEX_8
    LEA     HEX_8,A1
    BRA     PRINT_
PRINT_HEX_9
    LEA     HEX_9,A1
    BRA     PRINT_
PRINT_HEX_A
    LEA     HEX_A,A1
    BRA     PRINT_
PRINT_HEX_B
    LEA     HEX_B,A1
    BRA     PRINT_
PRINT_HEX_C
    LEA     HEX_C,A1
    BRA     PRINT_
PRINT_HEX_D
    LEA     HEX_D,A1
    BRA     PRINT_
PRINT_HEX_E       
    LEA     HEX_E,A1
    BRA     PRINT_
PRINT_HEX_F
    LEA     HEX_F,A1
    BRA     PRINT_

                                           ;PRINT OTHER
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
* ----------------------------
* print length (.B | .W | .L) 
* ----------------------------
print_length
    cmp.b   #$01,D4
    beq     print_B
    cmp.b   #$03,D4
    beq     print_W
    bra     SHOW_ERROR
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
    
* --------------------
* ****** Print *******
* --------------------
PRINT_
    move.b  #14,D0
    trap    #15
    RTS

* --------------------
* * Print comma ', ' *
* --------------------
print_comma
    lea     COMMA,A1
    JSR     TASK14
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

  
SHOW_ERROR
SHOW_ERROR

* **** Show Error ****      // TO DO: Come up with more descriptive errors
* --------------------
SHOW_ERROR
    lea     ERROR,A1
    move.b  #14,D0
    trap    #15
    bra     TESTLOOP       

* --------------------------------------
* **** Invalid User Input Detected ****
* --------------------------------------
INVALID_INPUT_DETECTED
    *lea     INVALID,A1
    move.b  #14,D0
    trap    #15
    bra     LOOP_INPUT       
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************



                                        ;PRINT TRAPS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
TASK13
    CLR.L   D0
    MOVE.B  #13,D0
    TRAP    #15
    RTS
TASK14
    CLR.L   D0
    MOVE.B  #14,D0
    TRAP    #15
    RTS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************



                                        ;PRINT ADDRESS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
;IMPLEMENT A WAY TO PRINT THE ADDRESS WHERE EACH OPERATION OCCURS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************



;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************

STOP
STARTING_ADDRESS_ENTERED	DC.B    'Please specify the starting address',0
ENDING_ADDRESS_ENTERED		DC.B    'Please specify the ending address',0
INVALID_USER_INPUT			DC.B	'Please enter a valid address ($00002000 - $000FFFFF)',0		 

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
BYTE_SIZE   DC.B    '.B     ',0
WORD_SIZE   DC.B    '.W     ',0
LONG_SIZE   DC.B    '.L     ',0
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
*HEX VALUES
HEX_0      DC.B    '0',0
HEX_1      DC.B    '1',0
HEX_2      DC.B    '2',0
HEX_3      DC.B    '3',0
HEX_4      DC.B    '4',0
HEX_5      DC.B    '5',0
HEX_6      DC.B    '6',0
HEX_7      DC.B    '7',0
HEX_8      DC.B    '8',0
HEX_9      DC.B    '9',0
HEX_A      DC.B    'A',0
HEX_B      DC.B    'B',0
HEX_C      DC.B    'C',0
HEX_D      DC.B    'D',0
HEX_E      DC.B    'E',0
HEX_F      DC.B    'F',0
*ERROR
ERROR       DC.B    'Something went wrong. Derp',0


*OUTPUT_VARIABLES      
SIZE                    DS.B    1
SOURCE_ADDRESS          DS.L    1
DESTINATION_ADDRESS     DS.L    1
DESTINATION_MODE        DS.B    1
DESTINATION_REG         DS.B    1
SOURCE_MODE             DS.B    1
SOURCE_REG              DS.B    1
EA_MODE                 DS.B    1
EA_REG                  DS.B    1
OPMODE                  DS.B    1

    ORG $6000
ASCII_TABLE
      DC.B    'D0',0,0,0,0
      DC.B    'D1',0,0,0,0
      DC.B    'D2',0,0,0,0
      DC.B    'D3',0,0,0,0
      DC.B    'D4',0,0,0,0
      DC.B    'D5',0,0,0,0
      DC.B    'D6',0,0,0,0
      DC.B    'D7',0,0,0,0
      
      DC.B    'A0',0,0,0,0
      DC.B    'A1',0,0,0,0
      DC.B    'A2',0,0,0,0
      DC.B    'A3',0,0,0,0
      DC.B    'A4',0,0,0,0
      DC.B    'A5',0,0,0,0
      DC.B    'A6',0,0,0,0
      DC.B    'A7',0,0,0,0  

      DC.B    '(A0)',0,0
      DC.B    '(A1)',0,0
      DC.B    '(A2)',0,0
      DC.B    '(A3)',0,0
      DC.B    '(A4)',0,0
      DC.B    '(A5)',0,0
      DC.B    '(A6)',0,0
      DC.B    '(A7)',0,0
      
      DC.B    '(A0)+',0
      DC.B    '(A1)+',0
      DC.B    '(A2)+',0
      DC.B    '(A3)+',0
      DC.B    '(A4)+',0
      DC.B    '(A5)+',0
      DC.B    '(A6)+',0
      DC.B    '(A7)+',0      
      
      DC.B    '-(A0)',0
      DC.B    '-(A1)',0
      DC.B    '-(A2)',0
      DC.B    '-(A3)',0
      DC.B    '-(A4)',0
      DC.B    '-(A5)',0
      DC.B    '-(A6)',0
      DC.B    '-(A7)',0
      
      
    ORG $7000
HEX_ASCII
      DC.B    $30
      DC.B    $31
      DC.B    $32
      DC.B    $33
      DC.B    $34
      DC.B    $35
      DC.B    $36
      DC.B    $37
      DC.B    $38
      DC.B    $39
      DC.B    $41
      DC.B    $42
      DC.B    $43
      DC.B    $44
      DC.B    $45
      DC.B    $46    

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
