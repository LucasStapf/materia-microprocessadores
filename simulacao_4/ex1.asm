; **************************************** ;
; SIMULAÇÃO 4
; Lucas Carvalho Freiberger Stapf 11800559
; **************************************** ;

	ORG	0h	; Main
FLAG_P	EQU	20h.0
	SJMP	MAIN

	ORG	3h	; Int. 0
	SJMP	INT_0	

	ORG	13h	; Int. 1
	SJMP	INT_1

MAIN:		SETB	EA
	SETB	EX0
	SETB	IT0	
	SETB	EX1
	SETB	IT1
	
BEGIN:	MOV	R0, #00
LOOP:	JB	FLAG_P, $
	MOV	A, R0
	CJNE	A, #64h, TEST
TEST:	JNC	BEGIN
	INC	R0
	ACALL	CONVBCD
	CPL	A
	MOV	P2, A
	ACALL	DLY_200u
	SJMP	LOOP

INT_0:		CLR	EA
	MOV	R0, #00
	MOV	A, #0FFh
	MOV	P2, A
	CLR	FLAG_P
	SETB	EA
	RETI

INT_1:		CLR	EA
	SETB	FLAG_P
	SETB	EA
	RETI

CONVBCD:	MOV	B, #0Ah
	DIV	AB
	MOV	R2, A
	MOV	R1, B
	SWAP	A
	ORL	A, R1
	RET

DLY_200u:	MOV	R1, #063h
	NOP
	DJNZ	R1, $
	RET
	
	END