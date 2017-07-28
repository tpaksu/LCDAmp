#include <16F628.h>

#FUSES NOWDT                 	//No Watch Dog Timer
#FUSES INTRC_IO              	//Internal RC Osc, no CLKOUT
#FUSES NOPROTECT             	//Code not protected from reading
#FUSES BROWNOUT            	//No brownout reset
#FUSES NOMCLR                	//Master Clear pin used for I/O
#FUSES NOLVP                 	//No low voltage prgming, B3(PIC16) or B5(PIC18) used for I/O


#use delay(clock=4000000)
#use rs232(baud=9600,parity=N,xmit=PIN_B2,rcv=PIN_B1,bits=8,ERRORS)

