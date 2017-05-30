*-----------------------------------------------------------
* Title      : Invalid Op-Codes Test
* Written by : Eric Kinney
* Date       : 5/30/2017
* Description: Invalid op-codes for Disassembler testing
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Invalid op-code instruction starting address

    MOVE.W      #$9000,A6

   
*///////////////////////////////////////////////////////////////////////////
****************************************************************************
           ; Invalid Instructions
****************************************************************************
****************************************************************************
    
    
    
    */////////////////
    ***** MOVEM ******    
    *\\\\\\\\\\\\\\\\\
    
    *Invalid MOVEM.W register to memory
    MOVE.W      #$4880,(A6)+
    MOVE.W      #$4881,(A6)+
    MOVE.W      #$4888,(A6)+
    MOVE.W      #$4889,(A6)+
    MOVE.W      #$4898,(A6)+
    MOVE.W      #$4899,(A6)+
    
    * Invalid MOVEM.L register to memory
    MOVE.W      #$48C0,(A6)+
    MOVE.W      #$48C1,(A6)+
    MOVE.W      #$48C8,(A6)+
    MOVE.W      #$48C9,(A6)+
    MOVE.W      #$48D0,(A6)+
    MOVE.W      #$48D1,(A6)+
    MOVE.W      #$48D8,(A6)+
    MOVE.W      #$48D9,(A6)+
    
    * Invalid MOVEM.W memory to register
    MOVE.W      #$4C80,(A6)+
    MOVE.W      #$4C81,(A6)+
    MOVE.W      #$4C88,(A6)+
    MOVE.W      #$4C89,(A6)+
    MOVE.W      #$4CA0,(A6)+
    MOVE.W      #$4CA1,(A6)+
    MOVE.W      #$4CA8,(A6)+
    MOVE.W      #$4CA9,(A6)+      
    
    * Invalid MOVEM.L memory to register
    MOVE.W      #$4CC0,(A6)+
    MOVE.W      #$4CC1,(A6)+
    MOVE.W      #$4CC8,(A6)+
    MOVE.W      #$4CC9,(A6)+
    MOVE.W      #$4CE0,(A6)+
    MOVE.W      #$4CE1,(A6)+
    MOVE.W      #$4CE8,(A6)+
    MOVE.W      #$4CE9,(A6)+     

*****************************************************

    */////////////////
    *** ADD/A/I/Q ***    
    *\\\\\\\\\\\\\\\\\
    
    * Invalid ADD (ADDX op-code not covered by our project)
    MOVE.W      #$B100,(A6)+
    MOVE.W      #$B30F,(A6)+
    MOVE.W      #$B741,(A6)+
    MOVE.W      #$B988,(A6)+
    MOVE.W      #$BDC9,(A6)+
    MOVE.W      #$BFCF,(A6)+

*****************************************************
    
    */////////////////
    ****** SUB ******    
    *\\\\\\\\\\\\\\\\\
    
    * Invalid SUB op-modes
    MOVE.W      #$91C8,(A6)+
    MOVE.W      #$91CF,(A6)+
    MOVE.W      #$9FF8,(A6)+
    MOVE.W      #$9FFF,(A6)+

    * Invalid SUB effective address
    MOVE.W      #$9F40,(A6)+
    MOVE.W      #$9F00,(A6)+
    MOVE.W      #$9F48,(A6)+
    MOVE.W      #$9F08,(A6)+        
    MOVE.W      #$9148,(A6)+
    MOVE.W      #$9140,(A6)+
    MOVE.W      #$9108,(A6)+
    MOVE.W      #$9100,(A6)+       

*****************************************************

    */////////////////
    ****** MULS ******    
    *\\\\\\\\\\\\\\\\\
    
    * Invalid mode
    MOVE.W      #$C1C8,(A6)+
    MOVE.W      #$C1CF,(A6)+
    
    * Invalid Ea register when mode is 111
    MOVE.W      #$C1FF,(A6)+
    MOVE.W      #$C1FE,(A6)+    
    MOVE.W      #$C1FD,(A6)+  
    
*****************************************************

    */////////////////
    ****** DIVU ******    
    *\\\\\\\\\\\\\\\\\
    
    * Invalid mode
    MOVE.W      #$80C8,(A6)+
    MOVE.W      #$80CF,(A6)+
    
    * Invalid Ea register when mode is 111
    MOVE.W      #$80FF,(A6)+
    MOVE.W      #$80FE,(A6)+    
    MOVE.W      #$80FD,(A6)+  
    
*****************************************************

    */////////////////
    ****** LEA ******    
    *\\\\\\\\\\\\\\\\\

    * Invalid mode
    MOVE.W      #$41C0,(A6)+
    MOVE.W      #$41D8,(A6)+
    MOVE.W      #$41E0,(A6)+
    MOVE.W      #$41F0,(A6)+
    MOVE.W      #$41C8,(A6)+
    MOVE.W      #$41E8,(A6)+

    * Invalid Ea register when mode is 111
    MOVE.W      #$41FA,(A6)+
    MOVE.W      #$41FB,(A6)+
    MOVE.W      #$41FC,(A6)+
    MOVE.W      #$41FD,(A6)+
    MOVE.W      #$41FE,(A6)+
    MOVE.W      #$41FF,(A6)+

*****************************************************

    */////////////////
    ****** CLR ******    
    *\\\\\\\\\\\\\\\\\

* Invalid size
    MOVE.W      #$42C0,(A6)+
    MOVE.W      #$42C8,(A6)+

* Invalid mode
    MOVE.W      #$4208,(A6)+
    MOVE.W      #$420F,(A6)+
    MOVE.W      #$4248,(A6)+
    MOVE.W      #$424F,(A6)+
    MOVE.W      #$4288,(A6)+
    MOVE.W      #$428F,(A6)+

* Invalid register when mode is 111
    MOVE.W      #$4238,(A6)+
    MOVE.W      #$423F,(A6)+
    MOVE.W      #$4278,(A6)+
    MOVE.W      #$427F,(A6)+
    MOVE.W      #$42B8,(A6)+
    MOVE.W      #$42BF,(A6)+

*****************************************************

    */////////////////
    ****** AND ******    
    *\\\\\\\\\\\\\\\\\

* Invalid op-mode
    MOVE.W      #$C1C0,(A6)+
    MOVE.W      #$C1D0,(A6)+
    MOVE.W      #$C1D8,(A6)+
    
* Invalid mode
    MOVE.W      #$C008,(A6)+
    MOVE.W      #$C00F,(A6)+

* Invalid register when mode is 111
    MOVE.W      #$C03A,(A6)+
    MOVE.W      #$C03B,(A6)+
    MOVE.W      #$C03D,(A6)+
    MOVE.W      #$C03E,(A6)+
    MOVE.W      #$C03F,(A6)+

    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
