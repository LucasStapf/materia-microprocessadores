; ***************************************** ;
; LISTA 1 - Ex1
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;

	ORG	0h
	SJMP	PROG

	ORG	1Bh
	SJMP	DELAY

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA		; Habilita interrupção externa
	SETB	ET1		; Habilita o timer 1

	MOV	TMOD,#00010000b	; T1 no modo 1

	MOV	DPTR,#DLY_05

	CLR	A
	MOVC	A,@A+DPTR
	MOV	R1,A

	CLR	A
	INC	DPTR
	MOVC	A,@A+DPTR
	MOV	R2,A

	CLR	A
	INC	DPTR
	MOVC	A,@A+DPTR
	MOV	R3,A

	CLR	A
	INC	DPTR
	MOVC	A,@A+DPTR
	MOV	R4,A

	CLR	A
	INC	DPTR
	MOVC	A,@A+DPTR
	MOV	R5,A
	
	MOV	TH1,R1
	MOV	TL1,R2
	MOV	A,R3
	MOV	R0,A	

	SETB	TR1
	
	CJNE	R0,#0,$
	CLR	P0.0		; Acender LED
	SJMP	$
	
; ***************************************** ;
;		Interrupção do Timer1
; ***************************************** ;
DELAY:
	MOV	TH1,R4
	MOV	TL1,R5
	DEC	R0
	RETI

; ***************************************** ;
;		Dados
; ***************************************** ;
;		R1  ,R2  ,R3 ,R4  ,R5
;		TH  ,TL  ,REP,RH  ,RL
; ***************************************** ;
DLY_05:	DB	03Ch,0AFh,01h,03Ch,0B0h
DLY_5:	DB	00Bh,0D4h,08h,00Bh,0DCh
DLY5:	DB	002h,007h,4Dh,002h,059h
	
	END
	