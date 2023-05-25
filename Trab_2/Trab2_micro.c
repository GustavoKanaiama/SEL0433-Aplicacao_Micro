
int num_bcd = 0; //numero apresentado pelo 7segmentos iniciado em 0

void main() {

void ConfigMCU(){

#ifdef P18F45K22
 ANSELD = 0;
 ANSELB = 0;
#else
 ADCON1 |= 0X0F; //P18F4550
#endif

 TRISD = 0;       //Configurar os pinos de controle dos LEDs
 PORTD = 0;

 INTCON.TMR0IF = 0; //Flag TIMER0 zerada
 PIR1.TMR1IF = 0;  //zera a Flag TIMER1


 TRISB.RB0 = 1;      //pino RB0 como entrada (botao)
 TRISB.RB1 = 1;      //pino RB1 como entrada (botao)


 TRISD.RD0 = 0;      //pino RD0 como saida
 TRISD.RD1 = 0;
 TRISD.RD2 = 0;
 TRISD.RD3 = 0;


 PORTD.RD0 = 0;      //LEDs inicialmente apagados
 PORTD.RD1 = 0; 
 PORTD.RD2 = 0; 
 PORTD.RD3 = 0; 

}

void ConfigTIMER0(){
//*******************TIMER0 PARA 1s*********************************

  T0CON = 0B00000100;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:32
  TMR0H = 0X0B;   // carga do valor inicial
  TMR0L = 0XDC;

  INTCON.TMR0IF = 0;  //zera o Flag
  T0CON.TMR0ON = 1;   //Liga o TIMER0

  T1CON.TMR1ON = 0  //Desliga o TIMER1
}

void ConfigTIMER1(){
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

void INTERRUPCAO_botao_1s() iv 0x0018 ics ICS_AUTO { // alta prioridade

// tratamento - acionar LED

  num_bcd = 0; //zerar o numero do 7segmentos

  if(INTCON.INT0IF == 1)
   {
     INTCON.INT0IF = 0;     //  zera flag

     PORTD.RD0 ^= 1;   //Faz a operacao de incremento do 7segmentos
   }
}       // Fim do atendimento � interrup��o


void INTERRUPCAO_botao_250ms() iv 0x0008 ics ICS_AUTO { //baixa prioridade

// tratamento - acionar LED
  num_bcd = 0; //zerar o numero do 7segmentos


  if(INTCON.INT0IF == 1)
   {
     INTCON.INT0IF = 0;     //  zera flag

     PORTD.RD0 ^= 1;   //Faz a operacao de incremento do 7segmentos
   }
}       // Fim do atendimento � interrup��o



    while(1){

      if(PIR1.TMR1IF == 1){
        //Tratamento para interrupt do TIMER1
        if(num_bcd >= 9){
          num_bcd = 0;
        }
        num_bcd += 1;
        ConfigTIMER1(); // Recarrega o TIMER1
      }

      if(INTCON.TMR0IF == 1){
        if(num_bcd >= 9){
          num_bcd = 0;
        }
        num_bcd += 1;
        ConfigTIMER0(); // Recarrega o TIMER0
      }

      switch (num_bcd) { //0b0000_RD3_RD2_RD1_RD0

      case 0:{  PORTD = 0b00000000; break; }
      case 1:{  PORTD = 0b00000001; break; }
      case 2:{  PORTD = 0b00000010; break; }
      case 3:{  PORTD = 0b00000011; break; }
      case 4:{  PORTD = 0b00000100; break; }
      case 5:{  PORTD = 0b00000101; break; }
      case 6:{  PORTD = 0b00000110; break; }
      case 7:{  PORTD = 0b00000111; break; }
      case 8:{  PORTD = 0b00001000; break; }
      case 9:{  PORTD = 0b00001001; break; }
      }

    };
}