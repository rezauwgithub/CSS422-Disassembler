*-----------------------------------------------------------
* Title      : NULL TERMINATORS "I'LL GET IT BACK, BABY" DISASSEMBLER
* Written by : Reza, Eduard, Eric
* Date       : Sometime in the future, but now back in the present
* Description: Taking back op-code from Skynet, one byte at a time
*----------------------------------------------------------- 
                                        ;CONSTANTS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
CR          		        EQU $0D
LF          		        EQU $0A 
                 
DEFAULT_ADDR_START  		EQU $1002
DEFAULT_ADDR_END    		EQU $1003

MIN_ADDR					EQU	$00001000
MAX_ADDR					EQU	$000FFFFF

;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
    INCLUDE comprehensive_test.X68
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



                                        ;I/O
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
DISPLAY_WELCOME_MSG
    LEA             WELCOME_MSG,A1
    MOVE.B          #13,D0
    TRAP            #15
GET_START_ADDRESS
    LEA				ASK_FOR_STARTING_ADDRESS_MSG,A1
	MOVE.B			#13,D0
	TRAP			    #15
	MOVEA.L         #$00000000,A1
	MOVE.B          #2,D0               ; User Input
	TRAP            #15                 ; Get User Input 
	MOVE.L          #$00009000,A2       ; String Builder  
    MOVEA.L         A2,A3
    JSR             CLEAR_REGS
    MOVE.L          D1,D6
    DIVS            #$2,D6
    MOVE.W          D6,D7
    SWAP            D6
    CMPI.B          #$0,D6
    BNE             ODD_LENGTH_START
    MOVE.L          D7,D6
    JSR             LOOP_INPUT
    BRA             CONTINUE_START_ADDR
ODD_LENGTH_START
    MOVE.L          D7,D6
    ADDI.L          #$1,D6
    JSR             LOOP_INPUT
CONTINUE_START_ADDR 
    CMPI.W          #$2,D1
    BLE             ROTATE_AS_BYTE_SUB1
    CMPI.W          #$4,D1
    BLE             ROTATE_AS_WORD_SUB1
    CMPI.W          #$8,D1
    BLE             ROTATE_AS_LONG_SUB1
ROTATE_AS_BYTE_SUB1
    JSR             ROTATE_AS_BYTE
    MOVE.L          A6,START_ADDR
    BRA             GET_END_ADDRESS
ROTATE_AS_WORD_SUB1
    JSR             ROTATE_AS_WORD
    MOVE.L          A6,START_ADDR
    BRA             GET_END_ADDRESS
ROTATE_AS_LONG_SUB1
    JSR             ROTATE_AS_LONG
    MOVE.L          A6,START_ADDR
    BRA             GET_END_ADDRESS
    
GET_END_ADDRESS
    LEA			    ASK_FOR_ENDING_ADDRESS_MSG,A1
    MOVE.B		    #13,D0
	TRAP			#15
	MOVEA.L         #$00000000,A1
	MOVE.B          #2,D0               ; User Input
	TRAP            #15                 ; Get User Input 
	MOVE.L          #$00009000,A2       ; String Builder  
    MOVEA.L         A2,A3
    JSR             CLEAR_REGS
    MOVE.L          D1,D6
    DIVS            #$2,D6
    MOVE.W          D6,D7
    SWAP            D6
    CMPI.B          #$0,D6
    BNE             ODD_LENGTH_END
    MOVE.L          D7,D6
    JSR             LOOP_INPUT
    BRA             CONTINUE_END_ADDR
ODD_LENGTH_END
    MOVE.L          D7,D6
    ADDI.L          #$1,D6
    JSR             LOOP_INPUT
CONTINUE_END_ADDR     
    CMPI.W          #$2,D1
    BLE             ROTATE_AS_BYTE_SUB2
    CMPI.W          #$4,D1
    BLE             ROTATE_AS_WORD_SUB2
    CMPI.W          #$8,D1
    BLE             ROTATE_AS_LONG_SUB2
ROTATE_AS_BYTE_SUB2
    JSR             ROTATE_AS_BYTE
    MOVE.L          A6,END_ADDR
    BRA             PROGRAM_START
ROTATE_AS_WORD_SUB2
    JSR             ROTATE_AS_WORD
    MOVE.L          A6,END_ADDR
    BRA             PROGRAM_START
ROTATE_AS_LONG_SUB2
    JSR             ROTATE_AS_LONG
    MOVE.L          A6,END_ADDR
    BRA             PROGRAM_START
    
ROTATE_AS_BYTE
    JSR             CLEAR_REGS
    CMPI.B          #$2,D1
    BLT             CONTINUE_ROTATE_AS_BYTE
    ADD.B           (A2),D2
    MOVEA.L         D2,A6
    RTS
CONTINUE_ROTATE_AS_BYTE
    ADD.B           (A2),D2
    LSR.B           #$4,D2
    MOVEA.L         D2,A6
    RTS
ROTATE_AS_WORD
    JSR             CLEAR_REGS
    CMPI.B          #$4,D1
    BLT             CONTINUE_ROTATE_AS_WORD
    ADD.W           (A2),D2
    MOVEA.L         D2,A6
    RTS
