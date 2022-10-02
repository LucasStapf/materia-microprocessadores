; ***************************************** ;
; LISTA 1 - Ex9
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
	SJMP	PROG

	ORG	3h		; Externa 0
	SJMP	MOEDA

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA
	SETB	EX0
	SETB	IE0
	CLR	A
	SJMP	$

; ***************************************** ;
;	Sub-rotina: Moeda
; ***************************************** ;

MOEDA:
	ACALL	TIPO
	ADD	A, R7
	CJNE	A, #014h, VERIF
	SETB	P2.0		; Dar o doce
	RETI
VERIF:	JC	END_M
	ACALL	TROCO
END_M:	RETI

; ***************************************** ;
;	Sub-rotina: Tipo de Moeda
; ***************************************** ;

TIPO:
	JNB	P1.2, M_20
	JNB	P1.1, M_10
	JNB	P1.0, M_5
M_20:	MOV	R7, #014h
	RET
M_10:	MOV	R7, #00Ah
	RET
M_5:	MOV	R7, #005h
	RET

; ***************************************** ;
;	Sub-rotina: Dar Troco
; ***************************************** ;

TROCO:

T_10_5:	CJNE	A, #023h, T_10		; 35
	SETB	P2.2
	SETB	P2.1
	RET
T_10:	CJNE	A, #01Eh, T_5		; 30
	SETB	P2.2
	RET
T_5:	SETB	P2.1			; 25
	RET
	
	END