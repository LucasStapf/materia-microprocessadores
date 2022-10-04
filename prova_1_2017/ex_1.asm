; ***************************************** ;
; PROVA 1 - 2017 - Ex1
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
	SJMP	PROG

	ORG	3h			; Interrupção Externa 0
	SJMP	EXT_0
	
	ORG	1Bh			; Overflow Timer 1
	SJMP	TMR_1

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	FLG	EQU	20h		; 0 - Não contou 200 | 1 - 200 rotações
	DIR	EQU	21h		; 1 - Anti-horário | 0 - Horário
	COUNT	EQU	22h
	TMS	EQU	2

	SETB	EA			; Habilita interrupções
	SETB	EX0			; Habilita Externa 0
	SETB	IT0			; Descida de Borda
	SETB	ET1			; Habilita interrupção Contador 1
	MOV	TMOD, #01010000b	; Contador 1 no Modo 1
	MOV	TH1, #0FFh		; Carrega valor 65335 para contar 200.
	MOV	TL1, #037h
	SETB	TR1
	MOV	P2, #00001000b

LOOP:	ACALL	LEDS
	JNB	FLG, LOOP
	SJMP	$
	
; ***************************************** ;
;		Interrupção do Timer 1
; ***************************************** ;

TMR_1:
	CLR	EA
	MOV	P2, #0FFh
	SETB	FLG
	SETB	EA
	RETI
	
; ***************************************** ;
;		Interrupção da Ext 0
; ***************************************** ;

EXT_0:
	MOV	A, P2
	CJNE	A, #0, CONT_0
	SETB	P2.7
CONT_0:	MOV	R0, #COUNT
	MOV	A, @R0
	CJNE	A, #TMS, NOT_IV		; Verifica o valor do contador
	CPL	DIR
	MOV	R0, #COUNT
	MOV	@R0, #0			; Zera contador
	RETI
NOT_IV:	MOV	R0, #COUNT
	INC	A
	MOV	@R0, A
	RETI

; ***************************************** ;
;		Sub-Rotina: LEDS
; ***************************************** ;

LEDS:	
	ACALL 	DLY
	MOV	R0, #COUNT
	MOV	A, @R0
	CJNE	A, #TMS, ROT		; Verifica o valor do contador
	JNB	P2.7, ROT		; Se não for o LED P2.7 rotacionar normalmente.
	CLR	P2.7			; Ativa interrupção
	RET
ROT:	MOV	A, P2
	JB	DIR, L
R:	RR	A
	MOV	P2, A
	RET
L:	RL	A
	MOV	P2, A
	RET

; ***************************************** ;
;		Sub-Rotina: DLY (0.1ms)
; ***************************************** ;

DLY:
	MOV	R0, #031h
	NOP
	DJNZ	R0, $
	RET
	END