CONTINUE_ROTATE_AS_WORD
    ADD.W           (A2),D2
    LSR.W           #$4,D2
    MOVEA.L         D2,A6
    RTS
ROTATE_AS_LONG
    JSR             CLEAR_REGS
    CMPI.B          #$8,D1
    BLT             CONTINUE_ROTATE_AS_LONG
    ADD.L           (A2),D2
    MOVEA.L         D2,A6
    RTS
CONTINUE_ROTATE_AS_LONG
    ADD.L           (A2),D2
    CMPI            #$5,D1
    BEQ             ROTATE_BY_12
    CMPI            #$6,D1
    BEQ             ROTATE_BY_8
    CMPI            #$7,D1
    BEQ             ROTATE_BY_4
ROTATE_BY_12
    LSR.L           #$8,D2
    LSR.L           #$4,D2
    BRA             CONTINUE_AS_LONG
ROTATE_BY_8
    LSR.L           #$8,D2
    BRA             CONTINUE_AS_LONG
ROTATE_BY_4
    LSR.L           #$4,D2
    BRA             CONTINUE_AS_LONG
CONTINUE_AS_LONG    
    MOVEA.L         D2,A6
    RTS
    
  


LOOP_INPUT
    CMPI.B          #$00,D6
    BEQ             DONE_LOOP
    MOVE.B          (A1)+,D2
    LEA             ASCII_HEX,A0
    MOVE.B          (0,A0,D2),D3
    LSL.B           #$4,D3
    MOVE.B          (A1)+,D2
    ADD.B           (0,A0,D2),D3
    MOVE.B          D3,(A3)+
    SUBI.L          #$1,D6
    BRA             LOOP_INPUT
DONE_LOOP
    RTS


*;///////////////////////////////////////////////////////////////////////////////////////////////////
****************************************************************************************************






                                        ;TEST CODE        
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
* Put program code here
*  MOVE.L  #$00008000,START_ADDR
*  MOVE.L  #$00008060,END_ADDR
PROGRAM_START
   MOVE.B  #0,OUTPUT_COUNTER
   MOVEA.L START_ADDR,A0
   MOVEA.L A0,A2 ;USE A2 TO TRAVERSE MEMORY
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************




                                        ;DETERMINE OPCODE
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
TESTLOOP
    CMPI.B  #30,OUTPUT_COUNTER
    BNE     CONTINUE_TESTLOOP
    MOVE.B  #0,OUTPUT_COUNTER
    LEA     PRESS_KEY_CONTINUE,A1
    JSR     TASK13
    MOVE.B  #5,D0
    TRAP    #15
CONTINUE_TESTLOOP
    ADDI.B  #1,OUTPUT_COUNTER
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
    JMP     MOVE_MOVEA_
CASE2_1
    CMP.L   #$2,D2
    BNE     CASE2_2
    JMP     MOVE_MOVEA_
CASE2_2
    CMP.L   #$3,D2
    BNE     CASE3
    JMP     MOVE_MOVEA_
;----------------------

CASE3
        ;MOVEQ    
;----------------------    
    CMP.L   #$7,D2
    BNE     CASE4
    JMP     MOVEQ_
;----------------------

CASE4
        ;ADD/ADDA    
;----------------------    
    CMP.L   #$D,D2
    BNE     CASE5
    JMP     ADD_ADDA_
;----------------------

CASE5
        ;ADDI   
;----------------------    
    CMP.L   #$0,D2
    BNE     CASE6
    JMP     ADDI_
;----------------------

CASE6      
        ;ADDQ    
;----------------------    
    CMP.L   #$5,D2
    BNE     CASE7
    JMP     ADDQ_
;----------------------

CASE7   
        ;SUB    
;----------------------    
    CMP.L   #$9,D2
    BNE     CASE8
    JMP     SUB_
;----------------------

CASE8
        ;MULS_AND    
;----------------------    
    CMP.L   #$C,D2
    BNE     CASE9
    JMP     MULS_AND_
;----------------------

CASE9
        ;OR_DIVU    
;----------------------    
    CMP.L   #$8,D2
    BNE     CASE10
    JMP     OR_DIVU_
;----------------------

CASE10
        ;LSd_ASd_ROd    
;----------------------    
    CMP.L   #$E,D2
    BNE     CASE11
    JMP     LSd_ASd_ROd_
;----------------------

CASE11
        ;CMP   
;----------------------    
    CMP.L   #$B,D2
    BNE     CASE12
    JMP     CMP_
;----------------------

CASE12
        ;BCC   
;----------------------    
    CMP.L   #$6,D2
    BNE     DEFAULT
    JMP     BCC_
;----------------------

DEFAULT
        ;FAIL 
;----------------------    
    JMP     PRINT_DATA
;----------------------
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
    SIMHALT             ; halt simulator
    
    
    
    
    
    
                                        ;OPCODE SUBROUTINES   
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************    

ROTATEBYTE
    JSR     CLEAR_REGS
    MOVE.B  (A2),D2
    LSR.L   #$4,D2
    RTS
