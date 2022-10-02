; ***************************************** ;
; LISTA 1 - Ex2
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
	SJMP	PROG

	ORG	3h		; Int. Externa 0
	SJMP	INT_0
	
	ORG	13h		; Int. Externa 1
	SJMP	INT_1
	
	ORG	1Bh		; Overflow Timer 1
	SJMP	TIMER_1

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA

	SETB	EX0		; Ativa Ext. 0
	SETB	IT0		; Descida de Borda
	SETB	PX0		; Ativa alta prioridade
	
	SETB	EX1		; Ativa Ext. 1
	SETB	IT1		; Descida de Borda
	SETB	PX1		; Ativa alta prioridade

	SETB	ET1		; Habilita o Timer 1
	MOV	TMOD,#00010000b	; Timer 1 no Modo 1

	MOV 	TH1,#0ECh	; Timer: 5 ms
	MOV	TL1,#077h	
	SETB	TR1		; Ativa o Timer 1
	
	SJMP	$

; ***************************************** ;
;		Interrupção do Ext 0
; ***************************************** ;

INT_0:
	CLR	EA
	MOV	DPTR,#4000h
	MOVX	A,@DPTR
	MOV	DPTR,#4200h
	MOVX	@DPTR,A
	SETB	EA
	RETI

; ***************************************** ;
;		Interrupção do Ext 1
; ***************************************** ;

INT_1:
	CLR	EA
	MOV	DPTR,#4200h
	MOVX	A,@DPTR
	MOV	P1,A
	SETB	EA
	RETI

; ***************************************** ;
;		Interrupção do Timer1
; ***************************************** ;

TIMER_1:
	CLR	EA

	MOV	TH1,#0ECh
	MOV	TL1,#078h
	
	MOV	A,P2
	MOV	DPTR,#4000h
	MOVX	@DPTR,A

	SETB	EA
	RETI

	END
	