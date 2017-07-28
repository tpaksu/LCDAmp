#include <16F628.h>
#fuses intrc_io,nomclr,NOPROTECT,NOWDT,NOBROWNOUT,NOLVP /*fuses, turn pretty much everything off!*/
#use delay(clock=4000000)
#use rs232(baud=9600,parity=N,xmit=pin_B2,rcv=PIN_B1,bits=8,stream=seri)

#byte PIR1 =  0x0C
#bit TXIF = PIR1.4

void main()
{
unsigned char aray[80] = {0x00,0xA1,'A','l','a','n','i','s',' ','M','o','r','i','s','e','t','t','e',' ',' ',' ',' ',0xA2,'I','r','o','n','i','c',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',0xA3,0xA4,'M','e','m',':','5','4','%',' ',' ',' ',' ',' ',' ','C','P','U',':','2','5','%',0xA5};
int i,saniye,dakika,basili;
saniye=0;
dakika=0;

while(1){




		if (TXIF)
		{
				putc(aray[i]);

				if(aray[i]==0xA3){
				printf("%02u:",dakika);
				printf("%02u",saniye);
				printf("/03:51     192k");
				}



				TXIF=0;
				i=i+1;
				if (aray[i]==0xA5)
				{	delay_ms(950);
				saniye=saniye+1;
				if(saniye==60){
				saniye=0;
				dakika=dakika+1;
				}
				if(dakika==3&saniye==51){
				dakika=0;
				saniye=0;

				}

					i=0;
				}
		}


		}

}
