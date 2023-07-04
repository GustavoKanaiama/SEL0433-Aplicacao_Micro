  // Em library Manager - habilitar as bibliotecas ADC, LCD, e Conversions

//Uso do conversor ADC para realizar uma leitura anal?gica (sinal de tens?o)
  // com n?mero float e 2 casas decimais, usando o TRIMPOT "ADC Input" do kit EasyPIC v7

  // ser? o usado o canal anal?gico AN0/RA0 - para ler o sinal de tens?o anal?gico
  //o qual ir? varir conforme o ajuste do TRIMPOT (simulando uma varia??o anal?gica
  // um sensor, por exemplo)

  // Device: PIC18F45K22 (ou  PIC18F4550) - Clock  = 8 MHz
  // Tens?o de ref. interna do ADC 0 - 3.3 V ou 0 - 5V
  // Necess?rio add bibliotecas LCD e convers?o de dados em "Libray Manager"

  // Configura??es necess?rias: Jumper no "trimpot ADC input" AN0 (PORT A) - 1? trimpot
  // habilitar o display LCD em SW4 - se necess?rio ajsutar o contraste no trimpot
  // correspondente


// Config. de pinos do LCD  (PORTB)

/*Include*/

/*Diretivas de pr?-compila??o*/
 #define TRUE  1  // assim: while(TRUE) = while(1)

// config. dos pinos para o LCD

// pinos utilizados para comunica??o com o display LCD
sbit LCD_RS at LATB4_bit; // pino 4 do PORTB interligado ao RS do display
sbit LCD_EN at LATB5_bit; // pino 5 do PORTB " " ao EN do display
sbit LCD_D4 at LATB0_bit; // pino 0 do PORTB ao D4
sbit LCD_D5 at LATB1_bit;  // " "
sbit LCD_D6 at LATB2_bit;  // " "
sbit LCD_D7 at LATB3_bit;  // " "
// dire??o do fluxo de dados nos pinos selecionados
sbit LCD_RS_Direction at TRISB4_bit;  // dire??o do fluxo de dados do pino RB4
sbit LCD_EN_Direction at TRISB5_bit;  // " "
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;




/*Programa Principal*/

void main(){
  unsigned int V_ADC = 0;  // var. para leitura da Tensao
  unsigned int T_ADC = 0;  // var. para leitura da Temperatura
  int V_max = 500; // 5.00 V
  int T_max = 999; // 99.9 �C
  unsigned char Tensao[10];    // arranjo textual para exibir no display
  unsigned char Temp[10];  //vetor do valor da temperatura

#ifdef P18F45K22 // Lembrando que ANSEL = 1; pois agora o pino deve ser analogico!!!

  TRISA.RA0 = 1; // AN0/RA0 como entrada (canal escolhido para leitura anal?gica)
  TRISA.RA1 = 1; // AN1/RA1 como entrada (canal escolhido para leitura anal?gica)
  ANSELA = 0B00000111;// (somente AN0/RA0 E AN1 como anal?gico)
  ANSELB = 0;  // Configura PORTB como digital (n?o vai usar o m?dulo anal?gico)
  ADC_Init_Advanced(_ADC_INTERNAL_VREFL_ | _ADC_INTERNAL_FVRH1); // Mudar a Referencia para Vref+ 1V

#else     // caso usar outro modelo de PIC18F (PIC18F4550)
  TRISA.RA0 = 1;
  TRISA.RA1 = 1;
  TRISA.RA2 = 1;
  TRISA.RA3 = 1;
  ADCON1 = 0B00011011; //Configura RA0/AN0 e AN1 como ADC no PIC18F4450
  ADC_Init();
#endif

 // Configura??o do m?dulo LCD
  Lcd_Init();                 // Inicializa a lib. Lcd
  Lcd_Cmd(_LCD_CLEAR);       // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);  // Cursor off
  Lcd_Out(1, 6, " V         ");
  Lcd_Out(2, 6, " C         ");

 while(TRUE)
  {
    V_ADC = ADC_Read(0); // fun??o da biblioteca ADC do compilador para

    V_ADC = V_ADC * (V_max/1023.); // formata o valor de entrada (neste caso o valor de exemplo '1234')

    // ------------Formatando para Tensao ------------------

    // Formatando cada valor a ser exibido no display como "12.34"

    Tensao[0] = (V_ADC/100)%10 + '0'; // div. de n? inteiros => 1234/100 = 12
    // '%' em ling. C ? opera??o "mod"  c/ resto da divis?o, ou seja, 12%10 = 2
    // portanto, formata o segundo n? no display no padr?o ASCI ( '2' + '0' = 2)

    Tensao[1] = '.';    //3? valor corresponde ao ponto - ex. 12.34

    Tensao[2] = (V_ADC/10)%10 + '0'; // 4? valor ? a 1?casa decimal, portanto:
    // 1234/10 = 123%10 = 3  - formata no padr?o ASCI
    Tensao[3] = (V_ADC/1)%10 + '0';  // formata o valor da 2? casa decimal

    Tensao[4] = 0; //terminador NULL (ultima posi??o da matriz - zero indica o
    //final opea??o e limita a exibi??o dos 5 valores anteriores: 12.34), ou seja
    // a partir daqui, n?o ser?o mais exibidos valores, os quais poder?o ser
    //adicionados caso se deseja exibir, por ex., mais casas decimais


    Lcd_Out(1, 1, Tensao); // Mostra os valores no display


    T_ADC = ADC_Read(1); //leitura dos valores de 0 a 1023 (10 bits)  - ex.:  valor_ADC = 1023;


    // Ajustes de escala dos valores de convers?o para colocar no formato float
    // de 2 casas ap?s a virgula. Tomando como exemplo valores de 0 a 12.34 para
    // a escala de 0 a 1023 do conversor:


    T_ADC = T_ADC * 5 * (T_max/1023.); // para 0 a 1023 -> com ponto no final para n? float,i.e.,o display mostrar?: '12.34'



    //floatToStr(Valor_ADC , Tensao);
    //Tensao[5] = 0;

    // ------------Formatando para Temperatura ------------------

    Temp[0] = (T_ADC/100)%10 + '0';
    Temp[1] = (T_ADC/10)%10 + '0';
    Temp[2] = '.';
    Temp[3] = (T_ADC/1)%10 + '0';
    Temp[4] = 0;


     // Exibir os valores na config. acima no display LCD:
    
    Lcd_Out(2, 1, Temp);
    Delay_ms(20);   // atualizar display
  }
}