MOVENEXT
    ADDA.L  #$2,A2
    JSR     CLEAR_REGS
    CMPA.L  END_ADDR,A2
    BGE     TERMINATE
    JMP     TESTLOOP
    
NOP_MOVEM_LEA_CLR_JSR_RTS_

    JSR     CLEAR_REGS  *Check if RTS or NOP
    MOVE.W  (A2),D2
    CMPI.W  #$4E75,D2
    BEQ     RTS_
    CMPI.W  #$4E71,D2
    BEQ     NOP_
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2    *Check if LEA
    JSR     BITS_8_10
    CMPI    #$7,D2
    BEQ     LEA_

    JSR     CLEAR_REGS  * Check if CLR or JSR
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    CMPI    #$1,D2
    BEQ     CLR_
    CMPI    #$7,D2
    BEQ     JSR_
    
    JSR     CLEAR_REGS  * Check if MOVEM
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    CMPI.B  #$4,D2
    BEQ     MOVEM_
    CMPI.B  #$6,D2
    BEQ     MOVEM_    
    
    BEQ     SHOW_ERROR
    
CLR_
    MOVE.B  #$2,SIZETYPE 
    JSR CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    MOVE.B  D2,SIZE
    
    JSR CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    
    BRA     PRINT_CLR

JSR_
    JSR CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    
    BRA     PRINT_JSR 

RTS_
    BRA    PRINT_RTS
    
NOP_
    BRA    PRINT_NOP
   
LEA_
    MOVE.B  #$4,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$1,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_LEA
MOVE_MOVEA_
    MOVE.B  #$1,SIZETYPE                     ;BOOKMARK
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_3_4              * Load size type 1
    MOVE.B  D2,SIZE
    JSR     CLEAR_REGS
    
    MOVE.W  (A2),D2
    JSR     BITS_5_7                 
    MOVE.B  D2,DESTINATION_REG  * Get destination register
    JSR     CLEAR_REGS
    
    MOVE.W  (A2),D2
    JSR     BITS_8_10
    MOVE.B  D2,DESTINATION_MODE    * Get destination mode 
    JSR     CLEAR_REGS
    
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE  * Get source mode
    JSR     CLEAR_REGS
    
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG   * Get source register
    JSR     CLEAR_REGS
    
    CMP.B   #$1,DESTINATION_MODE * determine if MOVE or MOVEA
    BEQ     PRINT_MOVEA
    BRA     PRINT_MOVE
   
MOVEQ_
    MOVE.B  #$4,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    MOVE.B  #$7,SOURCE_MODE
    MOVE.B  #$4,SOURCE_REG
    BRA     PRINT_MOVEQ
ADD_ADDA_    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    CMPI.B  #$3,D2
    BEQ     ADDA_
    MOVE.B  #$2,SIZETYPE
    MOVE.B  D2,SIZE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_8
    MOVE.B  D2,DIRECTION
    CMPI.B  #$0,D2
    BEQ     TO_DATA_ADD
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,SOURCE_REG
    MOVE.B  #$0,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    BRA     PRINT_ADD
TO_DATA_ADD
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_ADD

ADDA_
    MOVE.B  #$3,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_8
    MOVE.B  D2,SIZE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$1,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_ADDA
ADDI_
    MOVE.B  #$2,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    MOVE.B  D2,SIZE
    
    MOVE.B  #$7,SOURCE_MODE
    MOVE.B  #$4,SOURCE_REG
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    BRA     PRINT_ADDI
ADDQ_
    MOVE.B  #$2,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    MOVE.B  D2,SIZE
  
    JSR     CLEAR_REGS
    MOVE.B  #$7,SOURCE_MODE
    MOVE.B  #$4,SOURCE_REG
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    BRA     PRINT_ADDQ
SUB_
    MOVE.B  #$2,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    MOVE.B  D2,SIZE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_8
    MOVE.B  D2,DIRECTION
    CMPI.B  #$0,D2
    BEQ     TO_DATA_SUB
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,SOURCE_REG
    MOVE.B  #$0,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    BRA     PRINT_SUB
TO_DATA_SUB
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_SUB
MULS_AND_
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    CMPI    #$3,D2
    BEQ     MULS_
    
    MOVE.B  #$2,SIZETYPE
    MOVE.B  D2,SIZE
    
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_8
    MOVE.B  D2,DIRECTION
    CMPI.B  #$0,D2
    BEQ     TO_DATA_AND
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,SOURCE_REG
    MOVE.B  #$0,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    BRA     PRINT_AND
    
TO_DATA_AND
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_AND
MULS_
    MOVE.B  #$4,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_MULS
OR_DIVU_
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    CMPI    #$3,D2
    BEQ     DIVU_
    
    MOVE.B  #$2,SIZETYPE
    MOVE.B  D2,SIZE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_8
    MOVE.B  D2,DIRECTION
    CMPI.B  #$0,D2
    BEQ     TO_DATA_OR
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,SOURCE_REG
    MOVE.B  #$0,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    BRA     PRINT_OR
    
