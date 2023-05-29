#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/MyProject33.c"

int num_bcd = 0;

void ConfigMCU(){


 ANSELD = 0;
 ANSELB = 0;
#line 13 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/MyProject33.c"
 TRISD = 0;
 PORTD = 0;

 INTCON.TMR0IF = 0;
 PIR1.TMR1IF = 0;


 TRISB.RB0 = 1;
 TRISB.RB1 = 1;


 TRISD.RD0 = 0;
 TRISD.RD1 = 0;
 TRISD.RD2 = 0;
 TRISD.RD3 = 0;


 PORTD.RD0 = 0;
 PORTD.RD1 = 0;
 PORTD.RD2 = 0;
 PORTD.RD3 = 0;

}

void ConfigTIMER0(){


 T0CON = 0B00000100;
 TMR0H = 0X0B;
 TMR0L = 0XDC;

 INTCON.TMR0IF = 0;
 T0CON.TMR0ON = 1;

 T1CON.TMR1ON = 0;
}

void ConfigTIMER1(){




 T1CON = 0B10110001;
 TMR1H = 0X0B;
 TMR1L = 0XDC;

 PIR1.TMR1IF = 0;
 T1CON.TMR1ON = 1;

 T0CON.TMR0ON = 0;
}

void INTERRUPCAO_botao_1s() iv 0x0018 ics ICS_AUTO {



 num_bcd = 0;

 if(INTCON.INT0IF == 1)
 {
 INTCON.INT0IF = 0;

 ConfigTIMER0();
 }
}

void INTERRUPCAO_botao_250ms() iv 0x0008 ics ICS_AUTO {


 num_bcd = 0;


 if(INTCON.INT0IF == 1)
 {
 INTCON.INT0IF = 0;

 ConfigTIMER1();
 }
}

void main() {

 ConfigMCU();

 while(1){

 if(PIR1.TMR1IF == 1){

 if(num_bcd >= 9){
 num_bcd = 0;
 }
 num_bcd += 1;
 ConfigTIMER1();
 }

 if(INTCON.TMR0IF == 1){
 if(num_bcd >= 9){
 num_bcd = 0;
 }
 num_bcd += 1;
 ConfigTIMER0();
 }

 switch (num_bcd) {

 case 0:{ PORTD = 0b00000000; break; }
 case 1:{ PORTD = 0b00000001; break; }
 case 2:{ PORTD = 0b00000010; break; }
 case 3:{ PORTD = 0b00000011; break; }
 case 4:{ PORTD = 0b00000100; break; }
 case 5:{ PORTD = 0b00000101; break; }
 case 6:{ PORTD = 0b00000110; break; }
 case 7:{ PORTD = 0b00000111; break; }
 case 8:{ PORTD = 0b00001000; break; }
 case 9:{ PORTD = 0b00001001; break; }
 }

 };
}
