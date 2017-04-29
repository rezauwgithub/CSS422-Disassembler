*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    MEMORY READ  $005000,$00501F
    MEMORY READ  $006000,$00601F
* Put program code here
    MOVE.B  #$7,D0
    LEA     ASCIIDATA,A1
    MULS    #$4,D0
    ADDA    D0,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #$FF,$5001
    
    
    CLR.L   D0
    
    MOVE.B  #$4,D0
    LEA     ASCIIADDRESS,A1
    MULS    #$4,D0
    ADDA    D0,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    SIMHALT             ; halt simulator

* Put variables and constants here
    ORG $5000
ASCIIDATA
    DC.B    'D0',0,0
    DC.B    'D1',0,0
    DC.B    'D2',0,0
    DC.B    'D3',0,0
    DC.B    'D4',0,0
    DC.B    'D5',0,0
    DC.B    'D6',0,0
    DC.B    'D7',0,0
    
    ORG $6000
ASCIIADDRESS
    DC.B    'A0',0,0
    DC.B    'A1',0,0
    DC.B    'A2',0,0
    DC.B    'A3',0,0
    DC.B    'A4',0,0
    DC.B    'A5',0,0
    DC.B    'A6',0,0
    DC.B    'A7',0,0
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
