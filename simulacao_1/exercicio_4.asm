	ORG 	0
	MOV	DPTR,#1200h
	JB	P1.0,ON
	MOV	A,#0FFh
	SETB	P3.0
	CLR	P3.1
	SJMP	ESCRX
ON:	MOV	A,7Fh
	SETB	P3.1
	CLR	P3.0
ESCRX:	MOVX	@DPTR,A
FIM:	SJMP	$