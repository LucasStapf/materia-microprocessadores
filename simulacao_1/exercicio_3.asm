	ORG	0
	MOV	DPTR,#DADOS2
	CLR	A
	MOVC	A,@A+DPTR
	MOV	0H,A
	INC	DPTR
	CLR	A
	MOVC	A,@A+DPTR
	MOV	DPTR,#1200H
	CJNE	A,0H,TESTE
	MOVX	@DPTR,A		; Se ambos os numeros forem iguais,
				; qualquer um deles pode ser salvo.
	SJMP	FIM
TESTE:	JC	MENOR		; Se o acumulador for menor.
	MOV	A,0H
MENOR:	MOVX	@DPTR,A
FIM:	SJMP	$

DADOS1:	DB	3AH,0A3H
DADOS2:	DB	1DH,0CH

	END
	