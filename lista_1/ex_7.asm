; ***************************************** ;
; LISTA 1 - Ex7
; Lucas Carvalho Freiberger Stapf 11800559
; *********************************************************************************************************** ;
; Link da conta:
; https://www.wolframalpha.com/input?i=x+%3D+256+-+%281+*+11.0592+*+10+%5E+6%29%2F%28384+*+a%29%2C+a+%3D+9600
; *********************************************************************************************************** ;
	ORG	0h
N_EVEN	EQU	20h
N_ODD	EQU	21h
	SJMP	PROG

; ***************************************** ;
;		Programa Principal
; ***************************************** ;
PROG:
	SETB	EA			; Habilita interrupções
	MOV	TMOD, #00100000b	; Timer 1 no Modo 2 
	MOV	SCON, #01000000b	; Canal Serial no Modo 1
;	CLR	PCON.7			; PCON.7 é o SMOD => SMOD = 0 (K = 1 default) | SMOD = 1 (K = 2)
	MOV	R7, #10			; Número de dados
RD_DT:	MOV	DPTR, #DT
	DEC	R7
	MOV	A, R7
	MOVC	A, @A+DPTR		; Lê do último para o primeiro
	ACALL	SD_DT
	CJNE	R7, #0, RD_DT
	MOV	DPTR, #2030h		; Inicia a cópia da quantidade de números pares para mem. externa
	MOV	R0, #N_EVEN
	MOV	A, @R0
	MOVX	@DPTR, A
	MOV	DPTR, #2031h		; Inicia a cópia da quantidade de números ímpares para mem. externa
	MOV	R0, #N_ODD
	MOV	A, @R0
	MOVX	@DPTR, A
	SJMP	$

; ***************************************** ;
;	Sub-Rotina: SD_DT (Send Data)
; O dado a ser enviado deve estar armazenado
; no ACC.
; ***************************************** ;

SD_DT:
	MOV	B, #2
	MOV	R6, A			; Salva o dado lido no R6
	DIV	AB
	MOV	A, B
	CJNE	A, #0, ODD
EVEN:	MOV	R0, #N_EVEN
	MOV	A, @R0
	INC	A
	MOV	@R0, A
	MOV	P1, R6			; Envia o dado para a porta P1
	MOV	R5, #0FDh		; Valor a ser setado no Timer 1
	ACALL	TR_DT
	SJMP	END_SD
ODD:	MOV	R0, #N_ODD
	MOV	A, @R0
	INC	A
	MOV	@R0, A
	MOV	P2, R6			; Envia o dado para a porta P1
	MOV	R5, #0FAh		; Valor a ser setado no Timer 1
	ACALL	TR_DT
END_SD:	RET
	
; ***************************************** ;
;	Sub-Rotina: TR_DT (Transmit Data)
; O dado a ser transmitido deve estar no re-
; gistrador R6 e o valor do Timer 1 no R5.
; ***************************************** ;

TR_DT:
	MOV	TH1, R5
	MOV	TL1, R5
	SETB 	TR1			; Dispara Timer 1
	MOV	SBUF, R6		; Inicia a transmissão
	JNB	TI, $			; Espera o dado ser enviado
	CLR	TI			; Prepara para nova transmissão
	CLR	TR1
	RET
	
DT:	DB	1,2,3,4,5,6,7,8,10,12

	END
