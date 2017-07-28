#include "deneme.h"
#include "flexLCD.C"

#byte RCSTA = 0x18
#byte TXSTA = 0x98
#byte PIR1 =  0x0C
#byte PIE1 =  0x8C
#byte INTCON = 0x0B
#byte SPBRG = 0x99

#bit TXIF = PIR1.4
#bit RCIF = PIR1.5
#bit RCIE = PIE1.5
#bit TXIE = PIE1.4

void main()
{
	unsigned char input,harf;


   setup_timer_0(RTCC_INTERNAL|RTCC_DIV_1);
   setup_timer_1(T1_DISABLED);
   setup_timer_2(T2_DISABLED,0,1);
   setup_comparator(NC_NC_NC_NC);
   setup_vref(FALSE);




	lcd_init();

	delay_ms(10);
 	lcd_putc("\f");
   lcd_putc("\f");
	lcd_putc("\f");
	lcd_putc("Taha Paksu           ");
	lcd_gotoxy(1,2);
	lcd_putc("1030225290           ");
	lcd_gotoxy(1,3);
	lcd_putc("Erciyes Universitesi ");
	lcd_gotoxy(1,4);
	lcd_putc("Elektronik Muh.      ");

	delay_ms(1000);

	while(kbhit()){
	input=getch();
	if(input==0xA5){
	break;
	}
	}




		while(1){
		//Vol- D��mesi
		if(input(pin_A2)){
		for(;;){
		if(!input(pin_A2)){
		puts("Vol-");
		break;
		}
		}
		}
		//Prev D��mesi
		if(input(pin_A3)){
		for(;;){
		if(!input(pin_A3)){
		puts("Prev");
		break;
		}
		}
		}
		//Play-Pause D��mesi
		if(input(pin_A4)){
		for(;;){
		if(!input(pin_A4)){
		puts("Play");
		break;
		}
		}
		}
		//Stop D��mesi
		if(input(pin_A5)){
		for(;;){
		if(!input(pin_A5)){
		puts("Stop");
		break;
		}
		}
		}
		//Next D��mesi
		if(input(pin_B0)){
		for(;;){
		if(!input(pin_B0)){
		puts("Next");
		break;
		}
		}
		}
		//Vol+ D��mesi
		if(input(pin_B3)){
		for(;;){
		if(!input(pin_B3)){
		puts("Vol+");
		break;
		}
		}
		}
		if(kbhit()){
			input = getch();
			switch (input)
			{
			case 0xA1:
						//lcd_send_byte(0,0x01);
						lcd_gotoxy(1,1);
						break;
			case 0xA2:
						lcd_gotoxy(1,2);
						break;
			case 0xA3:
						lcd_gotoxy(1,3);
						break;
			case 0xA4:
						lcd_gotoxy(1,4);
						break;
			default:
						lcd_putc(input);
						//printf(lcd_putc,"%X",input);
						break;
			}
		}

		}

}

