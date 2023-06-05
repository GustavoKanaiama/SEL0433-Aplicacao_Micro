
int num_bcd = 0; //numero apresentado pelo 7segmentos iniciado em 0
int last_button = 0; //   0 -> nenuhm botao foi pressionado (ao reiniciar)
                     //   1 -> botao 1s
                     //   2 -> botao 250ms

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


 TRISB.RB0 = 1;      //pino RB0 como entrada (botao)
 TRISB.RB1 = 1;      //pino RB1 como entrada (botao)
 TRISB.RB2 = 1;

 TRISD.RD0 = 0;      //pino RD0 como saida
 TRISD.RD1 = 0;
 TRISD.RD2 = 0;
 TRISD.RD3 = 0;


 PORTD.RD0 = 0;      //LEDs inicialmente apagados
 PORTD.RD1 = 0;
 PORTD.RD2 = 0;
 PORTD.RD3 = 0;

 RCON.IPEN = 1; //DOIS NIVEIS DE PRIORIDADE HABILITADOS
 INTCON.GIEL = 1;// interrupt prioridade baixa habilitada
 INTCON.GIEH = 1;// interrupt prioridade alta habilitada


 INTCON2.TMR0IP = 0; // prioridade baixa para o timer
 
 INTCON3.INT1IF = 0; //Clear flags
 INTCON3.INT2IF = 0;

 INTCON3.INT1IE = 1; //Habilita a interrup��o INT1/RB1
 INTCON3.INT2IE = 1; //Habilita a interrup��o INT2/RB2


 INTCON2.INTEDG1 = 1; //borda de subida no RB1 e RB2
 INTCON2.INTEDG2 = 1;
}

void Config_1s(){
//*******************TIMER0 PARA 1s*********************************

  T0CON = 0B00000100;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:32
  TMR0H = 0X0B;   // carga do valor inicial
  TMR0L = 0XDC;

  INTCON.TMR0IF = 0;  //zera o Flag
  T0CON.TMR0ON = 1;   //Liga o TIMER0

}
//C2F7
void Config_250ms(){
//*******************TIMER0 PARA 250ms*********************************


  T0CON = 0B00000100; //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:32
  TMR0H = 0XC2;   // carga do valor inicial
  TMR0L = 0XF7;

  INTCON.TMR0IF = 0;  //zera o Flag
  T0CON.TMR0ON = 1;   //Liga o TIMER0
}


void Interrupt_botao() iv 0x0018 ics ICS_AUTO { //baixa prioridade
  delay_ms(70);

  // tratamento botao
  if (INTCON3.INT2IF == 1){  //Interrupt 1s acionada
    last_button = 1; //botao 1s pressionado

    INTCON3.INT2IF = 0; //zera flag
    Config_1s();
  }

  if (INTCON3.INT1IF == 1){  //Interrupt 250ms acionada
    last_button = 2; //botao 250ms pressionado

    INTCON3.INT1IF = 0; //zera flag
    Config_250ms(); //aciona Timer
  }
  

}       // Fim do atendimento da interrupcao

void main() {

    ConfigMCU();

    while(1){


      if(INTCON.TMR0IF == 1){
        //tratamento para não exceder o valor de 9 no bcd
        if(num_bcd >= 9){
          num_bcd = 0;
        }
        else{
          num_bcd += 1;
        }
        
        //rastreamento para recarregar o TIMER0
        if( last_button == 1){
          Config_1s();
        }
        else{
          Config_250ms();
        }
      }


      switch (num_bcd) { //0b0000_RD3_RD2_RD1_RD0

      case 0:{  PORTD = 0b1111110; break; }
      case 1:{  PORTD = 0b0110000; break; }
      case 2:{  PORTD = 0b1101101; break; }
      case 3:{  PORTD = 0b1111001; break; }
      case 4:{  PORTD = 0b0110011; break; }
      case 5:{  PORTD = 0b1011011; break; }
      case 6:{  PORTD = 0b1011111; break; }
      case 7:{  PORTD = 0b1110000; break; }
      case 8:{  PORTD = 0b1111111; break; }
      case 9:{  PORTD = 0b1111011; break; }
      }

    };
}