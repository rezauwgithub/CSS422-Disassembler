*------------------------------------------------------------
* Title      : Disassembler Test
* Written by : Eric Kinney
* Date       :
* Description: Testing for Disassembler
*------------------------------------------------------------
    ORG    $8000  

;//////////////////////////////////////////////////////////////////////////////////////
* ADD         
    ADD.B  D0,D0 
    ADD.B  D7,D1                
    ADD.B  (A1),D2
    ADD.B  D2,(A2)                 
    ADD.B  (A3)+,D3
    ADD.B  D4,(A4)+               
    ADD.B  -(A5),D5
    ADD.B  D6,-(A6)               
    ADD.B  $4000,D0
    ADD.B  D0,$7999               
    ADD.B  $0001,D0
    ADD.B  D0,$8000               
    ADD.B  #$7F,D7 
    ADD.B  #79,D7                                           
    
    ADD.W  D0,D0                 
    ADD.W  A1,D1 
    ADD.W  D2,A2                 
    ADD.W  (A3),D3 
    ADD.W  D4,(A4)                
    ADD.W  (A5)+,D5 
    ADD.W  D6,(A6)+               
    ADD.W  -(A7),D7
    ADD.W  D0,-(A7)               
    ADD.W  $4000,D1  
    ADD.W  D2,$6000               
    ADD.W  $A000,D3  
    ADD.W  D4,$8000              
    ADD.W  #$80,D5               
    ADD.W  #$7FFF,D6 
    ADD.W  #7999,D6                          
    
    ADD.L  D0,D0                  
    ADD.L  A0,D1  
    ADD.L  D1,A2               
    ADD.L  (A1),D2
    ADD.L  D2,(A3)                
    ADD.L  (A2)+,D3 
    ADD.L  D3,(A4)+               
    ADD.L  -(A3),D4 
    ADD.L  D4,-(A5)               
    ADD.L  $4000,D5 
    ADD.L  D5,$6000             
    ADD.L  $A000,D6 
    ADD.L  D6,$8000             
    ADD.L  #$7F,D7                
    ADD.L  #$7FFF,D0              
    ADD.L  #$7FFFFFFF,D1 
    ADD.L  #79999999,D1    
                   
    ADDA.W  $7FFF,A1             
    ADDA.W  $0001,A2             
    ADDA.W  #$7F,A3              
    ADDA.W  #$7FFF,A4  
    ADDA.W  #7999,A5  
    ADDA.W  D0,A0                
    ADDA.W  A1,A1    
    ADDA.W  A2,A3               
    ADDA.W  (A4),A5  
    ADDA.W  (A5),A5              
    ADDA.W  (A5)+,A6
    ADDA.W  (A7)+,A7
    ADDA.W  -(A3),A4   
    ADDA.W  -(A3),A3          
              
           
    ADDA.L  $7FFF,A1             
    ADDA.L  $0001,A2              
    ADDA.L  #$7F,A3               
    ADDA.L  #$7FFF,A4            
    ADDA.L  #$7FFFFFFF,A5  
    ADDA.L  #79,A6               
    ADDA.L  #7999,A7            
    ADDA.L  #79999999,A0    
    ADDA.L  D0,A0                 
    ADDA.L  A0,A1   
    ADDA.L  A1,A1             
    ADDA.L  (A1),A2 
    ADDA.L  (A3),A3             
    ADDA.L  (A3)+,A4
    ADDA.L  (A4)+,A4              
    ADDA.L  -(A4),A5              
    ADDA.L  -(A5),A6         
    
    ADDI.B  #$7F,$1000             
    ADDI.B  #$7F,$2000 
    ADDI.B  #$7F,D7               
    ADDI.B  #$7F,(A0)              
    ADDI.B  #$7F,(A1)+             
    ADDI.B  #$7F,-(A2)
    ADDI.B  #79,D6               
    ADDI.B  #79,(A3)              
    ADDI.B  #79,(A4)+             
    ADDI.B  #79,-(A5)              
            
    ADDI.W  #$7FFF,$1000          
    ADDI.W  #$7F,$2000   
    ADDI.W  #$7F,D7                
    ADDI.W  #$7F,(A0)              
    ADDI.W  #$7FFF,(A1)+          
    ADDI.W  #$7F,-(A2) 
    ADDI.W  #79,D6                
    ADDI.W  #79,(A3)              
    ADDI.W  #7999,(A4)+          
    ADDI.W  #79,-(A5)             
             
    ADDI.L  #$7FFFFFFF,$1000       
    ADDI.L  #$7F,$2000    
    ADDI.L  #$7F,D7                
    ADDI.L  #$7FFFFFFF,(A0)        
    ADDI.L  #$7F,(A1)+             
    ADDI.L  #$7FFF,-(A2) 
    ADDI.L  #79,D6                
    ADDI.L  #79999999,(A3)        
    ADDI.L  #79,(A4)+             
    ADDI.L  #7999,-(A5)          

    ADDQ.B  #$1,$1000              
    ADDQ.B  #$2,$2000             
    ADDQ.B  #$3,$FFFF 
    ADDQ.B  #$4,D0                        
    ADDQ.B  #$5,(A1)              
    ADDQ.B  #$6,(A2)+             
    ADDQ.B  #$7,-(A3)              
    ADDQ.B  #8,(A4) 

    ADDQ.W  #$1,$1000              
    ADDQ.W  #$2,$2000             
    ADDQ.W  #$3,$FFFF 
    ADDQ.W  #$4,D0                
    ADDQ.W  #$5,A1                
    ADDQ.W  #$6,(A2)              
    ADDQ.W  #$7,(A3)+             
    ADDQ.W  #$8,-(A4)  
    ADDQ.W  #8,-(A5)             
  
    ADDQ.L  #$1,$1000              
    ADDQ.L  #$2,$2000             
    ADDQ.L  #$3,$FFFF    
    ADDQ.L  #$4,D0                
    ADDQ.L  #$5,A1                
    ADDQ.L  #$6,(A2)              
    ADDQ.L  #$7,(A3)+             
    ADDQ.L  #$8,-(A4)              
    ADDQ.L  #8,(A5)
    