TO_DATA_OR
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_OR 
DIVU_
    MOVE.B  #$4,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_DIVU

LSd_ASd_ROd_
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    CMPI.B  #$3,D2
    BEQ     LSd_ASd_ROd_1
    
    MOVE.B  #$2,SIZETYPE
    MOVE.B  D2,SIZE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,SOURCE_REG
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_8
    MOVE.B  D2,DIRECTION
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11
    CMPI.B  #$0,D2
    BEQ     LOAD_IMMEDIATE_MODE2
    CMPI.B  #$1,D2
    BEQ     LOAD_REGISTER_MODE2 
LOAD_IMMEDIATE_MODE2
    MOVE.B  #$7,SOURCE_MODE
    BRA     CONTINUE_LSd_ASd_ROd_
LOAD_REGISTER_MODE2
    MOVE.B  #$0,SOURCE_MODE
    BRA     CONTINUE_LSd_ASd_ROd_ 
CONTINUE_LSd_ASd_ROd_ 
    JSR     CLEAR_REGS
    MOVE.B  #$0,DESTINATION_MODE
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_12_13
    
    CMPI.B  #$0,D2
    BEQ     PRINT_ASD
    CMPI.B  #$1,D2
    BEQ     PRINT_LSD
    CMPI.B  #$3,D2
    BEQ     PRINT_ROD   
LSd_ASd_ROd_1
    MOVE.B  #$4,SIZETYPE
    JSR     CLEAR_REGS * get direction
    MOVE.W  (A2),D2
    JSR     BITS_8
    MOVE.B  D2,DIRECTION
    
    JSR     CLEAR_REGS * get destination mode
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,DESTINATION_MODE
    
    JSR     CLEAR_REGS * get destination register
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,DESTINATION_REG
    
    JSR     CLEAR_REGS   * Go to correct printing 
    MOVE.W  (A2),D2    
    JSR     BITS_5_7
    CMPI.B  #$0,D2
    BEQ     PRINT_ASD1
    CMPI.B  #$1,D2
    BEQ     PRINT_LSD1
    CMPI.B  #$3,D2
    BEQ     PRINT_ROD1
    
    BEQ     SHOW_ERROR
CMP_
    MOVE.B  #$2,SIZETYPE
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_10
    MOVE.B  D2,SIZE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,DESTINATION_REG
    MOVE.B  #$0,DESTINATION_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_11_13
    MOVE.B  D2,SOURCE_MODE
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_14_16
    MOVE.B  D2,SOURCE_REG
    BRA     PRINT_CMP 
BCC_
    RTS
MOVEM_
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************

                                          ;Op-Code SUBROUTINES
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
PRINT_NOP
    JSR     PRINT_CURRENT_ADDR
    LEA     NOP_OP,A1      ;Print NOP
    JSR     TASK14   
    JSR     PRINT_S4 
    JSR     PRINT_SPACE 
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT 

PRINT_RTS
    JSR     PRINT_CURRENT_ADDR
    LEA     RTS_OP,A1      ;Print RTS
    JSR     TASK14   
    JSR     PRINT_S4 
    JSR     PRINT_SPACE 
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT 
    
PRINT_JSR
    JSR     PRINT_CURRENT_ADDR
    LEA     JSR_OP,A1      ;Print RTS
    JSR     TASK14   
    JSR     PRINT_S4 
    JSR     PRINT_SPACE 
    
    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    
    JMP     MOVENEXT

PRINT_MOVEA
    JSR     PRINT_CURRENT_ADDR
    LEA     MOVEA_OP,A1      ;PRINTS MOVEA
    JSR     TASK14     
    JSR     PRINT_S1        ;PRINTS .B,.W,.L
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_MOVE
    JSR     PRINT_CURRENT_ADDR
    LEA     MOVE_OP,A1      ;PRINTS MOVE
    JSR     TASK14     
    JSR     PRINT_S1        ;PRINTS .B,.W,.L 
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
    
