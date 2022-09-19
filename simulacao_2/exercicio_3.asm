; ******************************* ;
; Lucas Carvalho Freiberger Stapf
; NUSP 11800559
; ******************************* ;

; ************************************** ;
; A esteira é simulada pelos LEDs. O LED
; que estiver ligado indica a posição do
; pacote. LEDs estão ligados na porta P1.
; ************************************** ;

	ORG	0
	SJMP	PROG

	ORG	3h
	ACALL	INV_MOV
	RETI

	ORG	13h
	ACALL	INV_MOV
	RETI

PROG:
	SETB	EA
	SETB	IE.0
	SETB	IT0
	SETB	IE.2
	SETB	IT1

	SETB	P2.7
	CLR	P2.1
	
	CLR	P1.0
	MOV 	A,P1

ESQ:	JB	P2.1, DIR
	ACALL	MOV_ESQ
	SJMP	ESQ
DIR:	JB	P2.7, ESQ
	ACALL	MOV_DIR
	SJMP	DIR
	
MOV_ESQ:
	RL	A
	MOV 	P1, A
	ACALL 	DLY_LED
	RET
	
MOV_DIR:
	RR	A
	MOV	P1, A
	ACALL	DLY_LED
	RET

DLY_LED:
	CLR 	EA
	MOV	R0, #0E4h
	NOP
	DJNZ	R0, $
	NOP
	NOP
	NOP
	SETB 	EA
	RET

INV_MOV:
	CPL	P2.1
	CPL	P2.7

	CLR	EA
	JB	P1.7, DLY_10S 
DLY_5s:
	MOV	R1, #02Fh
	MOV	R0, #02Fh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	NOP
	SJMP	END_INV
DLY_10s:
	MOV	R2, #002h
	MOV	R1, #087h
	MOV	R0, #00Fh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	MOV	R0, #00Dh
	DJNZ	R0, $
	NOP
END_INV:
	SETB	EA
	RET
	
	END