;//////////////////////////////////////////////////////////////////////////////////////
* AND    
    AND.B  D0,D0   
    AND.B  D1,D2               
    AND.B  (A0),D1 
    AND.B  D1,(A1)               
    AND.B  (A2)+,D3
    AND.B  D3,(A4)+            
    AND.B  -(A3),D4
    AND.B  D4,-(A5)               
    AND.B  $4FFF,D5 
    AND.B  D6,$0001             
    AND.B  $7FFF,D7 
    AND.B  D0,$8001               
    AND.B  #$7F,D1  
    AND.B  #79,D1              
                    
    AND.W  D0,D0   
    AND.W  D1,D2               
    AND.W  (A0),D1 
    AND.W  D1,(A1)               
    AND.W  (A2)+,D3
    AND.W  D3,(A4)+            
    AND.W  -(A3),D4
    AND.W  D4,-(A5)               
    AND.W  $4FFF,D5 
    AND.W  D6,$0001             
    AND.W  $7FFF,D7 
    AND.W  D0,$8001               
    AND.W  #$7F,D1  
    AND.W  #79,D1 
    AND.W  #$7FFF,D2  
    AND.W  #7999,D2              

    AND.L  D0,D0   
    AND.L  D1,D2               
    AND.L  (A0),D1 
    AND.L  D1,(A1)               
    AND.L  (A2)+,D3
    AND.L  D3,(A4)+            
    AND.L  -(A3),D4
    AND.L  D4,-(A5)               
    AND.L  $7FFF,D5 
    AND.L  $0001,D5 
    AND.L  D6,$0001              
    AND.L  D0,$8001               
    AND.L  #$7F,D1  
    AND.L  #79,D1 
    AND.L  #$7FFF,D2  
    AND.L  #7999,D2  
    AND.L  #$7FFFFFFF,D2  
    AND.L  #79999999,D2  
    
;//////////////////////////////////////////////////////////////////////////////////////
* CLR 
    CLR.B  $1000              
    CLR.B  $7FFF             
    CLR.B  $0001   
    CLR.B  D0                         
    CLR.B  (A1)              
    CLR.B  (A2)+             
    CLR.B  -(A3)              

    CLR.W  $1000              
    CLR.W  $7FFF             
    CLR.W  $0001   
    CLR.W  D0                         
    CLR.W  (A1)              
    CLR.W  (A2)+             
    CLR.W  -(A3)
    
    CLR.L  $1000              
    CLR.L  $7FFF             
    CLR.L  $0001   
    CLR.L  D0                         
    CLR.L  (A1)              
    CLR.L  (A2)+             
    CLR.L  -(A3)  

