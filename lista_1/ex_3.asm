; ***************************************** ;
; LISTA 1 - Ex3
; Lucas Carvalho Freiberger Stapf 11800559
; ***************************************** ;
;	P0.7	|		|
;	P0.6	|		|
;	P0.5	|		|
;	P0.4	|		S2 => Sensor 2
;	P0.3	|%%%%%%%%%%%%%%%|
;	P0.2	|%%%%%%%%%%%%%%%S1 => Sensor 1
;	P0.1	|%%%%%%%%%%%%%%%|
;	P0.0	|%%%%%%%%%%%%%%%|
;		-----------------
;	P2.0: Sensor 1
;	P2.1: Sensor 2
;	P1.0: Válvula 1
;	P1.1: Válvula 2
; ***************************************** ;

	ORG	0h
	SJMP	PROG

	ORG	3h		; Int. Externa 0
	SJMP	SENSOR_1
	
	ORG	13h		; Int. Externa 1
	SJMP	SENSOR_2

; ***************************************** ;
;		Programa Principal
; ***************************************** ;

PROG:
	SETB	EA

	SETB	EX0
	SETB	IT0
	SETB	EX1
	SETB	IT1

	CLR	P1.0		; Fecha válvula 1
	SETB	P1.1		; Abre válvula 2
	
	JNB	P2.0,$		; Encher o tanque
	CLR	P1.1		; Fecha válvula 2
	
	SJMP	$
	
; ***************************************** ;
;		Interrupção do Sensor 1
; ***************************************** ;

SENSOR_1:
	JB	P2.0,ENDS_1	; Retorna caso o sensor já esteja dentro d'água
	CLR	P1.0		; Fecha válvula 1
	SETB	P1.1		; Abre válvula 2
	JNB	P2.0,$		; Enquanto a água não acionar o sensor 1
	CLR	P1.1		; Fecha válvula 2
ENDS_1:	RETI

; ***************************************** ;
;		Interrupção do Sensor 2
; ***************************************** ;

SENSOR_2:
	JNB	P2.1,ENDS_2	; Caso o sensor já esteja fora d'água
	CLR	P1.1		; Fecha válvula 2
	SETB	P1.0		; Abre válvula 1
	JB	P2.1,$		; Enquanto o sensor 2 não for desativado
	CLR	P1.0		; Fecha válvula 1
ENDS_2:	RETI

	END

	