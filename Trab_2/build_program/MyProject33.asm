
_ConfigMCU:

;MyProject33.c,4 :: 		void ConfigMCU(){
;MyProject33.c,7 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;MyProject33.c,8 :: 		ANSELB = 0;
	CLRF        ANSELB+0 
;MyProject33.c,13 :: 		TRISD = 0;       //Configurar os pinos de controle dos LEDs
	CLRF        TRISD+0 
;MyProject33.c,14 :: 		PORTD = 0;
	CLRF        PORTD+0 
;MyProject33.c,16 :: 		INTCON.TMR0IF = 0; //Flag TIMER0 zerada
	BCF         INTCON+0, 2 
;MyProject33.c,17 :: 		PIR1.TMR1IF = 0;  //zera a Flag TIMER1
	BCF         PIR1+0, 0 
;MyProject33.c,20 :: 		TRISB.RB0 = 1;      //pino RB0 como entrada (botao)
	BSF         TRISB+0, 0 
;MyProject33.c,21 :: 		TRISB.RB1 = 1;      //pino RB1 como entrada (botao)
	BSF         TRISB+0, 1 
;MyProject33.c,24 :: 		TRISD.RD0 = 0;      //pino RD0 como saida
	BCF         TRISD+0, 0 
;MyProject33.c,25 :: 		TRISD.RD1 = 0;
	BCF         TRISD+0, 1 
;MyProject33.c,26 :: 		TRISD.RD2 = 0;
	BCF         TRISD+0, 2 
;MyProject33.c,27 :: 		TRISD.RD3 = 0;
	BCF         TRISD+0, 3 
;MyProject33.c,30 :: 		PORTD.RD0 = 0;      //LEDs inicialmente apagados
	BCF         PORTD+0, 0 
;MyProject33.c,31 :: 		PORTD.RD1 = 0;
	BCF         PORTD+0, 1 
;MyProject33.c,32 :: 		PORTD.RD2 = 0;
	BCF         PORTD+0, 2 
;MyProject33.c,33 :: 		PORTD.RD3 = 0;
	BCF         PORTD+0, 3 
;MyProject33.c,35 :: 		}
L_end_ConfigMCU:
	RETURN      0
; end of _ConfigMCU

_ConfigTIMER0:

;MyProject33.c,37 :: 		void ConfigTIMER0(){
;MyProject33.c,40 :: 		T0CON = 0B00000100;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:32
	MOVLW       4
	MOVWF       T0CON+0 
;MyProject33.c,41 :: 		TMR0H = 0X0B;   // carga do valor inicial
	MOVLW       11
	MOVWF       TMR0H+0 
;MyProject33.c,42 :: 		TMR0L = 0XDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;MyProject33.c,44 :: 		INTCON.TMR0IF = 0;  //zera o Flag
	BCF         INTCON+0, 2 
;MyProject33.c,45 :: 		T0CON.TMR0ON = 1;   //Liga o TIMER0
	BSF         T0CON+0, 7 
;MyProject33.c,47 :: 		T1CON.TMR1ON = 0;  //Desliga o TIMER1
	BCF         T1CON+0, 0 
;MyProject33.c,48 :: 		}
L_end_ConfigTIMER0:
	RETURN      0
; end of _ConfigTIMER0

_ConfigTIMER1:

;MyProject33.c,50 :: 		void ConfigTIMER1(){
;MyProject33.c,55 :: 		T1CON = 0B10110001;
	MOVLW       177
	MOVWF       T1CON+0 
;MyProject33.c,56 :: 		TMR1H = 0X0B;   // carga do valor inicial
	MOVLW       11
	MOVWF       TMR1H+0 
;MyProject33.c,57 :: 		TMR1L = 0XDC;
	MOVLW       220
	MOVWF       TMR1L+0 
;MyProject33.c,59 :: 		PIR1.TMR1IF = 0;  //zera o Flag
	BCF         PIR1+0, 0 
;MyProject33.c,60 :: 		T1CON.TMR1ON = 1;   //Liga o TIMER1
	BSF         T1CON+0, 0 
;MyProject33.c,62 :: 		T0CON.TMR0ON = 0;  //Desliga o TIMER0
	BCF         T0CON+0, 7 
;MyProject33.c,63 :: 		}
L_end_ConfigTIMER1:
	RETURN      0
; end of _ConfigTIMER1

_INTERRUPCAO_botao_1s:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;MyProject33.c,65 :: 		void INTERRUPCAO_botao_1s() iv 0x0018 ics ICS_AUTO { // alta prioridade
;MyProject33.c,69 :: 		num_bcd = 0; //zerar o numero do 7segmentos
	CLRF        _num_bcd+0 
	CLRF        _num_bcd+1 
;MyProject33.c,71 :: 		if(INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_INTERRUPCAO_botao_1s0
;MyProject33.c,73 :: 		INTCON.INT0IF = 0;     //  zera flag
	BCF         INTCON+0, 1 
;MyProject33.c,75 :: 		ConfigTIMER0();
	CALL        _ConfigTIMER0+0, 0
;MyProject33.c,76 :: 		}
L_INTERRUPCAO_botao_1s0:
;MyProject33.c,77 :: 		}       // Fim do atendimento ? interrup??o
L_end_INTERRUPCAO_botao_1s:
L__INTERRUPCAO_botao_1s24:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _INTERRUPCAO_botao_1s

_INTERRUPCAO_botao_250ms:

;MyProject33.c,79 :: 		void INTERRUPCAO_botao_250ms() iv 0x0008 ics ICS_AUTO { //baixa prioridade
;MyProject33.c,82 :: 		num_bcd = 0; //zerar o numero do 7segmentos
	CLRF        _num_bcd+0 
	CLRF        _num_bcd+1 
;MyProject33.c,85 :: 		if(INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_INTERRUPCAO_botao_250ms1
;MyProject33.c,87 :: 		INTCON.INT0IF = 0;     //  zera flag
	BCF         INTCON+0, 1 
;MyProject33.c,89 :: 		ConfigTIMER1();
	CALL        _ConfigTIMER1+0, 0
;MyProject33.c,90 :: 		}
L_INTERRUPCAO_botao_250ms1:
;MyProject33.c,91 :: 		}       // Fim do atendimento ? interrup??o
L_end_INTERRUPCAO_botao_250ms:
L__INTERRUPCAO_botao_250ms26:
	RETFIE      1
; end of _INTERRUPCAO_botao_250ms

_main:

;MyProject33.c,93 :: 		void main() {
;MyProject33.c,95 :: 		ConfigMCU();
	CALL        _ConfigMCU+0, 0
;MyProject33.c,97 :: 		while(1){
L_main2:
;MyProject33.c,99 :: 		if(PIR1.TMR1IF == 1){
	BTFSS       PIR1+0, 0 
	GOTO        L_main4
;MyProject33.c,101 :: 		if(num_bcd >= 9){
	MOVLW       128
	XORWF       _num_bcd+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       9
	SUBWF       _num_bcd+0, 0 
L__main28:
	BTFSS       STATUS+0, 0 
	GOTO        L_main5
;MyProject33.c,102 :: 		num_bcd = 0;
	CLRF        _num_bcd+0 
	CLRF        _num_bcd+1 
;MyProject33.c,103 :: 		}
L_main5:
;MyProject33.c,104 :: 		num_bcd += 1;
	INFSNZ      _num_bcd+0, 1 
	INCF        _num_bcd+1, 1 
;MyProject33.c,105 :: 		ConfigTIMER1(); // Recarrega o TIMER1
	CALL        _ConfigTIMER1+0, 0
;MyProject33.c,106 :: 		}
L_main4:
;MyProject33.c,108 :: 		if(INTCON.TMR0IF == 1){
	BTFSS       INTCON+0, 2 
	GOTO        L_main6
;MyProject33.c,109 :: 		if(num_bcd >= 9){
	MOVLW       128
	XORWF       _num_bcd+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       9
	SUBWF       _num_bcd+0, 0 
L__main29:
	BTFSS       STATUS+0, 0 
	GOTO        L_main7
;MyProject33.c,110 :: 		num_bcd = 0;
	CLRF        _num_bcd+0 
	CLRF        _num_bcd+1 
;MyProject33.c,111 :: 		}
L_main7:
;MyProject33.c,112 :: 		num_bcd += 1;
	INFSNZ      _num_bcd+0, 1 
	INCF        _num_bcd+1, 1 
;MyProject33.c,113 :: 		ConfigTIMER0(); // Recarrega o TIMER0
	CALL        _ConfigTIMER0+0, 0
;MyProject33.c,114 :: 		}
L_main6:
;MyProject33.c,116 :: 		switch (num_bcd) { //0b0000_RD3_RD2_RD1_RD0
	GOTO        L_main8
;MyProject33.c,118 :: 		case 0:{  PORTD = 0b00000000; break; }
L_main10:
	CLRF        PORTD+0 
	GOTO        L_main9
;MyProject33.c,119 :: 		case 1:{  PORTD = 0b00000001; break; }
L_main11:
	MOVLW       1
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,120 :: 		case 2:{  PORTD = 0b00000010; break; }
L_main12:
	MOVLW       2
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,121 :: 		case 3:{  PORTD = 0b00000011; break; }
L_main13:
	MOVLW       3
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,122 :: 		case 4:{  PORTD = 0b00000100; break; }
L_main14:
	MOVLW       4
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,123 :: 		case 5:{  PORTD = 0b00000101; break; }
L_main15:
	MOVLW       5
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,124 :: 		case 6:{  PORTD = 0b00000110; break; }
L_main16:
	MOVLW       6
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,125 :: 		case 7:{  PORTD = 0b00000111; break; }
L_main17:
	MOVLW       7
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,126 :: 		case 8:{  PORTD = 0b00001000; break; }
L_main18:
	MOVLW       8
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,127 :: 		case 9:{  PORTD = 0b00001001; break; }
L_main19:
	MOVLW       9
	MOVWF       PORTD+0 
	GOTO        L_main9
;MyProject33.c,128 :: 		}
L_main8:
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVLW       0
	XORWF       _num_bcd+0, 0 
L__main30:
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVLW       1
	XORWF       _num_bcd+0, 0 
L__main31:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVLW       2
	XORWF       _num_bcd+0, 0 
L__main32:
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       3
	XORWF       _num_bcd+0, 0 
L__main33:
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVLW       4
	XORWF       _num_bcd+0, 0 
L__main34:
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main35
	MOVLW       5
	XORWF       _num_bcd+0, 0 
L__main35:
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVLW       6
	XORWF       _num_bcd+0, 0 
L__main36:
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       7
	XORWF       _num_bcd+0, 0 
L__main37:
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVLW       8
	XORWF       _num_bcd+0, 0 
L__main38:
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
	MOVLW       0
	XORWF       _num_bcd+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVLW       9
	XORWF       _num_bcd+0, 0 
L__main39:
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
L_main9:
;MyProject33.c,130 :: 		};
	GOTO        L_main2
;MyProject33.c,131 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
