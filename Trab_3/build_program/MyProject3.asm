
_main:

;MyProject3.c,48 :: 		void main(){
;MyProject3.c,49 :: 		unsigned int V_ADC = 0;  // var. para leitura da Tensao
	CLRF        main_V_ADC_L0+0 
	CLRF        main_V_ADC_L0+1 
	MOVLW       244
	MOVWF       main_V_max_L0+0 
	MOVLW       1
	MOVWF       main_V_max_L0+1 
	MOVLW       231
	MOVWF       main_T_max_L0+0 
	MOVLW       3
	MOVWF       main_T_max_L0+1 
;MyProject3.c,65 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;MyProject3.c,66 :: 		TRISA.RA3 = 1;
	BSF         TRISA+0, 3 
;MyProject3.c,67 :: 		ADCON1 = 0B00001011; //Configura RA0/AN0 e AN1 como ADC no PIC18F4450
	MOVLW       11
	MOVWF       ADCON1+0 
;MyProject3.c,68 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;MyProject3.c,72 :: 		Lcd_Init();                 // Inicializa a lib. Lcd
	CALL        _Lcd_Init+0, 0
;MyProject3.c,73 :: 		Lcd_Cmd(_LCD_CLEAR);       // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject3.c,74 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject3.c,75 :: 		Lcd_Out(1, 6, " V         ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_MyProject3+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_MyProject3+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject3.c,76 :: 		Lcd_Out(2, 6, " C         ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_MyProject3+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_MyProject3+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject3.c,78 :: 		while(TRUE)
L_main0:
;MyProject3.c,81 :: 		V_ADC = ADC_Read(2); // fun??o da biblioteca ADC do compilador para
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_V_ADC_L0+0 
	MOVF        R1, 0 
	MOVWF       main_V_ADC_L0+1 
;MyProject3.c,82 :: 		T_ADC = ADC_Read(3); //leitura dos valores de 0 a 1023 (10 bits)  - ex.:  valor_ADC = 1023;
	MOVLW       3
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+6 
	MOVF        R1, 0 
	MOVWF       FLOC__main+7 
	MOVF        main_V_max_L0+0, 0 
	MOVWF       R0 
	MOVF        main_V_max_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
;MyProject3.c,91 :: 		V_ADC = V_ADC * (V_max/1023.); // formata o valor de entrada (neste caso o valor de exemplo '1234')
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        main_V_ADC_L0+0, 0 
	MOVWF       R0 
	MOVF        main_V_ADC_L0+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        FLOC__main+0, 0 
	MOVWF       R4 
	MOVF        FLOC__main+1, 0 
	MOVWF       R5 
	MOVF        FLOC__main+2, 0 
	MOVWF       R6 
	MOVF        FLOC__main+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+4 
	MOVF        R1, 0 
	MOVWF       FLOC__main+5 
	MOVF        FLOC__main+4, 0 
	MOVWF       main_V_ADC_L0+0 
	MOVF        FLOC__main+5, 0 
	MOVWF       main_V_ADC_L0+1 
;MyProject3.c,92 :: 		T_ADC = T_ADC * (T_max/1023.); // para 0 a 1023 -> com ponto no final para n? float,i.e.,o display mostrar?: '12.34'
	MOVF        main_T_max_L0+0, 0 
	MOVWF       R0 
	MOVF        main_T_max_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        FLOC__main+6, 0 
	MOVWF       R0 
	MOVF        FLOC__main+7, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        FLOC__main+0, 0 
	MOVWF       R4 
	MOVF        FLOC__main+1, 0 
	MOVWF       R5 
	MOVF        FLOC__main+2, 0 
	MOVWF       R6 
	MOVF        FLOC__main+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+4, 0 
	MOVWF       R0 
	MOVF        FLOC__main+5, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
;MyProject3.c,98 :: 		Tensao[0] = (V_ADC/100)%10 + '0'; // div. de n? inteiros => 1234/100 = 12
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       main_Tensao_L0+0 
;MyProject3.c,102 :: 		Tensao[1] = '.';    //3? valor corresponde ao ponto - ex. 12.34
	MOVLW       46
	MOVWF       main_Tensao_L0+1 
;MyProject3.c,104 :: 		Tensao[2] = (V_ADC/10)%10 + '0'; // 4? valor ? a 1?casa decimal, portanto:
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+4, 0 
	MOVWF       R0 
	MOVF        FLOC__main+5, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       main_Tensao_L0+2 
;MyProject3.c,106 :: 		Tensao[3] = (V_ADC/1)%10 + '0';  // formata o valor da 2? casa decimal
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+4, 0 
	MOVWF       R0 
	MOVF        FLOC__main+5, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       main_Tensao_L0+3 
;MyProject3.c,108 :: 		Tensao[4] = 0; //terminador NULL (ultima posi??o da matriz - zero indica o
	CLRF        main_Tensao_L0+4 
;MyProject3.c,118 :: 		Temp[0] = (T_ADC/100)%10 + '0';
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       main_Temp_L0+0 
;MyProject3.c,119 :: 		Temp[1] = (T_ADC/10)%10 + '0';
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       main_Temp_L0+1 
;MyProject3.c,120 :: 		Temp[2] = '.';
	MOVLW       46
	MOVWF       main_Temp_L0+2 
;MyProject3.c,121 :: 		Temp[3] = (T_ADC/1)%10 + '0';
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       main_Temp_L0+3 
;MyProject3.c,122 :: 		Temp[4] = 0;
	CLRF        main_Temp_L0+4 
;MyProject3.c,126 :: 		Lcd_Out(1, 1, Tensao); // Mostra os valores no display
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_Tensao_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_Tensao_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject3.c,127 :: 		Lcd_Out(2, 1, Temp);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_Temp_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_Temp_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject3.c,128 :: 		Delay_ms(20);   // atualizar display
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
	NOP
;MyProject3.c,129 :: 		}
	GOTO        L_main0
;MyProject3.c,130 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