PRINT_ADD
    JSR     PRINT_CURRENT_ADDR
    LEA     ADD_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_ADDA
    JSR     PRINT_CURRENT_ADDR
    LEA     ADDA_OP,A1
    JSR     TASK14
    JSR     PRINT_S3
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_ADDI
    JSR     PRINT_CURRENT_ADDR
    LEA     ADDI_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_MOVEQ
    JSR     PRINT_CURRENT_ADDR
    LEA     MOVEQ_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    
    JSR     PRINT_SPACE
    JSR     PRINT_HASHTAG
    JSR     PRINT_DOLLAR
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_9_16
    MOVE.B  D2,D3
    JSR     BYPASS
    
    JSR     PRINT_COMMA
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_ADDQ
    JSR     PRINT_CURRENT_ADDR
    LEA     ADDQ_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     PRINT_HASHTAG
    JSR     PRINT_DOLLAR
    
    JSR     CLEAR_REGS
    MOVE.W  (A2),D2
    JSR     BITS_5_7
    MOVE.B  D2,D3
    JSR     BYPASS
    
    JSR     PRINT_COMMA
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT 
PRINT_SUB
    JSR     PRINT_CURRENT_ADDR
    LEA     SUB_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_AND
    JSR     PRINT_CURRENT_ADDR
    LEA     AND_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_MULS
    JSR     PRINT_CURRENT_ADDR
    LEA     MULS_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    
    JSR     PRINT_SPACE
    
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    JSR     PRINT_MODE_REG
    
    JSR     PRINT_COMMA
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_OR
    JSR     PRINT_CURRENT_ADDR
    LEA     OR_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     CLEAR_REGS      * Load source mode and register for printing
    MOVE.B  SOURCE_MODE,D2  
    MOVE.B  SOURCE_REG,D4   
    JSR     PRINT_MODE_REG 
    
    JSR     PRINT_COMMA

    JSR     CLEAR_REGS          * Load distination mode and register for printing
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_DIVU
    JSR     PRINT_CURRENT_ADDR
    LEA     DIVU_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    
    JSR     PRINT_SPACE
    
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    JSR     PRINT_MODE_REG
    
    JSR     PRINT_COMMA
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_LEA
    JSR     PRINT_CURRENT_ADDR
    LEA     LEA_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    
    JSR     PRINT_SPACE
    
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    JSR     PRINT_MODE_REG
    
    JSR     PRINT_COMMA
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT 
PRINT_CMP
    JSR     PRINT_CURRENT_ADDR
    LEA     CMP_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    JSR     PRINT_MODE_REG
    
    JSR     PRINT_COMMA
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
PRINT_CLR
    JSR     PRINT_CURRENT_ADDR
    LEA     CLR_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
    
PRINT_ASD
    JSR     PRINT_CURRENT_ADDR
    CMPI.B  #$0,DIRECTION
    BEQ     PRINT_RIGHT_ASD
    BRA     PRINT_LEFT_ASD
PRINT_RIGHT_ASD
    LEA     ASR_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    BRA     CONTINUE_PRINT_ASD
PRINT_LEFT_ASD
    LEA     ASL_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    BRA     CONTINUE_PRINT_ASD
CONTINUE_PRINT_ASD
    CMPI.B  #$7,SOURCE_MODE
    BEQ     PRINT_ASD_IMMEDIATE
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    JSR     PRINT_MODE_REG
    BRA     CONTINUE_PRINT_ASD_
    
PRINT_ASD_IMMEDIATE
    JSR     PRINT_HASHTAG
    JSR     PRINT_DOLLAR
    CMPI.B  #$0,SOURCE_REG
    BEQ     PRINT_ASD_8
    MOVE.B  SOURCE_REG,D3
    JSR     BYPASS
    BRA     CONTINUE_PRINT_ASD_
PRINT_ASD_8
    MOVE.B  #$8,D3
    JSR     BYPASS
    BRA     CONTINUE_PRINT_ASD_

CONTINUE_PRINT_ASD_
    JSR     PRINT_COMMA    
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
    
PRINT_LSD
    JSR     PRINT_CURRENT_ADDR
    CMPI.B  #$0,DIRECTION
    BEQ     PRINT_RIGHT_LSD
    BRA     PRINT_LEFT_LSD
PRINT_RIGHT_LSD
    LEA     LSR_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    BRA     CONTINUE_PRINT_LSD
PRINT_LEFT_LSD
    LEA     LSL_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    BRA     CONTINUE_PRINT_LSD
CONTINUE_PRINT_LSD
    CMPI.B  #$7,SOURCE_MODE
    BEQ     PRINT_LSD_IMMEDIATE
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    JSR     PRINT_MODE_REG
    BRA     CONTINUE_PRINT_LSD_
    
PRINT_LSD_IMMEDIATE
    JSR     PRINT_HASHTAG
    JSR     PRINT_DOLLAR
    CMPI.B  #$0,SOURCE_REG
    BEQ     PRINT_LSD_8
    MOVE.B  SOURCE_REG,D3
    JSR     BYPASS
    BRA     CONTINUE_PRINT_LSD_
PRINT_LSD_8
    MOVE.B  #$8,D3
    JSR     BYPASS
    BRA     CONTINUE_PRINT_LSD_

CONTINUE_PRINT_LSD_
    JSR     PRINT_COMMA    
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT

    
PRINT_ROD
    JSR     PRINT_CURRENT_ADDR
    CMPI.B  #$0,DIRECTION
    BEQ     PRINT_RIGHT_ROD
    BRA     PRINT_LEFT_ROD
PRINT_RIGHT_ROD
    LEA     ROR_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    BRA     CONTINUE_PRINT_ROD
PRINT_LEFT_ROD
    LEA     ROL_OP,A1
    JSR     TASK14
    JSR     PRINT_S2
    BRA     CONTINUE_PRINT_ROD
CONTINUE_PRINT_ROD
    CMPI.B  #$7,SOURCE_MODE
    BEQ     PRINT_ASD_IMMEDIATE
    JSR     CLEAR_REGS
    MOVE.B  SOURCE_MODE,D2
    MOVE.B  SOURCE_REG,D4
    JSR     PRINT_MODE_REG
    BRA     CONTINUE_PRINT_ROD_
    
