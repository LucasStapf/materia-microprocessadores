; ********************************************************************** ;
; LISTA 1 - Ex4
; Lucas Carvalho Freiberger Stapf 11800559
; ********************************************************************** ;
;	Sensor 1:	INT0
;	Sendor 2:	INT1
;	Motor: 		P2.6 		(1 - ligado; 0 - desligado)
;	Dir: 		P2.7 		(1 - horário; 0 - anti-horário)
;	Forno: 		P1.2 		(1 - ligado; 0 - desligado)
;	Resfriamento:	P1.0		(1 - ligado; 0 - desligado)
;	
;	Contador:	R7
;	flag:		20h.0		(1 - levantada; 0 - abaixada)
; ********************************************************************** ;

	ORG	0h
	SJMP	PROG

	ORG	3h		; Interr. Externa 0
	SETB	20h.0
	RETI

	ORG	13h		; Interr. Externa 1
	SETB	20h.0
	RETI

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA		; Habilita interrupções

	SETB	EX0		; Habilita Interr. Externa 0
	SETB	IT0		; Habilita descida de borda

	SETB	EX1		; Habilita Interr. Externa 1
	SETB	IT1		; Habilita descida de borda

	MOV 	R7, #3h		; 3 repetições

CICLO:	SETB	P2.7		; Sentido horário
	SETB	P2.6		; Liga motor

	CLR	20h.0		; Material não chegou ao forno
	JNB	20h.0, $

	CLR	P2.6		; Desliga motor
	SETB	P1.2		; Liga forno
	ACALL	DLY_500		; Delay de 500 ms
	CLR	P1.2		; Desliga forno
	CLR	P2.7		; Sentido anti-horário
	SETB	P2.6		; Liga motor

	CLR	20h.0		; Material não chegou ao resfriador
	JNB	20h.0, $

	CLR	P2.6		; Desliga motor
	SETB	P1.0		; Ligar resfriamento
	ACALL	DLY_500		; Delay 500 ms

	DEC	R7
	
	CJNE	R7, #0, CICLO
	SJMP	$

; ***************************************** ;
;		Sub-Rotina de Delay
; ***************************************** ;
DLY_500:
	MOV	R3, #004h
	MOV	R2, #0E8h
	MOV	R1, #00Dh
	MOV	R0, #0CDh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	DJNZ	R3, $-13
	MOV	R1, #00Bh
	MOV	R0, #079h
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	RET

	END