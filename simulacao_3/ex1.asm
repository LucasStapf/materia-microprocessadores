; **************************************** ;
; SIMULAÇÃO 3
; Lucas Carvalho Freiberger Stapf 11800559
; **************************************** ;

	ORG	0
	SJMP	PROG

	ORG	0Bh
	SJMP	SUB0

	ORG	1Bh
	SJMP	SUB1

PROG:
	MOV	P1,#0
	SETB	ET1
	SETB	ET0
	MOV	TMOD,#11h
	MOV	TH1,#0FFh
	MOV	TL1,#0FBh
	MOV	TH0,#0FFh
	MOV	TL0,#0FBh
	SETB	EA
	MOV	TCON,#01010000b
	SJMP	$

SUB0:
	CPL	P1.0
	MOV	TH0,#0FFh
	MOV	TL0,#0FBh
	RETI

SUB1:
	CPL	P1.1
	MOV	TH1,#0FFh
	MOV	TL1,#0FBh
	RETI

	END