PRINT_ROD_IMMEDIATE
    JSR     PRINT_HASHTAG
    JSR     PRINT_DOLLAR
    CMPI.B  #$0,SOURCE_REG
    BEQ     PRINT_ASD_8
    MOVE.B  SOURCE_REG,D3
    JSR     BYPASS
    BRA     CONTINUE_PRINT_ROD_
PRINT_ROD_8
    MOVE.B  #$8,D3
    JSR     BYPASS
    BRA     CONTINUE_PRINT_ROD_

CONTINUE_PRINT_ROD_
    JSR     PRINT_COMMA    
    
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT

    
    
PRINT_ASD1
    JSR     PRINT_CURRENT_ADDR
    CMPI.B  #$0,DIRECTION
    BEQ     PRINT_RIGHT_ASD1
    BRA     PRINT_LEFT_ASD1
PRINT_RIGHT_ASD1
    LEA     ASR_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    BRA     CONTINUE_PRINT_ASD1
PRINT_LEFT_ASD1
    LEA     ASL_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    BRA     CONTINUE_PRINT_ASD1
CONTINUE_PRINT_ASD1
    JSR     PRINT_SPACE
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
   
PRINT_LSD1
    JSR     PRINT_CURRENT_ADDR
    CMPI.B  #$0,DIRECTION
    BEQ     PRINT_RIGHT_LSD1
    BRA     PRINT_LEFT_LSD1
PRINT_RIGHT_LSD1
    LEA     LSR_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    BRA     CONTINUE_PRINT_LSD1
PRINT_LEFT_LSD1
    LEA     LSL_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    BRA     CONTINUE_PRINT_LSD1
CONTINUE_PRINT_LSD1
    JSR     PRINT_SPACE
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
    
PRINT_ROD1
    JSR     PRINT_CURRENT_ADDR
    CMPI.B  #$0,DIRECTION
    BEQ     PRINT_RIGHT_ROD1
    BRA     PRINT_LEFT_ROD1
PRINT_RIGHT_ROD1
    LEA     ROR_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    BRA     CONTINUE_PRINT_ROD1
PRINT_LEFT_ROD1
    LEA     ROL_OP,A1
    JSR     TASK14
    JSR     PRINT_S4
    BRA     CONTINUE_PRINT_ROD1
CONTINUE_PRINT_ROD1
    JSR     PRINT_SPACE
    JSR     CLEAR_REGS
    MOVE.B  DESTINATION_MODE,D2
    MOVE.B  DESTINATION_REG,D4
    JSR     PRINT_MODE_REG
    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
    
PRINT_DATA 
    JSR     PRINT_CURRENT_ADDR
    LEA     DATA_OP,A1
    JSR     TASK14
    
    JSR     PRINT_SPACE
    
    JSR     PRINT_DOLLAR
    
    MOVE.W  (A2),D2
    JSR     BITS_1_8
    MOVE.B  D2,D3
    JSR     BYPASS
    MOVE.W  (A2),D2
    JSR     BITS_9_16
    MOVE.B  D2,D3
    JSR     BYPASS

    JSR     PRINT_NEW_LINE
    JMP     MOVENEXT
    
    
    

PRINT_CURRENT_ADDR
    JSR     CLEAR_REGS
    MOVEA.L  #$00004000,A1
    MOVE.L  A1,A3
    MOVE.L  A2,A6
    MOVE.L  #$4,D7
    MOVE.L  A6,D4
    MOVE.L  #$00004500,A4
    MOVE.L  D4,(A4)
CURR_ADDR_LOOP
    LEA     HEX_ASCII,A5
    CMPI.B  #$0,D7
    BEQ     FINISH_CURR_ADDR
    MOVE.B  (A4),D2
    LSR.B   #$4,D2
    MOVE.B  (0,A5,D2),(A3)+
    MOVE.B  (A4),D2
    LSL.B   #$4,D2
    LSR.B   #$4,D2
    LEA     HEX_ASCII,A5
    MOVE.B  (0,A5,D2),(A3)+
    ADDA    #$1,A4
    SUBI    #$1,D7
    BRA     CURR_ADDR_LOOP
FINISH_CURR_ADDR
    MOVE.B  #$00,(A3)+
    JSR     TASK14
    JSR     PRINT_SPACE
    RTS
                                          ;MODULAR SUBROUTINES
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
BITS_3_4
    LSL.W   #$2,D2
    LSR.W   #$8,D2
    LSR.W   #$6,D2
    RTS
BITS_6
    LSL.W   #$5,D2
    LSR.W   #$8,D2
    LSR.W   #$7,D2
    RTS
BITS_5_7
    LSL.W #$4,D2
    LSR.W #$8,D2
    LSR.W #$5,D2
    RTS
BITS_1_8
    LSR.W #$8,D2
    RTS
BITS_8
    LSL.W #$7,D2
    LSR.W #$8,D2
    LSR.W #$7,D2
    RTS
BITS_10
    LSL.W #$8,D2
    LSL.W #$1,D2
    LSR.W #$8,D2
    LSR.W #$7,D2
    RTS
