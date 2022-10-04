; ***************************************** ;
; PROVA 1 - 2017 - Ex2
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
FLAG_P	EQU	20h.0
	SJMP 	PROG

	ORG	23h			; Interrupção serial
	SJMP	REC

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA
	SETB	ES			; Ou IE.4, habilita interrupção serial
	MOV	TMOD, #00100000b	; Timer 1 no Modo 2
	MOV	SCON, #01000000b	; Serial no Modo 1
	MOV	TH1, #255		; Ajustar o cristal para o valor 255 do Timer
	MOV	TL1, #255		
	SETB	TR1
	SETB	REN			; Habilita recepção
LOOP:	JB	FLAG_P, SOS		; Verifica se é o SOS que deve ser enviado
	ACALL	DLY_4
	MOV	DPTR, #MSG_1
RD_1:	CLR	A
	MOVC	A,@A+DPTR
	JZ	LOOP
	ACALL	TR_CH
	INC	DPTR
	SJMP	RD_1
SOS:	ACALL	DLY_2
	ACALL	DLY_2
	MOV	DPTR, #MSG_2
RD_2:	CLR	A
	MOVC	A,@A+DPTR
	JZ	LOOP
	ACALL	TR_CH
	INC	DPTR
	SJMP	RD_2
	
; ***************************************** ;
;		Interrupção Serial
; ***************************************** ;

REC:
	CLR	EA
	JNB	TI, INT_R		; Verifica se foi recepção
	CLR	TI
	SJMP	END_R
INT_R:	MOV	A, SBUF
	CLR	RI
	CJNE	A, #'P', END_R		; Verifica se o dado é a letra 'P'
	SETB	FLAG_P
END_R:	SETB	EA
	RETI

; ***************************************** ;
;	Sub-Rotina: TR_CH (Transmit Char)
; O dado a ser enviado deve estar no ACC
; ***************************************** ;

TR_CH:
	MOV	SBUF, A
	JNB	TI, $
	CLR	TI
	RET
	
; ***************************************** ;
;	Sub-Rotina: DLY_2 (Delay 2ms)
; ***************************************** ;
DLY_2:
	MOV	R1, #009h
	MOV	R0, #06Dh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	NOP
	RET

; ***************************************** ;
;	Sub-Rotina: DLY_4 (Delay 4ms)
; ***************************************** ;
DLY_4:
	MOV	R1, #009h
	MOV	R0, #0DCh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	NOP
	NOP
	NOP
	RET

MSG_1:	DB	'OK',0
MSG_2:	DB	'SOS',0

	END