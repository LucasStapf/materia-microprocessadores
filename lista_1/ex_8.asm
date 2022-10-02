; ***************************************** ;
; LISTA 1 - Ex8
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
	SJMP	PROG
	
	ORG	3h		; Interr. Externa 0
	ACALL	ALT_DIR
	
; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA		; Habilita interrupções

	SETB	EX0		; Habilita interrupção externa 0
	SETB	IT0		; Borda de descida

	SETB	20h.0		; 20h.0 = 1 (próximo movimento é direita); 20h.0 = 0 (próximo movimento é esquerda)

	ACALL 	MOV_F

	SJMP	$

; ***************************************** ;
;	Sub-rotina: Movimentar para frente
; ***************************************** ;

MOV_F:
	SETB	P1.1
	SETB	P1.3
	RET

; ***************************************** ;
;	Sub-rotina: Alterar direção
; ***************************************** ;

ALT_DIR:
	CLR	EA

	CLR	P1.1		; Ré
	CLR	P1.3
	ACALL	DLY_2S		; Duração da ré

	JB	20h.0, MOV_D	
MOV_E:	SETB	P1.3
	SJMP	END_IN
MOV_D:	SETB	P1.1

END_IN:	ACALL	DLY_2S
	CPL	20h.0
	
	SETB	EA
	ACALL	MOV_F
	RET

; ***************************************** ;
;	Sub-rotina: Delay de 2s
; ***************************************** ;

DLY_2S:
	MOV	R3, #003h
	MOV	R2, #0D2h
	MOV	R1, #00Ch
	MOV	R0, #082h
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	DJNZ	R3, $-13
	MOV	R1, #006h
	MOV	R0, #0BAh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	NOP
	NOP
	NOP
	RET
	
	END