#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/Development Systems/EasyPIC PRO v8/Projeto_LabMicro/MyProject3.c"
#line 29 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/Development Systems/EasyPIC PRO v8/Projeto_LabMicro/MyProject3.c"
sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;






void main(){
 unsigned int V_ADC = 0;
 unsigned int T_ADC = 0;
 int V_max = 500;
 int T_max = 999;
 unsigned char Tensao[10];
 unsigned char Temp[10];










 TRISA.RA0 = 1;
 TRISA.RA1 = 1;
 TRISA.RA2 = 1;
 TRISA.RA3 = 1;
 ADCON1 = 0B00011011;
 ADC_Init();



 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 6, " V         ");
 Lcd_Out(2, 6, " C         ");

 while( 1 )
 {
 V_ADC = ADC_Read(0);

 V_ADC = V_ADC * (V_max/1023.);





 Tensao[0] = (V_ADC/100)%10 + '0';



 Tensao[1] = '.';

 Tensao[2] = (V_ADC/10)%10 + '0';

 Tensao[3] = (V_ADC/1)%10 + '0';

 Tensao[4] = 0;





 Lcd_Out(1, 1, Tensao);


 T_ADC = ADC_Read(1);







 T_ADC = T_ADC * 5 * (T_max/1023.);








 Temp[0] = (T_ADC/100)%10 + '0';
 Temp[1] = (T_ADC/10)%10 + '0';
 Temp[2] = '.';
 Temp[3] = (T_ADC/1)%10 + '0';
 Temp[4] = 0;




 Lcd_Out(2, 1, Temp);
 Delay_ms(20);
 }
}
