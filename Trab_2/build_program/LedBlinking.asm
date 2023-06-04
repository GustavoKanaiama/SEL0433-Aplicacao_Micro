
_ConfigMCU:

;LedBlinking.c,4 :: 		void ConfigMCU(){
;LedBlinking.c,10 :: 		ADCON1 |= 0X0F; //P18F4550
	MOVLW       15
	IORWF       ADCON1+0, 1 
;LedBlinking.c,13 :: 		TRISD = 0;       //Configurar os pinos de controle dos LEDs
	CLRF        TRISD+0 
;LedBlinking.c,14 :: 		PORTD = 0;
	CLRF        PORTD+0 
;LedBlinking.c,16 :: 		INTCON.TMR0IF = 0; //Flag TIMER0 zerada
	BCF         INTCON+0, 2 
;LedBlinking.c,17 :: 		PIR1.TMR1IF = 0;  //zera a Flag TIMER1
	BCF         PIR1+0, 0 
;LedBlinking.c,20 :: 		TRISB.RB0 = 1;      //pino RB0 como entrada (botao)
	BSF         TRISB+0, 0 
;LedBlinking.c,21 :: 		TRISB.RB1 = 1;      //pino RB1 como entrada (botao)
	BSF         TRISB+0, 1 
;LedBlinking.c,22 :: 		TRISB.RB2 = 1;
	BSF         TRISB+0, 2 
;LedBlinking.c,24 :: 		TRISD.RD0 = 0;      //pino RD0 como saida
	BCF         TRISD+0, 0 
;LedBlinking.c,25 :: 		TRISD.RD1 = 0;
	BCF         TRISD+0, 1 
;LedBlinking.c,26 :: 		TRISD.RD2 = 0;
	BCF         TRISD+0, 2 
;LedBlinking.c,27 :: 		TRISD.RD3 = 0;
	BCF         TRISD+0, 3 
;LedBlinking.c,30 :: 		PORTD.RD0 = 0;      //LEDs inicialmente apagados
	BCF         PORTD+0, 0 
;LedBlinking.c,31 :: 		PORTD.RD1 = 0;
	BCF         PORTD+0, 1 
;LedBlinking.c,32 :: 		PORTD.RD2 = 0;
	BCF         PORTD+0, 2 
;LedBlinking.c,33 :: 		PORTD.RD3 = 0;
	BCF         PORTD+0, 3 
;LedBlinking.c,35 :: 		RCON.IPEN = 1; //DOIS NIVEIS DE PRIORIDADE HABILITADOS
	BSF         RCON+0, 7 
;LedBlinking.c,36 :: 		INTCON.GIEL = 1;// interrupt prioridade baixa habilitada
	BSF         INTCON+0, 6 
;LedBlinking.c,37 :: 		INTCON.GIEH = 1;// interrupt prioridade alta habilitada
	BSF         INTCON+0, 7 
;LedBlinking.c,40 :: 		INTCON2.TMR0IP = 0; // prioridade baixa para os timers
	BCF         INTCON2+0, 2 
;LedBlinking.c,41 :: 		IPR1.TMR1IP = 0;
	BCF         IPR1+0, 0 
;LedBlinking.c,43 :: 		INTCON3.INT1IF = 0; //Clear flags
	BCF         INTCON3+0, 0 
;LedBlinking.c,44 :: 		INTCON3.INT2IF = 0;
	BCF         INTCON3+0, 1 
;LedBlinking.c,46 :: 		INTCON3.INT1IE = 1; //Habilita a interrup??o INT1/RB1
	BSF         INTCON3+0, 3 
;LedBlinking.c,47 :: 		INTCON3.INT2IE = 1; //Habilita a interrup??o INT2/RB2
	BSF         INTCON3+0, 4 
;LedBlinking.c,50 :: 		INTCON2.INTEDG1 = 1; //borda de subida no RB1 e RB2
	BSF         INTCON2+0, 5 
;LedBlinking.c,51 :: 		INTCON2.INTEDG2 = 1;
	BSF         INTCON2+0, 4 
;LedBlinking.c,52 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTIMER0:

;LedBlinking.c,54 :: 		void ConfigTIMER0(){
;LedBlinking.c,57 :: 		T0CON = 0B00000100;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:32
	MOVLW       4
	MOVWF       T0CON+0 
;LedBlinking.c,58 :: 		TMR0H = 0X0B;   // carga do valor inicial
	MOVLW       11
	MOVWF       TMR0H+0 
;LedBlinking.c,59 :: 		TMR0L = 0XDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;LedBlinking.c,61 :: 		INTCON.TMR0IF = 0;  //zera o Flag
	BCF         INTCON+0, 2 
;LedBlinking.c,62 :: 		T0CON.TMR0ON = 1;   //Liga o TIMER0
	BSF         T0CON+0, 7 
;LedBlinking.c,64 :: 		T1CON.TMR1ON = 0;  //Desliga o TIMER1
	BCF         T1CON+0, 0 
;LedBlinking.c,65 :: 		}
L_end_ConfigTIMER0:
	RETURN      0
; end of _ConfigTIMER0

_ConfigTIMER1:

;LedBlinking.c,67 :: 		void ConfigTIMER1(){
;LedBlinking.c,72 :: 		T1CON = 0B10110001;
	MOVLW       177
	MOVWF       T1CON+0 
;LedBlinking.c,73 :: 		TMR1H = 0X0B;   // carga do valor inicial
	MOVLW       11
	MOVWF       TMR1H+0 
;LedBlinking.c,74 :: 		TMR1L = 0XDC;
	MOVLW       220
	MOVWF       TMR1L+0 
;LedBlinking.c,76 :: 		PIR1.TMR1IF = 0;  //zera o Flag
	BCF         PIR1+0, 0 
;LedBlinking.c,77 :: 		T1CON.TMR1ON = 1;   //Liga o TIMER1
	BSF         T1CON+0, 0 
;LedBlinking.c,79 :: 		T0CON.TMR0ON = 0;  //Desliga o TIMER0
	BCF         T0CON+0, 7 
;LedBlinking.c,80 :: 		}
L_end_ConfigTIMER1:
	RETURN      0
; end of _ConfigTIMER1

_Interrupt_botao:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;LedBlinking.c,83 :: 		void Interrupt_botao() iv 0x0018 ics ICS_AUTO { //alta prioridade
;LedBlinking.c,85 :: 		num_bcd = 0; //zerar o numero do 7segmentos
	CLRF        _num_bcd+0 
	CLRF        _num_bcd+1 
;LedBlinking.c,88 :: 		if (INTCON3.INT2IF == 1){  //Interrupt 1s acionada
	BTFSS       INTCON3+0, 1 
	GOTO        L_Interrupt_botao0
;LedBlinking.c,90 :: 		INTCON3.INT2IF = 0; //zera flag
	BCF         INTCON3+0, 1 
;LedBlinking.c,91 :: 		ConfigTIMER0();
	CALL        _ConfigTIMER0+0, 0
;LedBlinking.c,92 :: 		}
L_Interrupt_botao0:
;LedBlinking.c,94 :: 		if (INTCON3.INT1IF == 1){  //Interrupt 250ms acionada
	BTFSS       INTCON3+0, 0 
	GOTO        L_Interrupt_botao1
;LedBlinking.c,96 :: 		INTCON3.INT1IF = 0; //zera flag
	BCF         INTCON3+0, 0 
;LedBlinking.c,97 :: 		ConfigTIMER1(); //aciona Timer
	CALL        _ConfigTIMER1+0, 0
;LedBlinking.c,98 :: 		}
L_Interrupt_botao1:
;LedBlinking.c,101 :: 		}       // Fim do atendimento da interrupcao
L_end_Interrupt_botao:
L__Interrupt_botao24:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _Interrupt_botao

_main:

;LedBlinking.c,103 :: 		void main() {
;LedBlinking.c,105 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;LedBlinking.c,107 :: 		while(1){
L_main2:
;LedBlinking.c,109 :: 		if(PIR1.TMR1IF == 1){
	BTFSS       PIR1+0, 0 
	GOTO        L_main4
;LedBlinking.c,111 :: 		if(num_bcd >= 9){
	MOVLW       128
	XORWF       _num_bcd+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main26
	MOVLW       9
	SUBWF       _num_bcd+0, 0 
L__main26:
	BTFSS       STATUS+0, 0 
	GOTO        L_main5
;LedBlinking.c,112 :: 		num_bcd = 0;
	CLRF        _num_bcd+0 
	CLRF        _num_bcd+1 
;LedBlinking.c,113 :: 		}
L_main5:
;LedBlinking.c,114 :: 		num_bcd += 1;
	INFSNZ      _num_bcd+0, 1 
	INCF        _num_bcd+1, 1 
;LedBlinking.c,115 :: 		ConfigTIMER1(); // Recarrega o TIMER1
	CALL        _ConfigTIMER1+0, 0
;LedBlinking.c,116 :: 		}
L_main4:
;LedBlinking.c,118 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_main6
;LedBlinking.c,119 :: 		if(num_bcd >= 9){
	MOVLW       128
	XORWF       _num_bcd+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main27
	MOVLW       9
	SUBWF       _num_bcd+0, 0 
L__main27:
	BTFSS       STATUS+0, 0 
	GOTO        L_main7
;LedBlinking.c,120 :: 		num_bcd = 0;
	CLRF        _num_bcd+0 
	CLRF        _num_bcd+1 
;LedBlinking.c,121 :: 		}
L_main7:
;LedBlinking.c,122 :: 		num_bcd += 1;
	INFSNZ      _num_bcd+0, 1 
	INCF        _num_bcd+1, 1 
;LedBlinking.c,123 :: 		ConfigTIMER0(); // Recarrega o TIMER0
	CALL        _ConfigTIMER0+0, 0
;LedBlinking.c,124 :: 		}
L_main6:
;LedBlinking.c,126 :: 		switch (num_bcd) { //0b0000_RD3_RD2_RD1_RD0
	GOTO        L_main8
;LedBlinking.c,128 :: 		case 0:{  PORTD = 0b1111110; break; }
L_main10:
	MOVLW       126
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,129 :: 		case 1:{  PORTD = 0b0110000; break; }
L_main11:
	MOVLW       48
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,130 :: 		case 2:{  PORTD = 0b1101101; break; }
L_main12:
	MOVLW       109
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,131 :: 		case 3:{  PORTD = 0b1111001; break; }
L_main13:
	MOVLW       121
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,132 :: 		case 4:{  PORTD = 0b0110011; break; }
L_main14:
	MOVLW       51
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,133 :: 		case 5:{  PORTD = 0b1011011; break; }
L_main15:
	MOVLW       91
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,134 :: 		case 6:{  PORTD = 0b1011111; break; }
L_main16:
	MOVLW       95
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,135 :: 		case 7:{  PORTD = 0b1110000; break; }
L_main17:
	MOVLW       112
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,136 :: 		case 8:{  PORTD = 0b1111111; break; }
L_main18:
	MOVLW       127
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,137 :: 		case 9:{  PORTD = 0b1111011; break; }
L_main19:
	MOVLW       123
	MOVWF       PORTD+0 
	GOTO        L_main9
;LedBlinking.c,138 :: 		}
L_main8:
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       0
	XORWF       _num_bcd+0, 0 
L__main28:
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       1
	XORWF       _num_bcd+0, 0 
L__main29:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVLW       2
	XORWF       _num_bcd+0, 0 
L__main30:
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVLW       3
	XORWF       _num_bcd+0, 0 
L__main31:
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVLW       4
	XORWF       _num_bcd+0, 0 
L__main32:
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       5
	XORWF       _num_bcd+0, 0 
L__main33:
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVLW       6
	XORWF       _num_bcd+0, 0 
L__main34:
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main35
	MOVLW       7
	XORWF       _num_bcd+0, 0 
L__main35:
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVLW       8
	XORWF       _num_bcd+0, 0 
L__main36:
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       9
	XORWF       _num_bcd+0, 0 
L__main37:
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
L_main9:
;LedBlinking.c,140 :: 		};
	GOTO        L_main2
;LedBlinking.c,141 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
