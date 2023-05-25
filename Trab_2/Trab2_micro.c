


void main() {

void ConfigMCU()
{
#ifdef P18F45K22
 ANSELD = 0;
 ANSELB = 0;
#else
 ADCON1 |= 0X0F;
#endif

 TRISD = 0;       //Configurar os pinos de controle dos LEDs
 PORTD = 0;

 INTCON.TMR0IF = 0; //Flag TIMER0 zerada
 PIR1.TMR1IF = 0;  //zera a Flag TIMER1


 TRISB.RB0 = 1;      //pino RB0 como entrada (botao)
 TRISB.RB1 = 1;      //pino RB1 como entrada (botao)


 TRISD.RD0 = 0;      //pino RD0 como saida (LED)
 PORTD.RD0 = 0;      //LED inicialmente apagado

}

void ConfigTIMER0()
{
//*******************TIMER0 PARA 1ms*********************************

  T0CON = 0B00000100;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:32
  TMR0H = 0X0B;   // carga do valor inicial
  TMR0L = 0XDC;

  INTCON.TMR0IF = 0;  //zera o Flag
  T0CON.TMR0ON = 1;   //Liga o TIMER0

  T1CON.TMR1ON = 0  //Desliga o TIMER1
}

void ConfigTIMER1()
{
//*******************TIMER1 PARA 250ms*********************************
// ja que o max do TIMER1 é aprx 262ms
//pre scaler de 8

  T1CON = 0B10110001; 
  TMR1H = 0X0B;   // carga do valor inicial
  TMR1L = 0XDC;

  PIR1.TMR1IF = 0;  //zera o Flag
  T1CON.TMR1ON = 1;   //Liga o TIMER1

  T0CON.TMR0ON = 0  //Desliga o TIMER0
}

    while(1){

    }
}