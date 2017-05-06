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
    
    MOVEA.W #$8000,A0
    MOVEA.L #$FFFF7FFF,A6
    MOVE.W  $FFFF,D1
    
    ADD.B   D0,D2
    ADDA.W  #$4444,A5
    
    
    
* Put variables and constants here




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
