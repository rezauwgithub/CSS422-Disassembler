*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000

* Put program code here
    MOVE.B  D0,D1
    MOVE.B  D0,D2
    MOVE.B  D0,D3
    MOVE.B  D0,D4
    MOVE.B  D0,D5
    MOVE.B  D0,D6
    MOVE.B  D0,D7
    
    
    MOVE.B  D1,D0
    MOVE.B  D2,D0
    MOVE.B  D3,D0
    MOVE.B  D4,D0
    MOVE.B  D5,D0
    MOVE.B  D6,D0
    MOVE.B  D7,D0
    
    MOVEA.W #$7FFF,A0
    MOVEA.L #$00007FFF,A6
    MOVE.W  $FFFF,D1
    
    ADD.B   D0,D2
    ADDA.W  #$4444,A5
    
    ADDI.L  #$1234ABCD,D3
    MOVEQ   #$AB,D7
    ADDQ.W  #$6,D3
    
    SUB.W   D3,$5000
    MULS    #$0000FFFF,D0
    AND.W     #$44FF,D4
    
    OR.L    #$ABCD1234,D0
    DIVU    $FFFF5000,D4
    LEA     $0000FFFF,A6
    CMP.L   #$00004000,D5
    
    MOVE.B  D0,D1
    MOVE.B  D0,D2
    MOVE.B  D0,D3
    MOVE.B  D0,D4
    MOVE.B  D0,D5
    MOVE.B  D0,D6
    MOVE.B  D0,D7
    
    
    MOVE.B  D1,D0
    MOVE.B  D2,D0
    MOVE.B  D3,D0
    MOVE.B  D4,D0
    MOVE.B  D5,D0
    MOVE.B  D6,D0
    MOVE.B  D7,D0
    
    MOVEA.W #$7FFF,A0
    MOVEA.L #$00007FFF,A6
    MOVE.W  $FFFF,D1
    
    ADD.B   D0,D2
    ADDA.W  #$4444,A5
    
    ADDI.L  #$1234ABCD,D3
    MOVEQ   #$AB,D7
    ADDQ.W  #$6,D3
    
    SUB.W   D3,$5000
    MULS    #$0000FFFF,D0
    AND.W     #$44FF,D4
    
    OR.L    #$ABCD1234,D0
    DIVU    $FFFF5000,D4
    LEA     $0000FFFF,A6
    CMP.L   #$00004000,D5
	
	JSR		JSR_TEST
	*CLR.B   D2
	*CLR.W   D3
	*CLR.L   D4
	NOP
	RTS
	
	
JSR_TEST	; Added by Reza
	RTS
	
	

* Put variables and constants here






















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