BITS_8_10
    LSL.W #$7,D2
    LSR.W #$8,D2
    LSR.W #$5,D2
    RTS
BITS_9_10
    LSL.W #$8,D2
    LSR.W #$8,D2
    LSR.W #$6,D2
    RTS
BITS_11
    LSL.W	#$8,D2
    LSL.W	#$2,D2
    LSR.W	#$8,D2
    LSR.W	#$7,D2
    RTS
BITS_12_13
    LSL.W	#$8,D2
    LSL.W	#$3,D2
    LSR.W	#$8,D2
    LSR.W	#$6,D2
    RTS
BITS_11_13
    LSL.W #$8,D2
    LSL.W #$2,D2
    LSR.W #$8,D2
    LSR.W #$5,D2
    RTS
BITS_9_16
    LSL.W #$8,D2
    LSR.W #$8,D2
    RTS
BITS_14_16
    LSL.W #$8,D2
    LSL.W #$5,D2
    LSR.W #$8,D2
    LSR.W #$5,D2
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
PRINT_S2
    CMP.B   #$0,SIZE
    BEQ     PRINT_BYTE
    CMP.B   #$1,SIZE
    BEQ     PRINT_WORD
    CMP.B   #$2,SIZE
    BEQ     PRINT_LONG
PRINT_S3
    CMP.B   #$0,SIZE
    BEQ     PRINT_WORD
    CMP.B   #$1,SIZE
    BEQ     PRINT_LONG
PRINT_S4
    BRA     DONE
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
PRINT_MODE_REG
    CMP     #$7,D2
    BEQ     PRINT_ABSOLUTE_OR_IMMEDIATE
    MULS.W  #$30,D2 *Print from ASCII table
    MULS.W  #$6,D4
    ADD.W   D2,D4
    LEA     ASCII_TABLE,A1
    ADDA    D4,A1
    JSR     TASK14
    RTS
PRINT_ABSOLUTE_OR_IMMEDIATE
    CLR.L       D3
    MOVEA.L     A2,A6
    ADDA.L      #$2,A6
    CMP.W   #$0,D4
    BEQ     ABSOLUTE_SHORT
    CMP.W   #$1,D4
    BEQ     ABSOLUTE_LONG
    CMP.W   #$4,D4
    BEQ     IMMEDIATE
ABSOLUTE_SHORT
    JSR         PRINT_DOLLAR
    JSR         PRINT_IMMEDIATE_WORD
    RTS
ABSOLUTE_LONG 
    JSR         PRINT_DOLLAR
    JSR         PRINT_IMMEDIATE_LONG
    RTS
IMMEDIATE
    JSR         PRINT_HASHTAG
    JSR         PRINT_DOLLAR
    MOVE.B      SIZE,D3
    JSR         CLEAR_REGS
    MOVE.B      SIZETYPE,D2
    CMPI.B      #$1,D2
    BEQ         TO_COMPARE_S1
    CMPI.B      #$2,D2
    BEQ         TO_COMPARE_S2
    CMPI.B      #$3,D2
    BEQ         TO_COMPARE_S3
TO_COMPARE_S1
    JSR         COMPARE_SIZE1
    RTS
TO_COMPARE_S2
    JSR         COMPARE_SIZE2
    RTS
TO_COMPARE_S3
    JSR         COMPARE_SIZE3
    RTS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************



                                            ;GET SPECIFIC BITS
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************    
* ----------------------        
* * Get Specified Bits *
* ---------------------- 
* put bits in D4 register

;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************  


                                ;PRINT IMMEDIATE BYTE,WORD,LONG
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
COMPARE_SIZE1
    CMP.W   #$1,D3
    BEQ     PRINT_IMMEDIATE_WORD
    CMP.W   #$2,D3
    BEQ     PRINT_IMMEDIATE_LONG
    CMP.W   #$3,D3
    BEQ     PRINT_IMMEDIATE_WORD
COMPARE_SIZE2
    CMP.W   #$0,D3
    BEQ     PRINT_IMMEDIATE_WORD
    CMP.W   #$1,D3
    BEQ     PRINT_IMMEDIATE_WORD
    CMP.W   #$2,D3
    BEQ     PRINT_IMMEDIATE_LONG
COMPARE_SIZE3
    CMP.W   #$0,D3
    BEQ     PRINT_IMMEDIATE_WORD
    CMP.W   #$1,D3
    BEQ     PRINT_IMMEDIATE_LONG
PRINT_IMMEDIATE_BYTE
    CLR.L   D3
    MOVE.B  (A6)+,D3
BYPASS
    MOVE.B  D3,D4
    LSR.B   #4,D4
    BSR     PRINT_HEX_BYTE
    MOVE.B  D3,D4
    LSL.B   #4,D4
    LSR.B   #4,D4
    BSR     PRINT_HEX_BYTE
    RTS
PRINT_IMMEDIATE_WORD
    ADDA.L  #$2,A2
    BSR     PRINT_IMMEDIATE_BYTE
    BSR     PRINT_IMMEDIATE_BYTE
    RTS