;//////////////////////////////////////////////////////////////////////////////////////
* CMP 
    CMP.B  $1000,D1              
    CMP.B  $0001,D2
    CMP.B  $7FFF,D3               
    CMP.B  #$7F,D4
    CMP.B  #79,D5     
    CMP.B  D0,D0                 
    CMP.B  (A1),D6                
    CMP.B  (A2)+,D7              
    CMP.B  -(A3),D0 

    CMP.W  $1000,D1              
    CMP.W  $0001,D2
    CMP.W  $7FFF,D3               
    CMP.W  #$7F,D4
    CMP.W  #79,D5 
    CMP.W  #$7FFF,D4
    CMP.W  #7999,D5     
    CMP.W  D0,D0                 
    CMP.W  (A1),D6                
    CMP.W  (A2)+,D7              
    CMP.W  -(A3),D0   

    CMP.L  $1000,D1              
    CMP.L  $0001,D2
    CMP.L  $7FFF,D3               
    CMP.L  #$7F,D4
    CMP.L  #79,D5 
    CMP.L  #$7FFF,D4
    CMP.L  #7999,D5
    CMP.L  #$7FFFFFFF,D4
    CMP.L  #79999999,D5      
    CMP.L  D0,D0                 
    CMP.L  (A1),D6                
    CMP.L  (A2)+,D7              
    CMP.L  -(A3),D0              
  
;//////////////////////////////////////////////////////////////////////////////////////
* DIVU
    DIVU  D0,D0
    DIVU  $1000,D1              
    DIVU  $0001,D2
    DIVU  $7FFF,D1              
    DIVU  $FFFF,D2               
    DIVU  #$7F,D3                
    DIVU  #$7FFF,D4 
    DIVU  #79,D3                
    DIVU  #7999,D4                                  
    DIVU  (A0),D1               
    DIVU  (A1)+,D2               
    DIVU  -(A2),D3               
    
;//////////////////////////////////////////////////////////////////////////////////////
* LEA 
    LEA $1000,A1               
    LEA $0001,A2
    LEA $7FFF,A3
    LEA $FFFF,A4 
    LEA (A1),A5                               
    
