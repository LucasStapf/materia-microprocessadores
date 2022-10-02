; ***************************************** ;
; LISTA 1 - Ex6
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
	SJMP	PROG
	
	ORG	3h			; Interr. Externa 0
	SJMP	EXT_0
	
	ORG	0Bh			; Overflow Timer 0
	SJMP	TMR_0
	
	ORG	13h			; Interr. Externa 1
	SJMP	EXT_1
	
	ORG	1Bh			; Overflow Timer 1
	SJMP	TMR_1

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA			; Habilita interrupções

	SETB	EX0			; Habilita externa 0
	SETB	IT0			; Descida de borda 0
	SETB	PX0			; Habilita alta prioridade à externa 0

	SETB	EX1			; Habilita externa 1
	SETB	IT1			; Descida de borda 1
	CLR	PX1			; Baixa prioridade para externa 1

	SETB	ET0			; Habilita timer 0
	SETB	PT0			; Habilita alta prioridade ao timer 0
	
	SETB	ET1			; Habilita timer 1
	CLR	PT1			; Baixa prioridade ao timer 1

	MOV	TMOD, #00010001b	; Timer 0 modo 1 - Timer 1 modo 1

	MOV	TH0, #0D8h		; Timer 0 - 10 ms
	MOV	TL0, #0EFh

	MOV	TH1, #015h		; Timer 1 - 60 ms
	MOV	TL1, #09Fh

	SETB	TR0			; Dispara timer 0
	SETB 	TR1			; Dispara timer 1
	
	SJMP	$

; ***************************************** ;
;		Interrupção da Ext 0
; ***************************************** ;

EXT_0:
	CLR	EA
	MOV	DPTR, #5000h
	MOVX	A, @DPTR
	XCH	A,P1
	MOVX	@DPTR, A
	SETB	EA
	RETI

; ***************************************** ;
;		Interrupção da Ext 1
; ***************************************** ;

EXT_1:
	CLR	EA
	MOV	DPTR, #5000h
	MOVX	A, @DPTR
	MOV	07Fh, A
	SETB	EA
	RETI

; ***************************************** ;
;		Interrupção do Timer 0
; ***************************************** ;

TMR_0:
	CLR	EA

	MOV	TH0, #0D8h		; Timer 0 - 10 ms
	MOV	TL0, #0F0h
	
	MOV	A, 07Fh
	MOV	DPTR, #5200h
	MOVX	@DPTR, A
	SETB	EA
	RETI

; ***************************************** ;
;		Interrupção do Timer 1
; ***************************************** ;

TMR_1:
	CLR	EA
	
	MOV	TH1, #015h		; Timer 1 - 60 ms
	MOV	TL1, #0A0h

	MOV	DPTR, #5200h
	MOVX	A, @DPTR
	MOV	DPTR, #5000h
	MOVX	@DPTR, A
	SETB	EA
	RETI
	
	END
	