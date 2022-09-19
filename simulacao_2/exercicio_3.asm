; ******************************* ;
; Lucas Carvalho Freiberger Stapf
; NUSP 11800559
; ******************************* ;

; ************************************* ;
; P1.7(0) esteira posicionada na esquerda
; P1.0(0) esteira posicionada na direita
; ************************************* ;

	ORG	0
	SJMP	PROG

	ORG	0003h
	RETI

PROG:
	SETB	EA
	SETB	IE.0
	SETB	IE0
	CLR	P1.0 	

INV_ROT:
	CPL	P2.1
	CPL	P2.7
	RET

DLY_1s:

DLY_5s:

	END