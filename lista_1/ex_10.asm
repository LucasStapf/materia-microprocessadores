; ***************************************** ;
; LISTA 1 - Ex10
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
	SJMP	PROG

	ORG	0Bh		; Timer 0
	SJMP	TMR_0

	ORG	1Bh		; Timer 1
	SJMP	TMR_1

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA

	SETB	ET0
	SETB	ET1

	MOV	TMOD, #00010001b

	MOV	TH0, #0F8h		; 63535
	MOV	TL0, #02Fh

	MOV	TH1, #0F0h		; 61535
	MOV	TL1, #05Fh

	MOV	DPTR, #DADOS

	CLR	A
	MOVC	A, @A+DPTR
	MOV	R3, A		; R3 guarda o número de dados
	MOV	R6, A		; Contador para o Timer 0
	MOV	R7, A		; Contador para o Timer 1
	
	SETB	TR0
	SETB	TR1

	SJMP	$
; ***************************************** ;
;		Interrupção da Ext 0
; ***************************************** ;

TMR_0:
	CJNE	R6, #0, CONT_0		; Leu todos os dados se for igual
	CLR	TR0
	RETI
CONT_0:	MOV	TH0, #0F8h		; 63535
	MOV	TL0, #02Fh
	MOV	A, R3			; Pegar o índice do próximo dado
	CLR	C		
	SUBB	A, R6			; Acumulador guarda o índice
	INC	A			; Dados começam no índice 1
	MOV	DPTR, #DADOS		; Aponta pro começo dos Dados
	MOVC	A, @A+DPTR
	MOV	R2, A			; Dado armazenado
	MOV	DPTR, #2000h		; Aponta o DPTR para o memória externa 2000h
	MOV	A, R3			; Pegar o índice do próximo dado
	CLR	C		
	SUBB	A, R6			; Acumulador guarda o índice
	ADD	A, DPL			; Incrementa o byte menos significativo do DPTR
	MOV	DPL, A
	MOV	A, R2
	MOVX	@DPTR, A
	DEC	R6
	RETI

; ***************************************** ;
;		Interrupção da Ext 1
; ***************************************** ;
	
TMR_1:
	CJNE	R7, #0, CONT_1
	CLR	TR1
	RETI
CONT_1:	MOV	TH1, #0F0h		; 61535
	MOV	TL1, #05Fh
	MOV	A, R3			; Pegar o índice do próximo dado
	CLR	C		
	SUBB	A, R7			; Acumulador guarda o índice
	MOV	DPTR, #2000h
	ADD	A, DPL
	MOV	DPL, A
	MOVX	A, @DPTR
	MOV	R2, A			; Dado salvo no R2
	MOV	R0, #30h
	MOV	A, R3			; Pegar o índice do próximo dado
	CLR	C		
	SUBB	A, R7			; Acumulador guarda o índice
	ADD	A, R0
	MOV	R0, A
	MOV	A, R2
	MOV	@R0, A
	DEC	R7
	RETI
	
DADOS:	DB	06h,20h,21h,22h,2Ah,2Bh,2Ch

	END