;//////////////////////////////////////////////////////////////////////////////////////
* MOVE  
    MOVE.B  $7FFF,$8000
    MOVE.B  $8001,$FFFF
    MOVE.B  #$7F,$0001
    MOVE.B  #79,$7FFF
    MOVE.B  D0,D1
    MOVE.B  (A1),(A2)+
    MOVE.B  (A3)+,-(A4)
    MOVE.B  -(A5),$7FFF

    MOVE.W  $7FFF,$8000
    MOVE.W  $8001,$FFFF
    MOVE.W  #$7F,$0001
    MOVE.W  #79,$7FFF
    MOVE.W  #$7FFF,$1000
    MOVE.W  #7999,$2000    
    MOVE.W  D0,D1
    MOVE.W  D1,A1
    MOVE.W  (A1),(A2)+
    MOVE.W  (A3)+,-(A4)
    MOVE.W  -(A5),$7FFF

    MOVE.L  $7FFF,$8000
    MOVE.L  $8001,$FFFF
    MOVE.L  #$7F,$0001
    MOVE.L  #79,$7FFF
    MOVE.L  #$7FFF,$1000
    MOVE.L  #7999,$2000
    MOVE.L  #$7FFFFFFF,$1000
    MOVE.L  #79999999,$2000    
    MOVE.L  D0,D1
    MOVE.L  D1,A1
    MOVE.L  (A1),(A2)+
    MOVE.L  (A3)+,-(A4)
    MOVE.L  -(A5),$7FFF
       
    MOVEA.W  $7FFF,A1               
    MOVEA.W  $FFFF,A2              
    MOVEA.W  #$7F,A3                
    MOVEA.W  #$7FFF,A4
    MOVEA.W  #79,A3                
    MOVEA.W  #7999,A4
    MOVEA.W  D0,A5                  
    MOVEA.W  A5,A6                  
    MOVEA.W  (A0),A1               
    MOVEA.W  (A2)+,A3              
    MOVEA.W  -(A4),A5              
 
    MOVEA.L  $7FFF,A1               
    MOVEA.L  $FFFF,A2              
    MOVEA.L  #$7F,A3                
    MOVEA.L  #$7FFF,A4
    MOVEA.L  #$7FFFFFFF,A5
    MOVEA.L  #79,A3                
    MOVEA.L  #7999,A4
    MOVEA.L  #79999999,A5
    MOVEA.L  D0,A5                  
    MOVEA.L  A5,A6                  
    MOVEA.L  (A0),A1               
    MOVEA.L  (A2)+,A3              
    MOVEA.L  -(A4),A5                     
    
    MOVEQ  #$7F,D6
    MOVEQ  #79,D7 
                 
    MOVEM.W  $7FFF,D1/D2/D3/D4/A0/A1/A2/A3          
    MOVEM.W  $FFFF,D0/D2/D3/D1/A4/A5/A6/A0
    MOVEM.W  A0/A1/A2/A3/D1/D2/D3/D4,$7FFF          
    MOVEM.W  A0/A2/A4/A6/D1/D3/D5/D7,$FFFF           
    MOVEM.W  (SP)+,D0-D7/A0-A7   
    MOVEM.W  A7-A0/D7-D0,-(SP) 
    MOVEM.W  (A1),D1/D2/D3/D4/A0/A1/A2/A3             
    MOVEM.W  (A2)+,D0/D2/D3/D1/A4/A5/A6/A0           
    MOVEM.W  A0/A1/A2/A3/D1/D2/D3/D4,(A3)           
    MOVEM.W   A0/A2/A4/A6/D1/D3/D5/D7,-(A4)           
         
    MOVEM.L  $7FFF,D1/D2/D3/D4/A0/A1/A2/A3          
    MOVEM.L  $FFFF,D0/D2/D3/D1/A4/A5/A6/A0
    MOVEM.L  A0/A1/A2/A3/D1/D2/D3/D4,$7FFF          
    MOVEM.L  A0/A2/A4/A6/D1/D3/D5/D7,$FFFF           
    MOVEM.L  (SP)+,D0-D7/A0-A7   
    MOVEM.L  A7-A0/D7-D0,-(SP) 
    MOVEM.L  (A1),D1/D2/D3/D4/A0/A1/A2/A3             
    MOVEM.L  (A2)+,D0/D2/D3/D1/A4/A5/A6/A0           
    MOVEM.L  A0/A1/A2/A3/D1/D2/D3/D4,(A3)           
    MOVEM.L   A0/A2/A4/A6/D1/D3/D5/D7,-(A4)                          
                     
;//////////////////////////////////////////////////////////////////////////////////////
* MULS
    MULS  $0001,D1              
    MULS  $1000,D2              
    MULS  #$7F,D3                
    MULS  #$7FFF,D4
    MULS  #79,D5                
    MULS  #7999,D6        
    MULS  D0,D0                                 
    MULS  (A0),D1               
    MULS  (A1)+,D2               
    MULS  -(A2),D3               
     
;//////////////////////////////////////////////////////////////////////////////////////
* OR
    OR.B  $7FFF,D1
    OR.B  D1,$1000              
    OR.B  $FFFF,D2
    OR.B  D2,$2000               
    OR.B  #$7F,D3 
    OR.B  #79,D4  
    OR.B  D0,D0
    OR.B  D0,D1                  
    OR.B  (A0),D1
    OR.B  D2,(A3)                 
    OR.B  (A1)+,D2 
    OR.B  D3,(A4)+             
    OR.B  -(A2),D3 
    OR.B  D4,-(A5)              
              
    OR.W  $7FFF,D1
    OR.W  D1,$1000              
    OR.W  $FFFF,D2
    OR.W  D2,$2000               
    OR.W  #$7F,D3 
    OR.W  #79,D4 
    OR.W  #$7FFF,D3 
    OR.W  #7999,D4  
    OR.W  D0,D0
    OR.W  D0,D1                  
    OR.W  (A0),D1
    OR.W  D2,(A3)                 
    OR.W  (A1)+,D2 
    OR.W  D3,(A4)+             
    OR.W  -(A2),D3 
    OR.W  D4,-(A5)   
                
    OR.L  $7FFF,D1
    OR.L  D1,$1000              
    OR.L  $FFFF,D2
    OR.L  D2,$2000               
    OR.L  #$7F,D3 
    OR.L  #79,D4 
    OR.L  #$7FFF,D3 
    OR.L  #7999,D4 
    OR.L  #$7FFFFFFF,D3 
    OR.L  #79999999,D4 
    OR.L  D0,D0
    OR.L  D0,D1                  
    OR.L  (A0),D1
    OR.L  D2,(A3)                 
    OR.L  (A1)+,D2 
    OR.L  D3,(A4)+             
    OR.L  -(A2),D3 
    OR.L  D4,-(A5)               
    