PRINT_IMMEDIATE_LONG
    ADDA.L  #$4,A2
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
    BRA     TASK14
PRINT_HEX_1
    LEA     HEX_1,A1
    BRA     TASK14
PRINT_HEX_2
    LEA     HEX_2,A1
    BRA     TASK14
PRINT_HEX_3
    LEA     HEX_3,A1
    BRA     TASK14
PRINT_HEX_4
    LEA     HEX_4,A1
    BRA     TASK14
PRINT_HEX_5
    LEA     HEX_5,A1
    BRA     TASK14
PRINT_HEX_6
    LEA     HEX_6,A1
    BRA     TASK14
PRINT_HEX_7
    LEA     HEX_7,A1
    BRA     TASK14
PRINT_HEX_8
    LEA     HEX_8,A1
    BRA     TASK14
PRINT_HEX_9
    LEA     HEX_9,A1
    BRA     TASK14
PRINT_HEX_A
    LEA     HEX_A,A1
    BRA     TASK14
PRINT_HEX_B
    LEA     HEX_B,A1
    BRA     TASK14
PRINT_HEX_C
    LEA     HEX_C,A1
    BRA     TASK14
PRINT_HEX_D
    LEA     HEX_D,A1
    BRA     TASK14
PRINT_HEX_E       
    LEA     HEX_E,A1
    BRA     TASK14
PRINT_HEX_F
    LEA     HEX_F,A1
    BRA     TASK14
                                           ;PRINT OTHER
;///////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************************************************************
* ----------------------------
* print length (.B | .W | .L) 
* ----------------------------
PRINT_LENGTH
    CMP.B   #$01,D4
    BEQ     PRINT_B
    CMP.B   #$03,D4
    BEQ     PRINT_W
    BRA     SHOW_ERROR
    BEQ     PRINT_L
    BRA     show_error
    
PRINT_B
    LEA         BYTE_SIZE,A1
    MOVE.B      #14,D0          
    TRAP        #15    
    RTS
    
PRINT_W
    LEA         WORD_SIZE,A1
    MOVE.B      #14,D0         
    TRAP        #15
    RTS 

PRINT_L
    LEA         LONG_SIZE,A1
    MOVE.B      #14,D0         
    TRAP        #15
    RTS 
    
* --------------------
* * Print comma ', ' *
* --------------------
PRINT_COMMA
    LEA     COMMA,A1
    JSR     TASK14
    RTS
    
* ---------------------
* ** Print hashtag # **
* ---------------------
PRINT_HASHTAG
    LEA     HASHTAG,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS
    
* ---------------------
* ** Print dollar $ **
* ---------------------
PRINT_DOLLAR
    LEA     DOLLAR,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS
    
* ------------------
* * Print new line *
* ------------------
PRINT_NEW_LINE
    LEA     NEW_LINE,A1
    MOVE.B  #13,D0
    TRAP    #15
    RTS

* ------------------
* * Print new line *
* ------------------
PRINT_SPACE
    LEA     NEW_LINE,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS
**********************
****** ERRORS ********
**********************

  
SHOW_ERROR
SHOW_ERROR

* **** Show Error ****      // TO DO: Come up with more descriptive errors
* --------------------
SHOW_ERROR
    LEA     ERROR,A1
    MOVE.B  #14,D0
    TRAP    #15
    BRA     TESTLOOP       

* --------------------------------------
* **** Invalid User Input Detected ****
* --------------------------------------
INVALID_INPUT_DETECTED
    *LEA     INVALID,A1
    MOVE.B  #14,D0
    TRAP    #15
    BRA     LOOP_INPUT       
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
TERMINATE
    MOVE.B  #9,D0
    TRAP    #15
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
* Put variables and constants here

WELCOME_MSG						DC.B	'Welcome to our Disassembler!',0
ASK_FOR_STARTING_ADDRESS_MSG	DC.B    'Please specify the starting address',0
ASK_FOR_ENDING_ADDRESS_MSG		DC.B    'Please specify the ending address',0
INVALID_USER_INPUT_MSG			DC.B	'Please enter a valid address ($00002000 - $000FFFFF)',0
PRESS_KEY_CONTINUE              DC.B    'Please press any key to display next page',0	 


*----------------------------------------------------------
DOLLAR      DC.B    '$',0
HASHTAG     DC.B    '#',0
PLUS        DC.B    '+',0
MINUS       DC.B    '-',0
PAREN_OPEN  DC.B    '(',0
PAREN_CLOSE DC.B    ')',0
COMMA       DC.B    ',',0
NEW_LINE    DC.B    '    ',0
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
DATA_OP     DC.B    'DATA',0
*-------------------SIZE OF OP-----------------------------
BYTE_SIZE   DC.B    '.B   ',0
WORD_SIZE   DC.B    '.W   ',0
LONG_SIZE   DC.B    '.L   ',0
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
DIRECTION               DS.B    1
SIZETYPE                DS.B    1
CURRENT_ADDR            DS.L    1
OUTPUT_COUNTER          DS.B    1


START_ADDR              DS.L    1
END_ADDR                DS.L    1

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
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
