#include <16F628.h>
#FUSES NOWDT, INTRC_IO, NOPUT, NOPROTECT, BROWNOUT, NOMCLR, NOLVP, NOCPD
#use delay(clock=4000000)
#use rs232(baud=9600,parity=N,xmit=PIN_B2,rcv=PIN_B1,bits=9,stream=serial,errors)