;//////////////////////////////////////////////////////////////////////////////////////
* SUB
    SUB.B  $1000,D1              
    SUB.B  $2000,D2 
    SUB.B  D1,$7FFF              
    SUB.B  D2,$FFFF
    SUB.B  D0,D0
    SUB.B  D0,D1                  
    SUB.B  (A0),D1
    SUB.B  D2,(A3)                 
    SUB.B  (A4)+,D3 
    SUB.B  D4,(A5)+             
    SUB.B  -(A6),D5 
    SUB.B  D6,-(A7)
              
    SUB.W  $1000,D1              
    SUB.W  $2000,D2 
    SUB.W  D1,$7FFF              
    SUB.W  D2,$FFFF
    SUB.W  D0,D0
    SUB.W  D0,D1                  
    SUB.W  (A0),D1
    SUB.W  D2,(A3)                 
    SUB.W  (A4)+,D3 
    SUB.W  D4,(A5)+             
    SUB.W  -(A6),D5 
    SUB.W  D6,-(A7) 
    
    SUB.L  $1000,D1              
    SUB.L  $2000,D2 
    SUB.L  D1,$7FFF              
    SUB.L  D2,$FFFF
    SUB.L  D0,D0
    SUB.L  D0,D1                  
    SUB.L  (A0),D1
    SUB.L  D2,(A3)                 
    SUB.L  (A4)+,D3 
    SUB.L  D4,(A5)+             
    SUB.L  -(A6),D5 
    SUB.L  D6,-(A7)    
    
;//////////////////////////////////////////////////////////////////////////////////////
* Bit Manipulation
    ASL     $1000
    ASL     $7FFF    
    ASL     (A0)
    ASL     (A1)+
    ASL     -(A2)
    
    ASL.B   #$7,D0
    ASL.W   #$8,D1
    ASL.L   D2,D3
    
    ASR     $1000
    ASR     $7FFF    
    ASR     (A0)
    ASR     (A1)+
    ASR     -(A2)
    
    ASR.B   #$7,D0
    ASR.W   #$8,D1
    ASR.L   D2,D3

    LSL     $1000
    LSL     $7FFF    
    LSL     (A0)
    LSL     (A1)+
    LSL     -(A2)
    
    LSL.B   #$7,D0
    LSL.W   #$8,D1
    LSL.L   D2,D3
    
    LSR     $1000
    LSR     $7FFF    
    LSR     (A0)
    LSR     (A1)+
    LSR     -(A2)
    
    LSR.B   #$7,D0
    LSR.W   #$8,D1
    LSR.L   D2,D3 
    
    ROL     $1000
    ROL     $7FFF    
    ROL     (A0)
    ROL     (A1)+
    ROL     -(A2)
    
    ROL.B   #$7,D0
    ROL.W   #$8,D1
    ROL.L   D2,D3
    
    ROR     $1000
    ROR     $7FFF    
    ROR     (A0)
    ROR     (A1)+
    ROR     -(A2)
    
    ROR.B   #$7,D0
    ROR.W   #$8,D1
    ROR.L   D2,D3
    
*NOP
    NOP
    NOP

;//////////////////////////////////////////////////////////////////////////////////////
* Bcc and JSR     
    BCC     TEST123
    BLE     TEST123
    BGT     TEST123

    JSR     TEST123
    JSR     $7FFF
    JSR     $FFFF
    
TEST123
    RTS



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
